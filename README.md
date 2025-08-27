# ai-openrouter-git-commit

AI‑powered Git commit title generator (English) leveraging OpenRouter (GPT). This project is super simple, doesn't need any fancy dependencies like specific programming languages (no Node.js hassle here), and it's all about being easy to use and straightforward.

## Overview

`ai-commit` provides a simple bash script that analyzes your staged changes and suggests a concise English commit title using the OpenRouter API (e.g. GPT‑4o).

## Prerequisites

- **git** and **curl** must be installed.
- An **OpenRouter API key**.

## Installation

Run the installer script directly from GitHub (no sudo required):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/seliverstov-maxim/ai-openrouter-git-commit/main/install.sh)"
```

The installer will also print the environment-variable export lines and a suggested alias to add to your shell startup file (~/.bashrc, ~/.bash_profile, or ~/.zshrc).

## Uninstallation

To remove the tool and clean up your environment (no sudo required), run:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/seliverstov-maxim/ai-openrouter-git-commit/main/uninstall.sh)"
```

This will delete the installed script and print instructions to remove the exports and alias.

## Usage

Stage your changes and run:

```bash
ai-commit
```

like:

```bash
ai-commit
> git commit -m 'Improve formatting and clarify instructions in install and uninstall scripts.'

> Proceed with this commit message? [Y,y,enter/N,n]
# (enter)
```

The script will fetch a suggested commit title, prompt you to confirm, and then create the commit.

You can use chaining to speed up add, commit, push:

```bash
git add . && ai-commit && git push

> git commit -m 'Improve README Formatting and Update Instructions'

> Proceed with this commit message? [Y,y,enter/N,n]
# (enter)
> [main 5b0aab5] Improve README Formatting and Update Instructions
> 1 file changed, 9 insertions(+), 1 deletion(-)
> ...
```

## Help

Run:

```bash
ai-commit --help
```

for more options and details.

## License

This project is released under the MIT License.
