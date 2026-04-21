# End-of-Life CLI

A robust Bash-based command-line interface (CLI) for interacting with the [endoflife.date](https://endoflife.date) API. This tool allows you to discover, query, and check the support status (EOL, LTS, and more) of various software products and hardware directly from your terminal.

## Features

- **Product Discovery**: List all supported products and categories.
- **Support Status**: Check EOL (End of Life) and LTS (Long-Term Support) dates for specific releases.
- **Expiration Checks**: Quickly determine if a product or a specific version has already reached its end-of-life.
- **Rich Data**: Access detailed information including release dates, latest versions, and identifiers.

## Prerequisites

Ensure the following tools are installed and available in your `PATH`:

- `bash`: The script is written in Bash.
- `curl`: Used for making API requests.
- `jq`: Used for parsing and filtering JSON responses.

## Installation

1. Clone the repository or download the `end-of-life.sh` script.
2. Make the script executable:

```bash
chmod +x end-of-life.sh
```

## Usage

Run the script with a command and optional arguments:

```bash
./end-of-life.sh <command> [args]
```

### Commands

| Command                                   | Description                                                |
|:------------------------------------------|:-----------------------------------------------------------|
| `index`                                   | List the main API endpoints.                               |
| `products`                                | List all supported software and hardware products.         |
| `products-full`                           | List all products with full release details.               |
| `product <product>`                       | Get all release cycles and details for a specific product. |
| `product-release <product> <release>`     | Get details for a specific product release.                |
| `product-release-latest <product>`        | Get the latest release cycle for a product.                |
| `product-has-expired <product> [release]` | Check if a product or release has expired.                 |
| `categories`                              | List all available product categories.                     |
| `products-category <category>`            | List all products within a specific category.              |
| `tags`                                    | List all available tags.                                   |
| `products-tag <tag>`                      | List all products associated with a specific tag.          |
| `identifier-types`                        | List all identifier types (e.g., CPE, PURL).               |
| `identifier-by-type <type>`               | List all identifiers for a given type.                     |

### Examples

**List all products:**
```bash
./end-of-life.sh products
```

**Get details for Ubuntu:**
```bash
./end-of-life.sh product ubuntu
```

**Check if Ubuntu 22.10 has expired:**
```bash
./end-of-life.sh product-has-expired ubuntu 22.10
```

**List all expired versions for Python:**
```bash
./end-of-life.sh product-has-expired python
```

## Development
Please install the [bash](https://github.com/petromir/ai-setup/tree/master/common/skills) skill to make sure high 
standards are followed and the script is validated

### Static Analysis

On each PR, `shellcheck` is invoked to validate the script.

## Support my work

<a href="https://ko-fi.com/petromirdzhunev" target="_blank"><img src="https://raw.githubusercontent.com/petromir/petromir/refs/heads/master/assets/kofi-button.svg" alt="Buy Me A Ko-fi" style="height: 45px !important;width: 163px !important;" ></a>
<a href="https://www.buymeacoffee.com/petromirdzhunev" target="_blank"><img src="https://raw.githubusercontent.com/petromir/petromir/refs/heads/master/assets/bmc-button.svg" alt="Buy Me A Coffee" style="height: 45px !important;width: 163px !important;" ></a>
<a href="https://github.com/sponsors/petromir" target="_blank"><img src="https://raw.githubusercontent.com/petromir/petromir/refs/heads/master/assets/github-sponsor-button.svg" alt="GitHub Sponsor" style="height: 45px !important;width: 163px !important;" ></a>
