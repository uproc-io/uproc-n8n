#!/bin/bash
# create-n8n-pr.sh
#
# This script:
# 1. Clones (or updates) a fork of n8n-io/n8n
# 2. Syncs from upstream (n8n-io/n8n) to get the latest official code
# 3. Adds the UProc node from developments/n8n/
# 4. Creates a PR to n8n-io/n8n/main
#
# Usage: ./create-n8n-pr.sh [version]
#   version: optional, defaults to 0.1.0
#
# Requirements:
#   - gh CLI installed and authenticated
#   - n8n-io/n8n fork in uproc-io organization
#   - developments/n8n/ with the latest UProc code

set -euo pipefail

# Configuration
UPSTREAM_REPO="n8n-io/n8n"
FORK_ORG="uproc-io"
FORK_NAME="n8n-fork"
FORK_PATH="n8n-fork"
NODE_DIR="packages/nodes-base/nodes/uproc"
CRED_DIR="packages/nodes-base/credentials/uproc"
Uproc_SRC="$(cd "$(dirname "$0")" && pwd)"

VERSION="${1:-0.1.0}"

echo "=== UProc n8n Node - PR Creator ==="
echo ""
echo "Source:  $Uproc_SRC (developments/n8n)"
echo "Fork:    https://github.com/$FORK_ORG/$FORK_NAME"
echo "Target:  https://github.com/$UPSTREAM_REPO"
echo "Version: $VERSION"
echo ""

# 1. Check gh CLI
if ! command -v gh &> /dev/null; then
  echo "❌ gh CLI is not installed. Install with: brew install gh"
  exit 1
fi

# 2. Check authentication
echo "→ Checking GitHub authentication..."
AUTH_CHECK=$(gh auth status 2>&1) || {
  echo "❌ Not authenticated to GitHub. Run: gh auth login"
  exit 1
}
echo "✅ GitHub authenticated"

# 3. Clone or update the fork
if [ -d "$FORK_PATH" ]; then
  echo ""
  echo "→ Updating existing fork at $FORK_PATH..."
  cd "$FORK_PATH"
else
  echo ""
  echo "→ Cloning fork of $UPSTREAM_REPO to $FORK_PATH..."
  cd ..
  gh repo fork "$UPSTREAM_REPO" "$FORK_ORG/$FORK_NAME" --clone --fork-name "$FORK_NAME" || {
    echo "❌ Failed to clone. Try: gh repo create $FORK_ORG/$FORK_NAME"
    exit 1
  }
  cd "$FORK_PATH"
fi

# 4. Sync from upstream (latest official n8n code)
echo ""
echo "→ Syncing with upstream ($UPSTREAM_REPO)..."

# Add upstream if not present
if ! git remote get-url upstream >/dev/null 2>&1; then
  git remote add upstream "https://github.com/$UPSTREAM_REPO.git"
fi

# Fetch latest from upstream
git fetch upstream >/dev/null 2>&1

echo "→ Merging upstream/main..."
git merge upstream/main || {
  echo ""
  echo "⚠️  Merge conflicts detected!"
  echo "   Fix them manually, then run: git add -A && git commit -m 'merge upstream'"
  echo "   Then re-run this script."
  exit 1
}

echo "✅ Fork synced with latest upstream/main"

# 5. Create feature branch
echo ""
BRANCH_NAME="feat/uproc-node-$VERSION"
echo "→ Creating branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

# 6. Copy UProc node code
echo ""
echo "→ Copying UProc node code..."

mkdir -p "$NODE_DIR/UProc"
mkdir -p "$CRED_DIR"

# Copy credentials
cp "$Uproc_SRC/credentials/UProcApi.credentials.ts" "$CRED_DIR/"

# Copy nodes
cp "$Uproc_SRC/nodes/UProc/UProc.node.ts" "$NODE_DIR/UProc/"
cp "$Uproc_SRC/nodes/UProc/uProc.resource.ts" "$NODE_DIR/UProc/"

# Copy icons (if any)
if [ -d "$Uproc_SRC/icons" ]; then
  cp "$Uproc_SRC/icons/"*.svg "$NODE_DIR/UProc/" 2>/dev/null || true
fi

# 7. Update n8n index files
echo ""
echo "→ Registering UProc node in n8n..."

# Add to nodes index
NODES_INDEX="packages/nodes-base/index.ts"
if ! grep -q "from.*nodes/uproc/UProc/UProc" "$NODES_INDEX" 2>/dev/null; then
  echo "" >> "$NODES_INDEX"
  echo "" >> "$NODES_INDEX"
  echo "// UProc node" >> "$NODES_INDEX"
  echo "export { UProc } from './nodes/uproc/UProc/UProc';" >> "$NODES_INDEX"
  echo "export { UProcApi } from './nodes/uproc/credentials/UProcApi.credentials';" >> "$NODES_INDEX"
fi

# 8. Create credentials index
CREDS_INDEX="$CRED_DIR/index.ts"
if [ ! -f "$CREDS_INDEX" ]; then
  echo "export { UProcApi } from './UProcApi.credentials';" > "$CREDS_INDEX"
fi

# 9. Create nodes index for uproc
NODES_INDEX_U="$NODE_DIR/UProc/index.ts"
if [ ! -f "$NODES_INDEX_U" ]; then
  echo "export { UProc } from './UProc.node';" > "$NODES_INDEX_U"
fi

# 10. Commit changes
echo ""
echo "→ Committing changes..."
git add -A
git commit -m "feat: add UProc node v$VERSION

- UProc API credential (email + API key, Basic Auth)
- UProc node with 11 categories (audio, communication, company,
  finance, geographic, image, internet, personal, product, security, text)
- Dynamic tool selection via /process endpoint
- Based on UProc v$VERSION"

# 11. Push to fork
echo ""
echo "→ Pushing to $FORK_ORG/$FORK_NAME..."
git push origin "$BRANCH_NAME"

# 12. Create PR
echo ""
echo "→ Creating PR to $UPSTREAM_REPO..."
PR_URL=$(gh pr create \
  --base main \
  --head "$BRANCH_NAME" \
  --repo "$UPSTREAM_REPO" \
  --title "feat: add UProc node v$VERSION" \
  --body "## UProc Node for n8n

This PR adds the official UProc integration node to n8n.

### What is UProc?

[www.uproc.io](https://www.uproc.io) is a multipurpose data platform that offers 400+ tools for:

- **Email validation** (check-email-exists, check-email-exists-extended)
- **Company lookup** (get-company-financial-by-name, get-company-info-by-name)
- **IBAN/bank validation** (check-bank-iban-valid)
- **Geographic data** (IP geolocation, address validation, country lookup)
- **Personal data** (person lookup, social media profiles)
- **Security** (IP reputation, threat detection)
- And many more...

### Categories (Resources)

| Resource | Description |
|----------|-------------|
| Audio | Audio processing tools |
| Communication | Email validation, phone lookup, SMS verification |
| Company | Company information, financial data, employee lookup |
| Finance | IBAN validation, bank lookup, financial checks |
| Geographic | IP geolocation, address validation, country lookup |
| Image | Image processing tools |
| Internet | Domain information, website checks |
| Personal | Person lookup, social media profiles |
| Product | Product information tools |
| Security | IP reputation, threat detection |
| Text | Text processing tools |

### Authentication

Uses UProc's API Key authentication (email + API key). Users can obtain credentials from [app.uproc.io](https://app.uproc.io/#/signup) → Settings → Integrations.

### Features

- Dynamic tool selection from all 11 categories
- All tools available through /process endpoint
- Proper error handling with continueOnFail support
- TypeScript with strict mode
- Follows n8n node development guidelines

### Version History

- 0.1.0 (2026-06-07) — Initial UProc node with all 400+ tools

### Links

- [UProc website](https://www.uproc.io)
- [UProc API Docs](https://docs.uproc.io)
- [Tool Catalog](https://app.uproc.io/app/catalog)

---

**Author:** UProc (miquel@uproc.io)
" 2>&1)

echo ""
echo "✅ PR created successfully!"
echo ""
echo "🔗 $PR_URL"
echo ""
echo "=== Done ==="
echo ""
echo "Next steps:"
echo "  1. Review the PR at the URL above"
echo "  2. Respond to any review comments"
echo "  3. Wait for n8n team review"
echo "  4. If approved, the merge will be automatic"
echo ""
echo "To create a new version PR:"
echo "  cd developments/n8n"
echo "  ./create-n8n-pr.sh <new-version>"
echo ""