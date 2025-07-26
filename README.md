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
### Common Commands

| Command    | Description |
| -------- | ------- |
| chezmoi edit <file>  | edit a dotfile    |
| chezmoi diff | see what would change     |
| chezmoi apply    | apply changes to home directory    |
| chezmoi cd    | go to source directory    |
| chezmoi update    | pull from remote and apply   |

### Git Workflow
1. Make changes to dotfiles
`chezmoi edit ~/.zshrc`

2. Check what will change
`chezmoi diff`

3. Apply changes
`chezmoi apply`

4. Commit and push changes
chezmoi cd
git add .
git commit -m "Update zsh configuration"
git push
exit


## 🔄 Sync

```sh
chezmoi update  # Pull from remote and apply
```

## 🛠️ Chezmoi configs
1. Create a chezmoi.toml file

```sh
# Create the config directory if it doesn't exist
mkdir -p ~/.config/chezmoi
```

```sh
# Edit the configuration file
cat > ~/.config/chezmoi/chezmoi.toml << 'EOF'
[git]
    autoCommit = true
    autoPush = true
    commitMessageTemplate = "{{ promptString \"Commit message\" }}"
EOF
```

2. Automatically commit changes on apply
```sh
[git]
    autoCommit = true
    autoPush = true
    commitMessageTemplate = "{{ promptString \"Commit message\" }}"
```

## 🙏 Acknowledgments

This dotfiles setup was inspired by [logandonley](https://github.com/logandonley/dotfiles)'s excellent [dotfiles repository](https://github.com/logandonley/dotfiles). Their approach to managing cross-platform configurations and use of chezmoi templates provided the foundation for this setup.

