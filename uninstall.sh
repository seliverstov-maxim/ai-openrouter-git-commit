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

echo "✅ Uninstallation complete!"

echo "Checking shell startup files for OpenRouter configuration..."
echo ''
find ~/ -maxdepth 1 -type f -name '.*' ! -regex '.*/\..*history' | xargs grep -E --color=auto "export OPENROUTER_API_KEY|export OPENROUTER_MODEL|alias ai-commit" 2>/dev/null || true


cat <<EOF

If any configuration lines were found above, please remove them from the corresponding shell startup file(s).

    export OPENROUTER_API_KEY="..."
    export OPENROUTER_MODEL="..."
    alias ai-commit="..."

After removing reload your shell:

    source ~/.bashrc   # or
    source ~/.zshrc,   # or
    source ~/.bash_profile, etc.

EOF
