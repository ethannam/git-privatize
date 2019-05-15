# git-privatize
A shell script for batch privatization of GitHub repositories

## Why does this exist?
GitHub doesn't allow you to make multiple repositories private at one time. Their web app forces you to navigate to each repository's settings page and type in the repository name as a form of confirmation.

![Alt Text](https://media.giphy.com/media/bWM2eWYfN3r20/giphy.gif)

## How does it work?
The shell script is very simple. The script...

1. Assumes all the repositories you want to make private exist in the same folder as the shell script itself.
2. CD's into each folder.
3. Deletes the remote repository on GitHub. Your local repository will remain intact.
4. Creates a new remote repository on GitHub using the same name as the local repository. The new repository is automatically set to private.
5. Sets the local repository's remote URL to the new repository's remote URL.
6. Pushes the local repository's contents to GitHub.
7. CD's back to the root folder.
8. Repeats steps 2-7 for all remaining repositories in the root folder.

## Getting Started
Follow these instructions:

### 1. Install Hub
You need this to run special git commands from the command line.

If you have homebrew, you can install by running this command:

```
$ brew install hub
$ hub version
git version 1.7.6
hub version 2.2.3
```

Otherwise, please follow the [Official Installation Instructions](https://github.com/github/hub)

### 2. Enable the 'delete_repo' scope
A. Navigate to [github.com/settings/tokens](https://github.com/settings/tokens)
B. Find the token for hub
C. Check the box for "delete_repo"
D. Confirm the change by clicking the "Update token" button at the bottom

### 3. Set up SSH agent
If GitHub currently asks you to enter your username and password everytime you push or pull, you're not using SSH agent.

As [this tutorial](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) states: "If you don't want to reenter your passphrase every time you use your SSH key, you can add your key to the SSH agent, which manages your SSH keys and remembers your passphrase."

Since we're going to be doing git commands in bulk, I highly recommend you set this up, or else Git may ask you for your credentials repeatedly.

Please follow [the directions to set up SSH agent](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) carefully.

### 4. Check that SSH agent is working
Try push/pulling and see if GitHub asks you for your credentials.

### 5. Move the repositories you want to make private into a single folder
The folder name does not matter.

### 6. Move the shell script
Copy the shell script included in this repo into the folder you made in step #5 above.

## Running the Script
You can run the script by executing:

```
./git-privatize.sh
```

If you get an error that permission is denied, run:

```
chmod +x git-privatize.sh
```