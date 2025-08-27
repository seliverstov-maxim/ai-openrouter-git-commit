#!/usr/bin/env bash
# Generate an English commit title from staged changes via OpenRouter.

set -euo pipefail

# Dependencies
command -v git >/dev/null 2>&1 || { echo >&2 "Error: git is required but not installed."; exit 1; }
command -v curl >/dev/null 2>&1 || { echo >&2 "Error: curl is required but not installed."; exit 1; }

# Ensure API key and model are set
: "${OPENROUTER_API_KEY:?Environment variable OPENROUTER_API_KEY must be set}"
if [[ ${#OPENROUTER_API_KEY} -lt 70 ]]; then
  echo >&2 "Error: OPENROUTER_API_KEY invalid"
  exit 1
fi
: "${OPENROUTER_MODEL:=openai/gpt-4o}"

show_help() {
  cat <<EOF
Usage: $(basename "$0") [-h|--help]

Generate a concise English commit title from staged changes via OpenRouter.

Options:
  -h, --help    Show this help message and exit.

Environment:
OPENROUTER_API_KEY  To configure OpenRouter API key
OPENROUTER_MODEL    Configure AI model (defaults to openai/gpt-4o)
EOF
}

# Parse args
while [[ "${1:-}" != "" ]]; do
  case "$1" in
    -h|--help) show_help; exit 0 ;;
    *) echo "Unknown option: $1" >&2; show_help; exit 1 ;;
  esac
done

# Obtain staged git diff
diff=$(git diff --cached)
# Whitelist-escape diff for safe JSON embedding (allow only word chars, digits, + - = parentheses, and whitespace)
escaped_diff=$(printf '%s' "$diff" \
  | sed -E -e 's/[^[:alnum:][:space:]+=\(\)\-]//g' \
            -e 's/\\/\\\\/g' \
            -e 's/"/\\"/g')
escaped_diff="${escaped_diff//$'\n'/\\n\\n}"

if [[ -z "$diff" ]]; then
  echo "No staged changes detected. Please stage your changes before running this script."
  exit 1
fi

# Prepare request payload
cmd=$(cat << EOF
    curl https://openrouter.ai/api/v1/chat/completions \
    -s \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENROUTER_API_KEY" \
    -d '{
        "model": "'"$OPENROUTER_MODEL"'",
        "messages": [
            { "role": "system", "content": "Generate a concise commit title in English based on the provided git diff." },
            { "role": "user", "content": "Git diff:\\n\\n$escaped_diff" }
        ]
    }'
EOF)

http_response=$(eval "$cmd")
# Extract commit title from JSON response using pure sed
title=$(printf '%s' "$http_response" | sed -n 's/.*"content":[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
echo
echo "git commit -m '$title'"
echo
read -p "Proceed with this commit message? [Y,y,enter/N,n] " answer
case "$answer" in
  [Yy]|[Yy][Ee][Ss]|"")
    git commit -m "$title"
    ;;
  *)
    echo "Commit aborted."
    exit 1
    ;;
esac
