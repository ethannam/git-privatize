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

total_repos=$(find $parent_path -type d -maxdepth 1 | wc -l)
((total_repos--))

count=1

bold=$(tput bold)
normal=$(tput sgr0)

for file in *; do
  if [ -d "$file" ]; then
    cd "$file"

    message="Deleting remote repo $file on GitHub..."
    printf "\n\n${bold}$message${normal}\n"
    hub delete -y $file

    message="Creating new private GitHub repo with name $file..."
    printf "\n\n${bold}$message${normal}\n"
    hub create -p $file

    message="Setting this local repository's remote URL to the recently created private repo's URL..."
    printf "\n\n${bold}$message${normal}\n"
    git remote set-url origin git@github.com:$username/$file.git
    printf "Set new remote url.\n"

    message="Pushing to GitHub..."
    printf "\n\n${bold}$message${normal}\n"
    git push

    message="Successfully privatized repo $count of $total_repos"
    printf "\n\n${bold}$message${normal}\n"

    ((count++))

    cd ..
  fi
done

message="All done 🤗 🤗 🤗"
printf "\n\n${bold}$message${normal}\n"