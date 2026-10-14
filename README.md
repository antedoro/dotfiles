# My macOS Dotfiles

These are my macOS dotfiles for setting up a new machine, optimized for macOS and Apple Silicon.  
*NB: To install Brother iPrint&Scan be sure to login to the Mac App Store beforehand.*

## Features

- **Homebrew**: Package management for CLI tools, GUI applications, and fonts via `Brewfile`.
- **Oh My Zsh**: Configured with the **Powerlevel10k** theme and essential plugins (autosuggestions, syntax highlighting).
- **Fastfetch**: Custom system information display upon opening a terminal session.
- **Finder Menu**: Right-click context menu enhancements for macOS Finder (New File, Open Terminal Here, Open Folder With, Copy Path, Go to Parent Folder).
- **Apple Silicon Optimized**: Automatic download and installation of specialized tools (`ImgCompress`, `CriptoMenu`, `SensorMenu`) for Apple Silicon (M-series).
- **macOS Defaults**: Preconfigured system preferences via the `.macos` script.
- **Automation Scripts**: Helper scripts for setup (`install.sh`), cloning personal repositories (`clone.sh`), and pushing updates (`push.sh`).

## Repository Structure

| File / Directory | Description |
| ---------------- | ----------- |
| `Brewfile` | Homebrew bundle defining taps, CLI tools, casks, fonts, and Mac App Store apps |
| `install.sh` | Main setup script: installs Homebrew, formulas, Oh My Zsh, Silicon apps, and configs |
| `clone.sh` | Clones personal GitHub repositories into `$HOME` (e.g. `rsync_scripts`) |
| `push.sh` | Automated synchronization script: verifies remotes, runs security checks, commits, and pushes to GitHub |
| `.zshrc` | Zsh configuration including plugins, path exports, and aliases (`dotpush`, `zshconfig`) |
| `.p10k.zsh` | Powerlevel10k prompt configuration |
| `.gitconfig` | Base Git aliases and editor configuration |
| `.gitignore` | Ignored files and patterns |
| `.macos` | Comprehensive macOS system and application defaults |
| `fastfetch/` | Configuration files for Fastfetch system banner |

## Installation

1. **Clone this repository** to your home directory:

   ```bash
   git clone https://github.com/antedoro/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

   *Alternatively, download and extract the project zip file from GitHub.*

2. **Run the installation script**:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **Clone personal repositories** (optional):

   ```bash
   chmod +x clone.sh
   ./clone.sh
   ```

4. **Post-installation configuration**:
   - Run `p10k configure` if you wish to customize your Powerlevel10k prompt.
   - Approve any kernel or system extensions requested by applications (LuLu, Finder Menu, etc.).
   - Complete manual logins for Mac App Store apps (Brother iPrint&Scan).

## Manual Steps

Some applications require manual permission or initial setup after installation:
- **Brother iPrint&Scan**: Complete manufacturer setup after MAS installation.
- **LuLu**: Requires network extension approval in System Settings → Privacy & Security.
- **Docker**: Requires manual launch and initial authorization.
- **Finder Menu**: Enable extension under System Settings → General → Login Items & Extensions if prompted; customize via `finder-menu settings`.

## Updating & Uploading Changes

To sync your local changes to GitHub, use the automated [`push.sh`](push.sh) script:

```bash
cd ~/dotfiles
./push.sh "Describe your changes"
```

*If no commit message is provided, an automatic timestamped message will be generated.*

### Quick Alias: `dotpush`

The provided `.zshrc` includes the `dotpush` (and `dotupdate`) alias, allowing you to push updates from anywhere:

```bash
dotpush
# or with a custom commit message:
dotpush "Add new brew package"
```

The script automatically:
1. Runs `git pull --rebase` to integrate any remote updates.
2. Checks for uncommitted changes (exits cleanly if already up to date).
3. Performs a security check to detect accidentally included GitHub tokens or private SSH keys.
4. Stages all changes, creates the commit, and pushes to `origin/main`.

## Security Best Practices

Before pushing changes:

1. **Check for credentials**:
   ```bash
   grep -r "email\|password\|token\|secret" .
   ```
   *(Note: `push.sh` already performs an automated check for GitHub tokens and SSH keys).*

2. **Sanitize `.gitconfig`**:
   Do not commit personal emails or credentials to public dotfiles; configure them globally on your machine:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   git config --global credential.helper osxkeychain
   ```

## Important Notes

- The first installation run may take 30+ minutes depending on your internet connection.
- Some apps like Docker and LuLu require a logout/restart or manual authorization.
- The `.macos` script is currently commented out by default in `install.sh`. Review it and run `source .macos` to apply system preferences.
