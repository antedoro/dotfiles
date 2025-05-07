#!/bin/bash

# Install Xcode Command Line Tools
if ! xcode-select --print-path &> /dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
  until xcode-select --print-path &> /dev/null; do
    sleep 5
  done
fi

# Install Homebrew (nuovo metodo ufficiale)
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install MAS se non presente (per le app del Mac App Store)
if ! command -v mas &> /dev/null; then
  brew install mas
fi

# Install everything from Brewfile
brew bundle --file=./Brewfile

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme for Oh My Zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy config gitconfig files to the home directory
echo "Copying .gitconfig to home directory..."
cp -f "$DOTFILES_DIR/.gitconfig" $HOME/.gitconfig

# Copy config zsh config files to the home directory
echo "Copying .zshrc and .p10k.zsh to home directory..."
cp -f "$DOTFILES_DIR/.zshrc" $HOME/.zshrc
cp -f "$DOTFILES_DIR/.p10k.zsh" $HOME/.p10k.zsh

# Set macOS preferences - we will run this last because this will reload the shell
# source ./.macos

echo "Installation complete! Please restart your terminal."
echo "To customize prompt, run p10k configure or edit ~/.p10k.zsh"