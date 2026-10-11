#!/bin/sh
set -e

# Load helper functions and env
source "./helpers.sh"

CURSORS_PATH="/usr/share/icons/"

bootstrap_paru

log "INFO" "==========[installing system fonts]=========="
pkg-add "ttf-ibmplex-mono-nerd fontconfig"
log "INFO" "rebuiling font cache"
printf "."
fc-cache -f
printf ".."
sudo fc-cache -f
log ".done"



log "INFO" "==========[installing desktop environment]=========="
pkg-add "linux-firmware-amd linux-firmware-amdgpu linux-firmware-mediatek"

# Install window manager & surrounding software
pkg-add "uwsm hyprland foot wl-clipboard wl-clip-persist xdg-desktop-portal-hyprland xdg-user-dirs xdg-desktop-portal-gtk gsettings-desktop-schemas noctalia"

# Install general software
pkg-add "zen-browser-bin gimp vlc mpv ffmpeg yt-dlp obs-studio jq qbittorrent supersonic-desktop-bin btop pipewire-openrc pipewire-alsa pipewire-jack pipewire-pulse-openrc wireplumber-openrc xdg-desktop-portal-wlr"
rc-update add pipewire default --user
rc-update add pipewire-pulse default --user
rc-update add wireplumber default --user

pkg-add "xdg-user-dirs xdg-user-dirs-gtk"
mkdir -p ~/Pictures/Screenshots
cp -r ./Wallpapers ~/Pictures

# Install programming software
pkg-add "zed go unzip ripgrep fd luarocks wget github-cli zsh"

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



log "INFO" "==========[copying .config files]=========="
cp -r configs/* ~/.config
cp .aliases ~/
mkdir -p ~/.config/noctalia
cp ./noctalia-config.toml ~/.config/noctalia/config.toml


log "INFO" "Installing Breeze Light cursor theme without KDE bloat >:)"
sudo mkdir -p $CURSORS_PATH
sudo cp -r ./cursors/Breeze_Light $CURSORS_PATH
