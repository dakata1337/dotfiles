#!/usr/bin/env bash
R='\x1b[31;1m'
G='\x1b[32;1m'
Y='\x1b[33;1m'
COM='\x1b[4;3m'
RST="\x1b[0m"

set -eE
trap 'log "ERROR" "Error in $BASH_SOURCE at line ${LINENO} (c=$?): ${BASH_COMMAND}"' ERR

function log() {
	if [ $1 == "ERROR" ]; then
		printf "[${R}ERROR${RST}] $2\n"
	elif [ $1 == "WARN" ]; then
		printf "[${Y}WARN${RST}] $2\n"
	elif [ $1 == "INFO" ]; then
		printf "[${G}INFO${RST}] $2\n"
	else
		printf "$1\n"
	fi
}

function bootstrap_paru() {
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
}

function INSTALL() {
    if [ ! $2 ]; then
        log "INFO" "installing: $1"
    else
        log "INFO" "$2"
    fi
    paru -S --needed --noconfirm $1 1> /dev/null
}
