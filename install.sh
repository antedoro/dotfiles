#!/bin/bash

# Install Xcode Command Line Tools
if ! xcode-select --print-path &> /dev/null; then
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
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
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


# ... (previous installation steps: Homebrew, apps, etc.)

# Configure Mackup properly
echo "Configuring Mackup..."
MACKUP_DIR="$HOME/dotfiles/mackup"
mkdir -p "$MACKUP_DIR"

# Create Mackup config file
cat > ~/.mackup.cfg <<EOF
[storage]
engine = file_system
path = $HOME/dotfiles/mackup
EOF

# First backup existing settings (creates directory structure)
echo "Creating initial Mackup backup..."
mackup backup --force 2>/dev/null || true

# Then restore from our dotfiles
echo "Restoring preferences..."
mackup restore --force



# Ensure Mackup uses our config
# echo "[storage]
# engine = file_system
# path = dotfiles/mackup" > ~/.mackup.cfg
# mackup restore # Restore preferences with Mackup

echo "Installation complete! Please restart your terminal."