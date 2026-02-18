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

# Install ImgCompress (macOS Silicon)
if [ ! -d "/Applications/ImgCompress_Silicon.app" ] && [ "$(uname -m)" = "arm64" ]; then
  echo "Installing ImgCompress for macOS Silicon..."
  IMGCOMPRESS_URL=$(curl -s https://api.github.com/repos/antedoro/imgcompress-go/releases/latest | grep "browser_download_url.*Silicon.zip" | cut -d '"' -f 4)
  if [ -n "$IMGCOMPRESS_URL" ]; then
    curl -L -o /tmp/ImgCompress_macOS_Silicon.zip "$IMGCOMPRESS_URL"
    unzip -q /tmp/ImgCompress_macOS_Silicon.zip -d /Applications
    rm /tmp/ImgCompress_macOS_Silicon.zip
    echo "ImgCompress installed in /Applications"
  else
    echo "Could not find ImgCompress Silicon download URL"
  fi
fi

# Install CriptoMenu-golang (macOS Silicon)
if [ ! -d "/Applications/CriptoMenu.app" ] && [ "$(uname -m)" = "arm64" ]; then
  echo "Installing CriptoMenu for macOS Silicon..."
  CRIPTOMENU_URL=$(curl -s https://api.github.com/repos/antedoro/CriptoMenu-golang/releases/latest | grep "browser_download_url.*AppleSilicon.zip" | cut -d '"' -f 4)
  if [ -n "$CRIPTOMENU_URL" ]; then
    curl -L -o /tmp/CriptoMenu_AppleSilicon.zip "$CRIPTOMENU_URL"
    unzip -q /tmp/CriptoMenu_AppleSilicon.zip -d /Applications
    rm /tmp/CriptoMenu_AppleSilicon.zip
    echo "CriptoMenu installed in /Applications"
  else
    echo "Could not find CriptoMenu Silicon download URL"
  fi
fi

# Install SensorMenu-golang (macOS Silicon)
if [ ! -d "/Applications/SensorMenu.app" ] && [ "$(uname -m)" = "arm64" ]; then
  echo "Installing SensorMenu for macOS Silicon..."
  SENSORMENU_URL=$(curl -s https://api.github.com/repos/antedoro/SensorMenu-golang/releases/latest | grep "browser_download_url.*arm64.zip" | cut -d '"' -f 4)
  if [ -n "$SENSORMENU_URL" ]; then
    curl -L -o /tmp/SensorMenu-macOS-arm64.zip "$SENSORMENU_URL"
    unzip -q /tmp/SensorMenu-macOS-arm64.zip -d /Applications
    rm /tmp/SensorMenu-macOS-arm64.zip
    echo "SensorMenu installed in /Applications"
  else
    echo "Could not find SensorMenu Silicon download URL"
  fi
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme for Oh My Zsh
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
  echo "Powerlevel10k already installed, skipping clone..."
fi

# Install zsh plugins
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install Powerline Fonts
if ! fc-list | grep -i "Powerline" > /dev/null; then
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
else
  echo "Powerline fonts already installed, skipping..."
fi

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy config gitconfig files to the home directory
echo "Copying .gitconfig to home directory..."
cp -f "$DOTFILES_DIR/.gitconfig" $HOME/.gitconfig

# Copy config zsh config files to the home directory
echo "Copying .zshrc and .p10k.zsh to home directory..."
cp -f "$DOTFILES_DIR/.zshrc" $HOME/.zshrc
cp -f "$DOTFILES_DIR/.p10k.zsh" $HOME/.p10k.zsh

# Copy fastfetch config
echo "Copying fastfetch config..."
mkdir -p "$HOME/.config/fastfetch"
cp -f "$DOTFILES_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# Set macOS preferences - we will run this last because this will reload the shell
# source ./.macos

echo "Installation complete! Please restart your terminal."
echo "To customize prompt, run p10k configure or edit ~/.p10k.zsh"