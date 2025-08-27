#!/usr/bin/env bash
# uninstall.sh - uninstall ai-openrouter-git-commit generate_commit_title.sh
# Removes the installed script and prints instructions for cleaning env vars and alias.

set -euo pipefail

DEST="$HOME/bin/generate_commit_title.sh"

echo "Removing $DEST..."
if [[ -f "$DEST" ]]; then
  rm -f "$DEST"
  echo "Removed $DEST"
else
  echo "$DEST not found, skipping removal"
fi

echo "Searching for environment and alias entries in your shell startup files..."
grep -HnE 'export OPENROUTER_API_KEY|export OPENROUTER_MODEL|export OPENROUTER_ENDPOINT|alias ai-commit' ~/.bashrc ~/.bash_profile ~/.zshrc || true

cat <<EOF

✅ Uninstallation complete!

Next, you may want to remove the following lines from your shell startup file (~/.bashrc, ~/.bash_profile, or ~/.zshrc):

# Required: OpenRouter API key
export OPENROUTER_API_KEY="your_api_key_here"

# Optional: Select a different model (default: openai/gpt-4o)
export OPENROUTER_MODEL="openai/gpt-4o"

# Optional: Override the API endpoint (default: https://openrouter.ai/v1/chat/completions)
export OPENROUTER_ENDPOINT="https://openrouter.ai/v1/chat/completions"

# Alias for ai-commit shortcut
alias ai-commit="generate_commit_title.sh"

After editing, reload your shell:

  source ~/.bashrc   # or ~/.zshrc, ~/.bash_profile, etc.

EOF