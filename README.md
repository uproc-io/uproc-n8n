# UProc Community Node for n8n

A community-maintained node for UProc that provides access to 400+ data processing tools directly within n8n workflows.

## Features

This node exposes UProc's data processing capabilities across multiple categories:

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

This node uses UProc's API Key authentication.

### Prerequisites

1. Create a UProc account at [app.uproc.io](https://app.uproc.io/#/signup)
2. Navigate to **Settings → Integrations** in your UProc account
3. Copy your **Username** (email) and **API Key (real)**

### Setup

1. Add a new credential in n8n
2. Select **UProc API** credential type
3. Enter your **Email** and **API Key**
4. Save the credential

### Required credentials

| Credential | Required | Description |
|------------|----------|-------------|
| Email | Yes | Your UProc account email |
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

1. Add a **UProc** node to your workflow
2. Select the **Communication** resource and **Check email exists** tool
3. Enter the **Email** parameter
4. The node returns the validation result

### Listing tools dynamically

The node supports dynamic tool selection. Available tools are fetched from UProc's API at runtime, so all tools are available without manual configuration.

## Resources

* [n8n community nodes documentation](https://docs.n8n.io/integrations/#community-nodes)
* [UProc official website](https://www.uproc.io)
* [UProc API Documentation](https://docs.uproc.io)
* [UProc Tool Catalog](https://app.uproc.io/app/catalog)
* [Submit Community Nodes Guide](https://docs.n8n.io/integrations/creating-nodes/deploy/submit-community-nodes/)

## Version history

### 0.1.0 (2026-06-07)

- Initial release
- Support for all UProc data processing tools
- Dynamic tool loading from UProc API
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