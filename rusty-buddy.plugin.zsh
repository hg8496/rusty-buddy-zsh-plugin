# oh-my-zsh plugin for rusty-buddy

function rbco() {
    local input="$*"
    rusty-buddy chat --one-shot "$input"
}

function rb-batch() {
    echo "Starting batch execution..."
    for cmd in "$@"; do
        echo "Executing: $cmd"
        rusty-buddy chat --one-shot "$cmd"
    done
}

# Ensure rusty-buddy is accessible in PATH
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

# Additional commands with options
alias rb-ki="rusty-buddy knowledge init --persona"
alias rb-ks="rusty-buddy knowledge search"
alias rb-kad="rusty-buddy knowledge add --dir"
alias rb-kaf="rusty-buddy knowledge add --file"
alias rb-kau="rusty-buddy knowledge add --url"

# Alias to fetch knowledge before a one-shot chat
alias rbc-knowledge="rusty-buddy chat --knowledge"

# Modified completion handling
if [[ ! -f "$ZSH_CACHE_DIR/completions/_rusty" ]]; then
    typeset -g -A _comps
    autoload -Uz _rusty
    _comps[rusty-buddy]=_rusty
fi

rusty-buddy --completion zsh 2>/dev/null >|"$ZSH_CACHE_DIR/completions/_rusty" &|
