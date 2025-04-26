# My macOS Dotfiles

These are my macOS dotfiles for setting up a new machine.
NB: To install Brother iPrint&Scan be sure to make login App Store login before.

## Installation

1. Clone this repository to your home directory:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles

2. Run the installation script:
   
   ```bash
   chmod +x install.sh
   ./install.sh

3. After installation, configure Powerlevel10k:

   ```bash
   p10k configure

## Features

- Homebrew for package management
- Oh My Zsh with Powerlevel10k theme
- Mackup for application preferences backup
- All essential apps preconfigured

## Manual Steps

- Some apps might require manual setup after installation:
- Brother iPrint&Scan: Follow manufacturer instructions
- Binance: Download from official website
- LuLu: Requires kernel extension approval

## Come utilizzare questi dotfile

1. **Preparazione iniziale**:

   ```bash
   git clone https://github.com/tuo-username/dotfiles.git ~/dotfiles
   cd ~/dotfiles

2. Esegui l'installazione:
     
   ```bash
   chmod +x install.sh
   ./install.sh

3. Configurazione post-installazione: 
   - Dopo l'installazione, esegui p10k configure per personalizzare il tuo prompt Powerlevel10k
   - Approva eventuali estensioni del kernel richieste da applicazioni come LuLu
   - Completa la configurazione manuale delle app che lo richiedono (Brother, Binance)

4. Backup delle preferenze:
   Mackup salverà automaticamente le preferenze nella cartella *dotfiles/mackup*
   Per aggiornare il backup: mackup backup

5. Aggiornamento dei dotfile:
   
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update dotfiles"
   git push origin main

## Note importanti
La prima esecuzione potrebbe richiedere molto tempo (30+ minuti) per scaricare e installare tutto
Alcune app come Docker e LuLu richiedono riavvii o autorizzazioni manuali
Per Binance dovrai scaricare manualmente l'app dal sito ufficiale in quanto non è disponibile su Homebrew