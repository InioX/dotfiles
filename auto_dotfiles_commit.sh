#!/bin/bash

dotfiles_dir="$HOME/dotfiles"
obtainium_dir="$HOME/storage/shared/backups/obtainium"

get_latest_file() {
    echo ${1}/$(ls ${1} -rt | tail -1)
}

get_latest_file_name() {
    ls ${1} -rt | tail -1
}

obtainium_backup=$(get_latest_file "${obtainium_dir}")

if [ -d "$dotfiles_dir" ]
then
    cd ${dotfiles_dir} && git pull >> /dev/null
else
    git clone 'https://github.com/InioX/dotfiles' "$dotfiles_dir" >> /dev/null
    cd "$dotfiles_dir" && git checkout android >> /dev/null
fi

generate_description() {
    cat ${obtainium_backup} | jq '.[].[] | select (.installedVersion != .latestVersion) | "- \(.name) [\(.installedVersion) => \(.latestVersion)]"' -r
}

description=$(cat << END
chore: update obtainium-export.json

Changed:
$(generate_description)
END
)

git config --global user.email "81521595+InioX@users.noreply.github.com"
git config --global user.name "InioX"

cp ${obtainium_backup} "${dotfiles_dir}/obtainium-export.json"
cd ${dotfiles_dir} && git add "obtainium-export.json" && git commit -m "${description}"

git push
