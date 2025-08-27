#!/usr/bin/env bash
# install.sh - installer for ai-openrouter-git-commit generate_commit_title.sh
# Downloads generate_commit_title.sh into /usr/local/bin and prints
# shell export lines for configuration.

set -euo pipefail

# Direct URL to raw script on GitHub
SCRIPT_URL="https://raw.githubusercontent.com/seliverstov-maxim/ai-openrouter-git-commit/main/generate_commit_title.sh"

# (no-op; SCRIPT_URL is defined above)
DEST="/usr/local/bin/generate_commit_title.sh"

echo "Installing generate_commit_title.sh to $DEST..."
curl -fsSL "$SCRIPT_URL" -o "$DEST"
chmod 755 "$DEST"

cat <<EOF

✅ generate_commit_title.sh has been installed to $DEST

Next, configure your environment variables by adding the following to your shell startup file (~/.bashrc, ~/.bash_profile, or ~/.zshrc):

# Required: OpenRouter API key
export OPENROUTER_API_KEY="your_api_key_here"

# Optional: Select a different model (default: openai/gpt-4o)
export OPENROUTER_MODEL="openai/gpt-4o"

# Optional: Override the API endpoint (default: https://openrouter.ai/v1/chat/completions)
export OPENROUTER_ENDPOINT="https://openrouter.ai/v1/chat/completions"

After editing, reload your shell:

  source ~/.bashrc   # or ~/.zshrc, ~/.bash_profile, etc.

You can now use:

  generate_commit_title.sh

Optionally, add a shell alias for convenience:
  alias ai-commit="generate_commit_title.sh"

Happy committing!
EOF