# My macOS Dotfiles

These are my macOS dotfiles for setting up a new machine.
NB: To install Brother iPrint&Scan be sure to make login App Store login before.

## Features

- Homebrew for package management
- Oh My Zsh with Powerlevel10k theme
- All essential apps preconfigured

## Manual Steps

- Some apps might require manual setup after installation:
- Brother iPrint&Scan: Follow manufacturer instructions
- LuLu: Requires kernel extension approval

## Installation

1. Clone this repository to your home directory:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles

   or copy project zip file from https://github.com/yourusername/dotfiles.git

2. Run the installation script:

   ```bash
   chmod +x install.sh
   ./install.sh

3. Post-installation configuration:
   - After installation, run 'p10k configure' to customize your Powerlevel10k prompt.
   - Approve any kernel extensions requested by applications like LuLu.
   - Complete the manual configuration of apps that require it (Brother, etc.).

   ```bash
   p10k configure

4. Updating dotfiles:
   
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update dotfiles"
   git push origin main

## Important Security Check
Before pushing:

Remove sensitive data from files:

1. Check for credentials in your files

   ```bash
   grep -r "email\|password\|token\|secret" .

2. Sanitize your gitconfig:

   ```bash
   git config --global credential.helper store

3. Automate Future Updates
   Add this alias to your .zshrc:

   ```bash
   alias dotupdate="cd ~/dotfiles && git add . && git commit -m 'Update dotfiles' && git push"

## Important Notes

The first run might take a long time (30+ minutes) to download and install everything.
Some apps like Docker and LuLu require restarts or manual authorizations.
