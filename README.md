# My macOS Dotfiles

These are my macOS dotfiles for setting up a new machine, optimized for macOS and Apple Silicon.
NB: To install Brother iPrint&Scan be sure to login to the App Store beforehand.

## Features

- **Homebrew**: Package management for CLI tools and GUI apps.
- **Oh My Zsh**: With **Powerlevel10k** theme and essential plugins (autosuggestions, syntax highlighting).
- **Fastfetch**: Custom system information display on terminal startup.
- **Apple Silicon Optimized**: Automatic installation of specialized tools (`ImgCompress`, `CriptoMenu`, `SensorMenu`) for M-series chips.
- **macOS Defaults**: Preconfigured system preferences via `.macos` script.

## Manual Steps

- Some apps might require manual setup after installation:
- **Brother iPrint&Scan**: Follow manufacturer instructions after MAS installation.
- **LuLu**: Requires kernel extension approval in System Settings.
- **Docker**: Requires manual launch and initial setup.

## Installation

1. Clone this repository to your home directory:

   ```bash
   git clone https://github.com/antedoro/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

   *Alternatively, download and extract the project zip file from GitHub.*

2. Run the installation script:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. Post-installation configuration:
   - After installation, run `p10k configure` to customize your Powerlevel10k prompt.
   - Approve any kernel extensions requested by applications like LuLu.
   - Complete the manual configuration of apps that require it (Brother, etc.).

   ```bash
   p10k configure
   ```

4. Updating dotfiles:
   
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update dotfiles"
   git push origin main
   ```

## Important Security Check
Before pushing changes:

1. Check for credentials in your files:

   ```bash
   grep -r "email\|password\|token\|secret" .
   ```

2. Sanitize your gitconfig:

   ```bash
   git config --global credential.helper store
   ```

3. Automate Future Updates
   Add this alias to your `.zshrc` (already included in the provided `.zshrc`):

   ```bash
   alias dotupdate="cd ~/dotfiles && git add . && git commit -m 'Update dotfiles' && git push"
   ```

## Important Notes

- The first run might take a long time (30+ minutes) to download and install everything.
- Some apps like Docker and LuLu require restarts or manual authorizations.
- The `.macos` script is currently disabled by default in `install.sh`. Run it manually or uncomment it in the script to apply system preferences.
