#!/bin/bash
# A script for batch privatization of GitHub repositories

confirmation="n"

while [ "$confirmation" != "${confirmation#[Nn]}" ];do
  printf "\nEnter your GitHub username: "
  read username
  printf "\nYou entered: $username"
  printf "\nIs this correct (y/n)? "
  read confirmation
done

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for file in *; do
  if [ -d "$file" ]; then
    cd "$file"
    printf "\nDeleting remote repo $file on GitHub"
    hub delete -y $file
    printf "\nCreating new private GitHub repo with name $file"
    hub create -p $file
    printf "\nSetting this local repository's remote URL to the recently created private repo's URL"
    git remote set-url origin git@github.com:$username/$file.git
    printf "\nPushing to GitHub"
    git push
    printf "\nSuccess!"
    cd ..
  fi
done

printf "\nAll done!"