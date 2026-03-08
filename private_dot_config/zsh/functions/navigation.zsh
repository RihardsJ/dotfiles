#!/usr/bin/env zsh
# ─── navigation.zsh ───────────────────────────────────────────────────────────
# Project-focused directory navigation

# cd with automatic ls after every jump
cd() { builtin cd "$@" && eza --group-directories-first }

# mkcd — create directory and cd into it
mkcd() { mkdir -p "$1" && builtin cd "$1" && eza --group-directories-first }

# up [n] — go up N directory levels (default: 1)
up() {
    local n=${1:-1} p=''
    for _ in $(seq $n); do p+='../'; done
    builtin cd "$p"
}

# cdroot — jump to the root of the current git repository
cdroot() {
    local root
    root=$(git rev-parse --show-toplevel 2>/dev/null) \
        || { echo 'not inside a git repository' >&2; return 1 }
    builtin cd "$root"
}

# proj — fzf jump to any project under $WORKSPACE (depth 2)
# Shows an eza tree preview on the right side.
proj() {
    [[ -z $WORKSPACE ]] && { echo 'WORKSPACE is not set' >&2; return 1 }
    local dir
    dir=$(fd --type d --max-depth 2 --min-depth 1 . "$WORKSPACE" 2>/dev/null \
        | fzf \
            --prompt='  project  ' \
            --preview='eza --tree --level=2 --icons --color=always {}' \
            --preview-window='right:55%:border-left') \
        || return
    builtin cd "$dir"
}

# z wrapper — zoxide with fallback to builtin cd
# (zoxide init zsh already provides `z`; this is a fallback if zoxide is absent)
if ! command -v zoxide &>/dev/null; then
    z() { builtin cd "$@" }
fi
