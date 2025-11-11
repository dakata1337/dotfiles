#!/bin/bash
set -e
CURSORS_PATH="/usr/share/icons/"

function log() {
	if [ $1 == "ERROR" ]; then
		printf "[\x1b[31;1mERROR\x1b[0m] $2\n"
	elif [ $1 == "WARN" ]; then
		printf "[\x1b[33;1mWARN\x1b[0m] $2\n"
	elif [ $1 == "INFO" ]; then
		printf "[\x1b[32;1mINFO\x1b[0m] $2\n"
	else
		printf "$1\n"
	fi
}

# bootstrap paru installer
if command -v "paru" &> /dev/null; then
	log "INFO" "paru is installed... skip"
else
	log "INFO" "installing paru"
	sudo pacman -S git
	git clone https://aur.archlinux.org/paru-bin
	cd paru-bin
	makepkg -si
	cd ..
	rm -rf paru-bin
fi

INSTALL() {
    if [ ! $2 ]; then
        log "INFO" "installing: $1"
    else
        log "INFO" "$2"
    fi
    paru -S --needed --noconfirm $1 1> /dev/null
}

# Install window manager & surrounding software
INSTALL "uwsm hyprland hyprshot waybar wofi foot fnott wl-clipboard wl-clip-persist xdg-desktop-portal-hyprland"

# Install general software
INSTALL "librewolf-bin chromium gimp vlc mpv ffmpeg yt-dlp discord obs-studio ttf-hack-nerd breeze-icons jq qbittorrent"

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
