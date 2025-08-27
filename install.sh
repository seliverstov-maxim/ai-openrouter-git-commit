#!/usr/bin/env bash
# install.sh - installer for ai-openrouter-git-commit generate_commit_title.sh
# Downloads generate_commit_title.sh into ~/bin and prints
# shell export lines for configuration.

set -euo pipefail

# Direct URL to raw script on GitHub
SCRIPT_URL="https://raw.githubusercontent.com/seliverstov-maxim/ai-openrouter-git-commit/main/generate_commit_title.sh"

# (no-op; SCRIPT_URL is defined above)
DEST="$HOME/bin/generate_commit_title.sh"
mkdir -p "$HOME/bin"

echo "Installing generate_commit_title.sh to $DEST..."
rm -f "$DEST"
curl -fsSL "$SCRIPT_URL" -o "$DEST"
chmod 755 "$DEST"

echo "Enter your OpenRouter API key: "
read OPENROUTER_API_KEY

cat <<EOF

✅ generate_commit_title.sh has been installed to $DEST

Next, configure your environment variables by adding the following to your shell startup file (~/.bashrc, ~/.bash_profile, or ~/.zshrc):

export OPENROUTER_API_KEY="$OPENROUTER_API_KEY"
export OPENROUTER_MODEL="openai/gpt-4o"
alias ai-commit="$DEST"

After editing, reload your shell:

  source ~/.bashrc # or
  source ~/.zshrc, # or
  source ~/.bash_profile # etc.

Then you can now use:

  ai-commit

To check tool run ai-commit -v

Happy committing!
EOF
