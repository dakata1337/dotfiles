# Load helper functions and env
source "./helpers.sh"

CURSORS_PATH="/usr/share/icons/"

# bootstrap package manager
bootstrap_paru

# Install window manager & surrounding software
INSTALL "uwsm hyprland hyprshot waybar wofi foot fnott wl-clipboard wl-clip-persist xdg-desktop-portal-hyprland xdg-user-dirs xdg-desktop-portal-gtk gsettings-desktop-schemas"

# Install general software
INSTALL "zen-browser-bin chromium gimp vlc mpv ffmpeg yt-dlp discord obs-studio ttf-hack-nerd breeze-icons jq qbittorrent supersonic-desktop-bin nautilus"

# Install programming software
INSTALL "nvim go rustup unzip ripgrep fd npm luarocks wget github-cli zsh"

log "INFO" "installing rustup toolchain"
rustup default stable 1> /dev/null

if gh auth status &>/dev/null; then
    log "INFO" "You are already logged into GitHub CLI."
else
    gh auth login
fi

if [ ! -d "/home/$(whoami)/.oh-my-zsh" ]; then
    log "INFO" "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "source ~/.aliases" >> ~/.zshrc
else
    log "INFO" "oh-my-zsh is already installed"
fi

log "INFO" "Copying .config files"
cp -r ./configs/* ~/.config
cp ./.aliases ~/

log "INFO" "Installing Breeze Light cursor theme without KDE bloat >:)"
sudo mkdir -p $CURSORS_PATH
sudo cp -r ./cursors/Breeze_Light $CURSORS_PATH
