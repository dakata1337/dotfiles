#!/bin/bash
set -euo pipefail

source "./helpers.sh"

DOTFILES_DIR="$(pwd)/configs"
CONFIG_DIR="$HOME/.config"

log "INFO" "Syncing folders from $CONFIG_DIR to $DOTFILES_DIR ..."

log "INFO" "copying:"
# Loop through each folder in ~/dotfiles/configs
for dir in "$DOTFILES_DIR"/*/; do
    # Extract the folder name (strip path)
    folder_name=$(basename "$dir")

    # Check if the folder exists in ~/.config
    if [[ -d "$CONFIG_DIR/$folder_name" ]]; then
        printf "  $folder_name ... " 
        # Copy and overwrite existing files
        cp -r "$CONFIG_DIR/$folder_name" "$DOTFILES_DIR/"
        printf "${G}ok${RST}\n"
    else
        log "WARN" "Skipping $folder_name (not found in $CONFIG_DIR)"
    fi
done

log "INFO" "Sync complete!"
