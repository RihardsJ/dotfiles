# 🏠 Centralised dotfiles management
Personal configuration files managed with 1 for consistent development environments across machines.

## 🚀 Quick Setup
New Machine Setup (One Command)
```sh
export GITHUB_USERNAME=RihardsJ
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

Manual Setup
```sh
# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# Initialize with your dotfiles
chezmoi init https://github.com/RihardsJ/dotfiles.git

# Preview changes
chezmoi diff

# Apply dotfiles
chezmoi apply
```

## 🔧 Daily Commands
Essential Commands


Git Workflow

### 1. Make changes to dotfiles
`chezmoi edit ~/.zshrc`

### 2. Check what will change
`chezmoi diff`

### 3. Apply changes
`chezmoi apply`

### 4. Commit and push changes
chezmoi cd
git add .
git commit -m "Update zsh configuration"
git push
exit


## 🔄 Sync

```sh
chezmoi update  # Pull from remote and apply
```
