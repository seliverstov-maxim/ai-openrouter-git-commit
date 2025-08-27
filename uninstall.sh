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

echo "Checking shell startup files for OpenRouter configuration..."
files_to_check=()
for f in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.zshrc"; do
  [[ -f $f ]] && files_to_check+=("$f")
done

if (( ${#files_to_check[@]} > 0 )); then
  if grep -qE 'export OPENROUTER_API_KEY|export OPENROUTER_MODEL|export OPENROUTER_ENDPOINT|alias ai-commit' "${files_to_check[@]}"; then
    echo "Configurations found in:"
    grep -lE 'export OPENROUTER_API_KEY|export OPENROUTER_MODEL|export OPENROUTER_ENDPOINT|alias ai-commit' "${files_to_check[@]}"
  else
    echo "No OpenRouter configuration found in your shell startup files."
  fi
else
  echo "No shell startup files found to check for configuration."
fi

cat <<EOF

✅ Uninstallation complete!

Next, you may want to remove the following lines from your shell startup file (~/.bashrc, ~/.bash_profile, or ~/.zshrc):

# Required: OpenRouter API key
export OPENROUTER_API_KEY="..."
export OPENROUTER_MODEL="..."
alias ai-commit="..."

After editing, reload your shell:

  source ~/.bashrc   # or ~/.zshrc, ~/.bash_profile, etc.

EOF
