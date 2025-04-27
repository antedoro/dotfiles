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

3. Configurazione post-installazione: 
   - Dopo l'installazione, esegui 'p10k configure' per personalizzare il tuo prompt Powerlevel10k
   - Approva eventuali estensioni del kernel richieste da applicazioni come LuLu
   - Completa la configurazione manuale delle app che lo richiedono (Brother, ecc)

   ```bash
   p10k configure

4. Aggiornamento dei dotfile:
   
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


## Note importanti
La prima esecuzione potrebbe richiedere molto tempo (30+ minuti) per scaricare e installare tutto
Alcune app come Docker e LuLu richiedono riavvii o autorizzazioni manuali.
