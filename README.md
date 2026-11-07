# Uproc Node for n8n

> Official [Uproc](https://uproc.io) node for [n8n](https://n8n.io) — **the source code for the n8n community node** published at [n8n.io/integrations/uproc](https://n8n.io/integrations/uproc).
>
> **🔗 469 Data Tools Catalog:** [uproc.io/applications/data-validation/tools](https://uproc.io/applications/data-validation/tools)

This repository contains the complete source code for the Uproc node that powers n8n workflows with 400+ data processing tools.

**Official n8n node:** [n8n.io/integrations/uproc](https://n8n.io/integrations/uproc) — this repo is the source code for that node. All changes are submitted as PRs to the [n8n-io/n8n](https://github.com/n8n-io/n8n) repository where the node lives in `packages/nodes-base/nodes/uproc/`.

**This is the official source code repository** for the Uproc node on n8n. All changes in this repo are eventually submitted as a PR to the [n8n-io/n8n](https://github.com/n8n-io/n8n) repository, where the node lives in the `packages/nodes-base/nodes/uproc/` directory and gets published with every n8n release.

## Available Tools

Uproc exposes **469 data validation, enrichment and transformation tools** across 12 categories:

| Category | Count | Examples |
|----------|-------|----------|
| **Audio** | 3 | Speech by text, Text by speech, Advanced speech by text |
| **Communication** | 70 | Email exists, Mobile lookup, LinkedIn profiles, Social networks |
| **Company** | 42 | Company by CIF/domain/name, Financial data, Decision makers, Social profiles |
| **Finance** | 29 | IBAN validation, BIC lookup, Crypto wallet, VAT, Currency conversion |
| **Geographic** | 83 | Address validation, Coordinates, Air quality, City/Zipcode/Phone lookup |
| **Image** | 8 | OCR, QR code decode/encode, Barcode, EXIF metadata, Screenshot |
| **Internet** | 51 | Domain check, Whois, DNS, IP lookup, URL analysis, Technologies |
| **Numbers** | 12 | Prime, Even/Odd, Valid decimal, Modulus, Number comparison |
| **Personal** | 58 | Name validation, DNI/NIE/NIF, Age ranges, Person lookup, LinkedIn/Twitter URI |
| **Product** | 37 | ISBN, EAN, UPC, VIN, ASIN, Book lookup, Product by barcode |
| **Security** | 5 | Luhn/UUID, Password strength, Domain/IP blacklists |
| **Text** | 71 | String validation, List operations, Sentiment, Markdown/HTML, Translation, Hashing |

👉 **See the full catalog with descriptions and pricing:** [Uproc Data Tools](https://uproc.io/applications/data-validation/tools)

## Features

This node exposes Uproc's data processing capabilities across multiple categories:

- **Communication** — Email validation, phone number lookup, SMS verification
- **Company** — Company information lookup, financial data, employee data
- **Finance** — IBAN validation, bank lookup, financial checks
- **Geographic** — IP geolocation, address validation, country lookup
- **Personal** — Person lookup, social media profile data
- **Internet** — Domain information, website checks
- **Security** — IP reputation, threat detection
- **And more** — Audio, Image, Product, Text, and other categories

## Installation

Follow the [installation guide](https://docs.n8n.io/integrations/community-nodes/installation/) in the n8n community nodes documentation.

## Authentication

This node uses Uproc's API Key authentication.

### Prerequisites

1. Create a Uproc account at [app.uproc.io/account/integrations](https://app.uproc.io/account/integrations/#/signup)
2. Navigate to **Settings → Integrations** in your Uproc account
3. Copy your **Username** (email) and **API Key (real)**

### Setup

1. Add a new credential in n8n
2. Select **Uproc API** credential type
3. Enter your **Email** and **API Key**
4. Save the credential

### Required credentials

| Credential | Required | Description |
|------------|----------|-------------|
| Email | Yes | Your Uproc account email |
| API Key | Yes | Your real API key from Settings → Integrations |

## Operations

This node supports the following operations per resource (category):

### All Resources (Communication, Company, Finance, etc.)

- **Execute** — Run a specific tool/processor with custom parameters

Each tool has its own set of parameters. Use the tool selector to choose a specific processor, then fill in the required parameters.

## Compatibility

- **Minimum n8n version**: 1.0.0
- **n8n Nodes API Version**: 1
- **Tested against**: Latest n8n versions
- **Node.js version**: Node.js v22+ (development), Node.js 18+ (runtime)

## Usage

### Basic example: Email validation

1. Add a **Uproc** node to your workflow
2. Select the **Communication** resource and **Check email exists** tool
3. Enter the **Email** parameter
4. The node returns the validation result

### Listing tools dynamically

The node supports dynamic tool selection. Available tools are fetched from Uproc's API at runtime, so all tools are available without manual configuration.

## ⚠️ Only data process tools exposed

This node **only exposes Uproc's data process tools** (email validation, enrichment, lookup, etc.).

It does **NOT** expose any of Uproc's platform modules:

| Uproc Module | Available in n8n? | Why |
|--------------|------------------|-----|
| **Data Process** (email, company, IBAN, etc.) | ✅ Yes | Core tools (~400+) |
| Document Ingest | ❌ No | Requires file upload + OCR + classification |
| Approval Management | ❌ No | Requires approval workflows |
| Campaign Automation | ❌ No | Requires campaign execution |
| Lead Management | ❌ No | Requires pipeline management |
| Customer Care | ❌ No | Requires ticket management |
| Financial Reconciliation | ❌ No | Requires reconciliation workflows |

This node is a **data processing connector** — it lets you use Uproc's ~400 tools to clean, validate, and enrich data in your n8n workflows. It does not expose the operational platform modules of Uproc.

## Resources

* [n8n community nodes documentation](https://docs.n8n.io/integrations/#community-nodes)
* [Uproc official website](https://www.uproc.io)
* [Uproc API Documentation](https://docs.uproc.io)
* [Uproc Tool Catalog](https://app.uproc.io/app/catalog)
* [Submit Community Nodes Guide](https://docs.n8n.io/integrations/creating-nodes/deploy/submit-community-nodes/)

## Version history

### 0.1.0 (2026-06-07)

- Initial release
- Support for all Uproc data processing tools
- Dynamic tool loading from Uproc API
- Email validation, company lookup, IBAN check, and more

## Submitting this node to n8n

This node is a community-maintained fork of the n8n-nodes-starter template. To submit for official n8n Cloud verification, it must:

- Use MIT license ✅
- Pass n8n's quality review
- Meet the [verification requirements](https://docs.n8n.io/integrations/creating-nodes/deploy/submit-community-nodes/)
- Be submitted through the [n8n Creator Portal](https://creators.n8n.io/nodes)

## Contributing

Contributions are welcome! Please read the [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

For issues and feature requests, please open an [issue on GitHub](https://github.com/uproc-io/uproc-n8n/issues).

## License

This project is licensed under the [MIT License](LICENSE.md).

## Author

| Field | Value |
|-------|-------|
| **Name** | Miquel Colomer |
| **Email** | [miquel@uproc.io](mailto:miquel@uproc.io) |
| **Website** | [uproc.io](https://uproc.io) |
| **LinkedIn** | https://www.linkedin.com/in/miquelcolomersalas/ |
| **Phone** | +34 605 28 12 20 |

## Documentation

| Resource | URL |
|----------|-----|
| **Uproc Docs** | https://docs.uproc.io |
| **API Reference** | https://docs.uproc.io/api/ |
| **MCP Tools** | https://docs.uproc.io/mcp/ |
| **CLI Reference** | https://docs.uproc.io/cli/ |
| **Applications** | https://docs.uproc.io/applications/ |

## Related integration repos

| Resource | URL |
|----------|-----|
| **Zapier source code** | https://github.com/uproc-io/uproc-zapier |
| **Make source code** | https://github.com/uproc-io/uproc-make |