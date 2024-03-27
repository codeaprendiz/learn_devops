# git

## NAME

git - the content tracker

## DESCRIPTION

Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.

## EXAMPLES

### Regularly Used

```bash
# initialize local repo
git init
```

- To pull the latest changes from `master`

```bash
## git pull origin <branch-name>
## --ff-only : This option stands for "fast-forward only." When you use this option, git pull will only complete if the changes can be merged into your local branch using a fast-forward merge. A fast-forward merge happens when there are no divergent commits between the local and remote branches, meaning your local branch can just be "fast-forwarded" to match the remote branch
git pull origin master --ff-only
```

- To push all the changes to the `master` branch.

```bash
git remote show origin
git add .
git status
git commit -m "Name-for-this-commit"
git push -u origin master
```

### Configuring Git Examples

- Tell Git who you are

```bash
git config --global user.name "Sam Smith"
git config --global user.email sam@example.com
```

- To check currently set git config

```bash
$ git config user.name
Ankit
git config user.email
youemail@gmail.com
```

- To list the current `git config`, like the `user.name` and `user.email`

```bash
git config --list
## For --no-pager output
GIT_PAGER= git config --list
```

- Signing commits with gpg key
  - [docs](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)

```bash
$ git config --global gpg.format openpgp
.
$ git config --global user.signingkey <your_gpg_key>
.
# To ensure commits are signed by default
$ git config --global commit.gpgsign true
.
```

### Other Examples

- Incase you want to change the origin url then you can use the command

```bash
# To Check the existing origin
$ git remote show origin
# To set the origin to a new remote, let's say the new origin is git@github.com:codeaprendiz/devops_prv.git 
$ git remote set-url origin git@github.com:codeaprendiz/devops_prv.git
```

- Create a new local repository

```bash
git init
```

- Add one or more files to staging (index):

```bash
git add <filename>
git add *
git add .
```

- Commit changes to head (but not yet to the remote repository)

```bash
git commit -m "Commit message"
```

- Send changes to the master branch of your remote repository:

```bash
git push origin master
```

- List the files you've changed and those you still need to add or commit:

```bash
git status
```

- If you haven't connected your local repository to a remote server, add the server to be able to push to it:

```bash
git remote add origin <server>
```

- List all currently configured remote repositories:

```bash
git remote -v
```

- Create a new branch and switch to it:

```bash
# git checkout -b <branchname>
$ git checkout -b feature/branch1
```

- To checkout a given branch

```bash
# git checkout <branchname>

# To checkout master
$ git checkout master
# To checkout feature/branch1
$ git checkout feature/branch1
```

- List all the branches in your repo, and also tell you what branch you're currently in:

```bash
git branch

# OR
$ git --no-pager branch

# for ZSH
gb
```

- Delete the feature branch:

```bash
git branch -d <branchname>
```

- Push the branch to your remote repository, so others can use it:

```bash
git push origin <branchname>
```

- Fetch and merge changes on the remote server to your working directory:

```bash
git pull
```

- To merge a different branch into your active branch:

```bash
git merge <branchname>
```

- View all the merge conflicts:

```bash
git diff
```

- To check previous commit history

```bash
git log
```

- Instead, to drop all your local changes and commits, fetch the latest history from the server and point your local master branch at it, do this:

```bash
git fetch origin
git reset --hard origin/master
# or if already updated with origin
git reset --hard
```

- Search the working directory for foo():

```bash
git grep "foo()"
```

- To un-commit the changes you have recently committed to local. Note the "\" is due to the shell.

```bash
git reset --soft HEAD\^
```

- To check the size of you git repo

```bash
$ git bundle create tmp.bundle --all
$ du -sh tmp.bundle
 19M    tmp.bundle
```

- To find the size of github repository locally [stackoverflow](https://stackoverflow.com/questions/8185276/find-size-of-git-repository)

```bash
$ git bundle create tmp.bundle --all
.
$ du -sh tmp.bundle
.
$ rm tmp.bundle
.
```

- To permanently remove few commits from remote branch (USE WITH CAUTION) [stackoverflow link](https://stackoverflow.com/questions/3293531/how-to-permanently-remove-few-commits-from-remote-branch)
  - Let's say the remote commits are in this order (D <- C <- B <- A)
    - `B` is the last working commit
    - So we want the remote to be in state ( B <- A )

```bash
# git reset --hard <last_working_commit_id>
# This will make the remote to.           B <- A
git reset --hard B
git push --force
```

[github.blog » easier-builds-and-deployments-using-git-over-https-and-oauth](https://github.blog/2012-09-21-easier-builds-and-deployments-using-git-over-https-and-oauth/)

- To replace any instance of `https://github.com/` with `https://$PAT:x-oauth-basic@github.com/` whenever you interact with a repository.
- This can be particularly useful if you want to use HTTPS authentication with a PAT.

```bash
$ git config --global url."https://$PAT:x-oauth-basic@github.com/".insteadOf "https://github.com/"
.
```

- To configures Git to replace any instance of the SSH URL `ssh://git@github.com/` with the HTTPS URL containing your PAT `(https://$PAT:x-oauth-basic@github.com/)` whenever you interact with a repository.

```bash
$ git config --global url."https://$PAT:x-oauth-basic@github.com/".insteadOf "ssh://git@github.com/"
.
```

- To delete all branches `locally` that have been merged [stackoverflow](https://stackoverflow.com/questions/6127328/how-do-i-delete-all-git-branches-which-have-been-merged)

```bash
$ git --no-pager branch --merged  | egrep -v "master" | xargs git branch -d
.
```

- To merge master to your current branch

```bash
# Let's you are on branch branch1, and you want to merge master latest changes to branch1
# If you want to merge via rebase
# $ git config pull.rebase true
# If you want to merge without rebase
$ git config pull.rebase false
$ git pull origin master
# you will be asked to give a commit for the changes in your default editor, save and close the file
# Push your changes to origin/branch1
$ ggpush  # zsh alias | git push -u origin branch1
```

- To create a new tag and push to remote. You should be able to see the `tags` in `Releases` section of repository

```bash
# Creates a new tag named v1.0.0 at our current commit, typically used to mark a release.
$ git tag v1.0.0
#  Pushes all of our local tags to the remote repository named origin.
$ git push origin --tags
```

- To do a git commit on a particular date say 11th Dec 2023

```bash
GIT_AUTHOR_DATE="2023-12-11 21:00:56" GIT_COMMITTER_DATE="2023-12-11 21:00:56" git commit -m "Commit for December 11th"
```
