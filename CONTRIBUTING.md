# Contributing to End-of-Life CLI

Thank you for considering contributing to this project! Every contribution is appreciated and valued.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible using the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md).

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. Please use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md) and provide a clear description of the proposed feature.

### Pull Requests

1. Fork the repository.
2. Create a feature branch from `master`:
   ```bash
   git checkout -b feature/my-new-feature
   ```
3. Make your changes.
4. Run validation:
   ```bash
   shellcheck end-of-life.sh
   bash -n end-of-life.sh
   ```
5. If you modified the script or `Dockerfile`, verify the Docker build works:
   ```bash
   docker build \
     --build-arg VERSION=$(grep '^readonly VERSION=' end-of-life.sh | cut -d'"' -f2) \
     -t end-of-life-cli .
   docker run --rm end-of-life-cli product-has-expired spring-boot 3.4
   ```
6. Commit your changes with a clear and descriptive message.
7. Push to your fork and submit a pull request.

## Development Setup

### Prerequisites

**macOS (Homebrew):**
```bash
brew install bash curl jq shellcheck
brew install --cask docker
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update && sudo apt-get install -y curl jq shellcheck docker.io
```

### Coding Standards

- Adhere to the [endoflife.date OpenAPI specification](https://endoflife.date/docs/api/v1/openapi.yml) when adding or modifying API-related functionality.
- Add `bash`, `docker` and `git` skills to your AI agents from [here](https://github.
  com/petromir/oh-my-ai/tree/master/common/skills)
- Use `bash` and `docker` skill to check the code quality

### Commit Messages

- Use the present tense ("Add feature" not "Added feature").
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...").
- Use `git` to genererate proper commit message.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).