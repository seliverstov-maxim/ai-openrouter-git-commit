# ai-openrouter-git-commit

AI‑powered Git commit title generator (English) leveraging OpenRouter (GPT).

## Overview

`ai-commit` provides a simple bash script that analyzes your staged changes and suggests a concise English commit title using the OpenRouter API (e.g. GPT‑4o).

## Prerequisites

- **git**, **curl**, and **jq** must be installed.
- An **OpenRouter API key**.

## Installation

Run the installer script directly from GitHub (you may be prompted for your sudo password). Make sure to replace `<OWNER>` below with your GitHub username or organization (for this repo, it’s `seliverstov-maxim`):

```bash
curl -fsSL https://raw.githubusercontent.com/seliverstov-maxim/ai-openrouter-git-commit/main/install.sh | sudo bash
```

Or with `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/seliverstov-maxim/ai-openrouter-git-commit/main/install.sh | sudo bash
```

Replace `<OWNER>` with your GitHub username or organization.

The installer will also print the environment-variable export lines you need to add to your shell startup file (~/.bashrc, ~/.bash_profile, or ~/.zshrc).

## Uninstallation

To remove the tool and clean up your environment, run:

```bash
curl -fsSL https://raw.githubusercontent.com/seliverstov-maxim/ai-openrouter-git-commit/main/uninstall.sh | sudo bash
```

This will delete the installed script and print instructions to remove the exports and alias.

## Usage

Stage your changes and run:

```bash
generate_commit_title.sh
```

The script will fetch a suggested commit title, prompt you to confirm, and then create the commit.

## Help

Run:

```bash
generate_commit_title.sh --help
```

for more options and details.

## License

This project is released under the MIT License.