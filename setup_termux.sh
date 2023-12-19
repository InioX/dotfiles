pkg install jq cronie termux-services git gh
sv-enable crond
crontab -e

git clone "https://github.com/InioX/dotfiles" "$HOME/dotfiles"
cd "$HOME/dotfiles" && git checkout android

cp bashrc "$HOME/.bashrc"

gh auth login
