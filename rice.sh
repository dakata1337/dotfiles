#!/bin/bash
set -e
RED="\x1b[31;1m"
GREEN="\x1b[32;1m"
YELLOW="\x1b[33;1m"
RST="\x1b[0m"
CURSORS_PATH="/usr/share/icons/"

function log() {
	if [ $1 == "ERROR" ]; then
		printf "[${RED}ERROR${RST}] $2\n"
	elif [ $1 == "WARN" ]; then
		printf "[${YELLOW}WARN${RST}] $2\n"
	elif [ $1 == "INFO" ]; then
		printf "[${GREEN}INFO${RST}] $2\n"
	else
		printf "$1\n"
	fi
}

function is_installed() {
	command -v $1 &> /dev/null
}

# bootstrap paru installer
function bootstrap_paru() {
	sudo pacman -S git
	git clone https://aur.archlinux.org/paru-bin
	cd paru-bin
	makepkg -si
	cd ..
	rm -rf paru-bin
}

if is_installed "paru"; then
	log "INFO" "paru is installed... skip"
else
	log "INFO" "installing paru"
	bootstrap_paru
fi

INSTALL="paru -S --needed --noconfirm"


# Install window manager & surrounding software
$INSTALL uwsm hyprland hyprshot waybar wofi foot fnott wl-clipboard wl-clip-persist xdg-desktop-portal-hyprland

# install general software
$INSTALL librewolf-bin chromium gimp vlc mpv ffmpeg yt-dlp discord obs-studio ttf-hack-nerd breeze-icons jq

# install programming software
$INSTALL nvim go rustup unzip ripgrep fd npm luarocks wget github-cli
rustup default stable

if gh auth status &>/dev/null; then
    log "INFO" "You are already logged into GitHub CLI."
else
    gh auth login
fi

if [ ! -d "/home/$(whoami)/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    log "INFO" "source ~/.aliases" >> ~/.zshrc
else
    log "INFO" "oh-my-zsh is already installed"
fi

log "INFO" "Copying .config files"
cp -r ./configs/* ~/.config
cp ./.aliases ~/

log "INFO" "Installing Breeze Light cursor theme without KDE bloat >:)"
sudo mkdir -p $CURSORS_PATH
sudo cp -r ./cursors/Breeze_Light $CURSORS_PATH
