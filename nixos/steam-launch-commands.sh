#!/usr/bin/env bash

# Steam Root Path
STEAM_ROOT="$HOME/.local/share/Steam"
# STEAM_ROOT="$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam"

USERDATA_DIR="$STEAM_ROOT/userdata"

echo "# Steam Launch Options Backup"
echo ""
echo "| AppID | Launch Options |"
echo "| :--- | :--- |"

for user_dir in "$USERDATA_DIR"/*/; do
    CONFIG_FILE="${user_dir}config/localconfig.vdf"
    
    if [ -f "$CONFIG_FILE" ]; then
        # Exporting functions/vars so Perl can see them if needed, 
        # but here we'll process the Perl output with a while loop.
        
        perl -0777 -ne '
            while (/^(\s*"(\d+)"\s*\{.*?(?=\s*"\d+"\s*\{|\z))/gsm) {
                $block = $1; $appid = $2;
                if ($block =~ /"LaunchOptions"\s+"([^"]+)"/) {
                    print "$appid|$1\n";
                }
            }
        ' "$CONFIG_FILE" | while read -r line; do
            APPID=$(echo "$line" | cut -d'|' -f1)
            OPTIONS=$(echo "$line" | cut -d'|' -f2)
            
            # Escape pipes in options to avoid breaking the MD table
            CLEAN_OPTIONS=$(echo "$OPTIONS" | sed 's/|/\\|/g')
            
            echo "| $APPID | \`$CLEAN_OPTIONS\` |"
        done
    fi
done