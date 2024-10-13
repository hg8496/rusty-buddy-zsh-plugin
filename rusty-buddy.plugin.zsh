# oh-my-zsh plugin for rusty-buddy

# Function to send input to rusty-buddy chat as a one-shot command
function rbco() {
    local input="$*"
    # Send the evaluated input as a one-shot chat
    rusty-buddy chat --one-shot "$input"
}

function rb-batch() {
    echo "Starting batch execution..."
    for cmd in "$@"; do
        echo "Executing: $cmd"
        rusty-buddy chat --one-shot "$cmd"
    done
}

# Ensure rust-buddy is accessible in PATH
if ! command -v rusty-buddy >/dev/null; then
    echo "Please ensure rusty-buddy is installed and accessible in your PATH."
    return
fi

# Aliases for commonly used commands
alias rb-init="rusty-buddy init"
alias rb-cmsg="rusty-buddy commit-message"
alias rb-icon="rusty-buddy create-icon"
alias rb-bg="rusty-buddy create-background"
alias rb-wish="rusty-buddy wish"
alias rb-listp="rusty-buddy --list-personas"
alias rbcd="rusty-buddy chat -d ."
alias rbc="rusty-buddy chat"

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `kubectl`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_rusty" ]]; then
    typeset -g -A _comps
    autoload -Uz _rusty
    _comps[kubectl]=_rusty
fi

rusty-buddy --completion zsh 2>/dev/null >|"$ZSH_CACHE_DIR/completions/_rusty" &|
