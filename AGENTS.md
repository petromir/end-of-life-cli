# End-of-Life CLI Wrapper

## Project Overview

This project provides a robust Bash-based command-line interface (CLI) for interacting with the [endoflife.date](https://endoflife.date) API. The tool allows users to discover, query, and check the support status (EOL, LTS, etc.) of various software products and hardware.

- **Main Script**: `end-of-life.sh`
- **Core Technologies**: Bash, `curl`, `jq`.
- **API**: [endoflife.date API v1](https://endoflife.date/api/v1)

## Building and Running

This is a script-based tool and does not require a build step.

### Dependencies

Ensure the following tools are installed and available in your `PATH`:
- `curl`: For making API requests.
- `jq`: For parsing and filtering JSON responses.
- `shellcheck`: For static analysis and linting.

### Docker

After each change in the bash script or Dockerfile use the following two commands to validate the script is working 
properly:
```bash
docker build \
  --build-arg VERSION=$(grep '^readonly VERSION=' end-of-life.sh | cut -d'"' -f2) \
  -t end-of-life-cli .
docker run --rm end-of-life-cli product-has-expired spring-boot 3.4
```

### CI/CD

This repository uses GitHub Actions for continuous integration.
- **Workflow**: `.github/workflows/bash-checks.yml`
- **Steps**:
  - Syntax validation with `bash -n`.
  - Static analysis with `shellcheck`.

### Development

- Always stick to the [endoflife OpenAPI](https://endoflife.date/docs/api/v1/openapi.yml) definition, 
- Use `bash` skill when working bash scripts inside this repostory to ensure high-quality Bash standards.
- Use the following command to verify the correctness of the bash scripts
```bash
shellcheck <bash_script_name>.sh
```
`<bash_script_name>` is the name of the script
- Use `docker` skill when working with Docker-related files to ensure high-quality Docker standards.

### Always improving
After each change introduced to the repository, check if something else should be added to this file – AGENTS.md

