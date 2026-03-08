#!/usr/bin/env zsh
# ─── git.zsh ──────────────────────────────────────────────────────────────────
# Git convenience functions with fzf integration

# gclone — clone a repo and cd into it
gclone() {
    [[ -z $1 ]] && { echo 'usage: gclone <url>' >&2; return 1 }
    git clone "$1" && builtin cd "$(basename "$1" .git)"
}

# gsw — fzf branch switcher (local + remote)
# Preview shows the last 10 commits on the branch.
gsw() {
    local branch
    branch=$(git branch -a --color=always 2>/dev/null \
        | grep -v 'HEAD' \
        | sed 's/remotes\/origin\///' \
        | sort -u \
        | fzf \
            --ansi \
            --prompt='  branch  ' \
            --preview='git log --oneline --graph --color=always -20 {1} 2>/dev/null' \
            --preview-window='right:55%:border-left' \
        | xargs) \
        || return
    git switch "$branch" 2>/dev/null || git checkout "$branch"
}

# glog — interactive git log with diff preview
# Enter opens the full commit in $PAGER (or less).
glog() {
    git log --oneline --graph --color=always --all \
        | fzf \
            --ansi \
            --prompt='  log  ' \
            --no-sort \
            --reverse \
            --tiebreak=index \
            --preview='git show --color=always {2} 2>/dev/null' \
            --preview-window='right:60%:border-left' \
            --bind='enter:execute(git show --color=always {2} | less -R)'
}

# gadd — fzf interactive git add
# Multi-select with Tab, shows diff preview for each file.
gadd() {
    local files
    files=$(git status --short \
        | fzf \
            --multi \
            --ansi \
            --prompt='  stage  ' \
            --preview='git diff --color=always HEAD -- {2} 2>/dev/null || git diff --color=always --cached {2} 2>/dev/null' \
            --preview-window='right:60%:border-left' \
        | awk '{print $2}') \
        || return
    [[ -n $files ]] && echo "$files" | xargs git add
}

# gwip — quick "work in progress" commit
gwip() { git add --all && git commit -m "wip: $(date +'%Y-%m-%d %H:%M')" }

# gunwip — undo the last wip commit, leaving changes staged
gunwip() {
    git log --oneline -1 | grep -q 'wip:' \
        && git reset --soft HEAD~1 \
        || echo 'last commit is not a wip commit'
}
