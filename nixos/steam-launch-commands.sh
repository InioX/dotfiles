#!/usr/bin/env bash

# 1. Define Steam Root (Comment/Uncomment based on your install)
STEAM_ROOT="$HOME/.local/share/Steam"
# For Flatpak users, use:
# STEAM_ROOT="$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam"

USERDATA_DIR="$STEAM_ROOT/userdata"

echo $STEAM_ROOT

if [ ! -d "$USERDATA_DIR" ]; then
    echo "Error: Steam userdata directory not found at $USERDATA_DIR"
    exit 1
fi

echo "--- Extracting Steam Launch Options ---"

# Loop through each Steam User ID folder
for user_dir in "$USERDATA_DIR"/*/; do
    CONFIG_FILE="${user_dir}config/localconfig.vdf"
    
    if [ -f "$CONFIG_FILE" ]; then
        USER_ID=$(basename "$user_dir")
        echo "User ID: $USER_ID"
        echo "--------------------------------------"
        
        perl -0777 -ne '
            while (/^(\s*"(\d+)"\s*\{.*?(?=\s*"\d+"\s*\{|\z))/gsm) {
                $block = $1;
                $appid = $2;
                if ($block =~ /"LaunchOptions"\s+"([^"]+)"/) {
                    printf "AppID: %-10s | Options: %s\n", $appid, $1;
                }
            }
        ' "$CONFIG_FILE"
        
        echo ""
    fi
done