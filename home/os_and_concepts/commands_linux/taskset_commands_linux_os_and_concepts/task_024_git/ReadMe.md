# git

- [git](#git)
  - [NAME](#name)
  - [DESCRIPTION](#description)
  - [Useful aliases](#useful-aliases)
  - [EXAMPLES](#examples)
    - [init](#init)
    - [pull - To pull the latest changes from `master`](#pull---to-pull-the-latest-changes-from-master)
    - [push -- To push all the changes to the `master` branch](#push----to-push-all-the-changes-to-the-master-branch)
    - [config -- Configuring Git Examples -- GIT\_PAGER](#config----configuring-git-examples----git_pager)
    - [rebase -- To rebase the changes](#rebase----to-rebase-the-changes)
    - [remote -- origin](#remote----origin)
    - [add -- To add a file to the staging area](#add----to-add-a-file-to-the-staging-area)
    - [commit -- To commit the changes to the repository](#commit----to-commit-the-changes-to-the-repository)
    - [push -- To push the changes to the remote repository](#push----to-push-the-changes-to-the-remote-repository)
    - [status -- To check the status of the repository](#status----to-check-the-status-of-the-repository)
    - [checkout -- To checkout a branch](#checkout----to-checkout-a-branch)
    - [branch](#branch)
    - [merge](#merge)
    - [diff](#diff)
    - [log](#log)
    - [fetch -- To fetch the latest changes from the remote repository](#fetch----to-fetch-the-latest-changes-from-the-remote-repository)
    - [reset -- To reset the changes](#reset----to-reset-the-changes)
    - [grep](#grep)
    - [bundle](#bundle)
    - [tag](#tag)
    - [ls-remote](#ls-remote)
    - [To do a commit on particual date](#to-do-a-commit-on-particual-date)
    - [rm](#rm)
    - [rev-list | To get the commit-id associated with a git tag](#rev-list--to-get-the-commit-id-associated-with-a-git-tag)

## NAME

git - the content tracker

## DESCRIPTION

Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.

## Useful aliases

```bash
alias lc="git --no-pager log | head -n 1 | cut -c 8-15"
alias jj='f(){ gaa; gcmsg "${1:-chore: update}"; ggpush; }; f'
alias ht="git --no-pager tag --points-at HEAD"
alias devtags="git --no-pager ls-remote --tags | egrep "refs/tags/dev" | awk {'print $2'} | sort -V | tail -n 2"
alias dlocal="git --no-pager branch --merged  | egrep -v master | xargs git branch -d"
```

## EXAMPLES

### init

```bash
# initialize local repo
git init
```

### pull - To pull the latest changes from `master`

```bash
# git pull origin <branch-name>
# --ff-only : This option stands for "fast-forward only." When you use this option, git pull will only complete if the changes can be merged into your local branch using a fast-forward merge. A fast-forward merge happens when there are no divergent commits between the local and remote branches, meaning your local branch can just be "fast-forwarded" to match the remote branch
git pull origin master --ff-only
```

- Fetch and merge changes on the remote server to your working directory:

```bash
git pull
```

### push -- To push all the changes to the `master` branch

```bash
git remote show origin
git add .
git status
git commit -m "Name-for-this-commit"
git push -u origin master
```

Force push local changes to remote branch (USE WITH CAUTION)

```bash
# the --force option overwrites the remote branch with your local one. (USE WITH CAUTION)
git push --force
```

- Pushes all of our local tags to the remote repository

```bash
#  Pushes all of our local tags to the remote repository
git push origin --tags
```

- To push a specific tag to remote
  
```bash
# Push the tag to the remote repository named origin.
git push origin v1.0.0
```

### config -- Configuring Git Examples -- GIT_PAGER

- To list the current `git config`, like the `user.name` and `user.email` with `--no-pager`

```bash
git --no-pager config --list
```

```bash
GIT_PAGER= git config --list
```

- To check currently set global config

```bash
git --no-pager config --global --list
```

- To check currently set local config

```bash
git --no-pager config --local --list
```

- Tell Git who you are, use `--global` if you want to set it globally, use `--local` if you want to set it for a specific repository

```bash
git config --global user.name "Sam Smith"
```

```bash
git config --global user.email sam@example.com
```

- To check currently set git config

```bash
git config user.name
```

```bash
git config user.email
```

- Signing commits with gpg key
  - [docs](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)

- To set the gpg format, use `--global` if you want to set it globally, use `--local` if you want to set it for a specific repository

```bash
git config --local gpg.format openpgp
```

- To set the gpg key, use `--global` if you want to set it globally, use `--local` if you want to set it for a specific repository

```bash
git config --local user.signingkey <your_gpg_key>
```

- To sign all commits by default, use `--global` if you want to set it globally, use `--local` if you want to set it for a specific repository

```bash
git config --local commit.gpgsign true
```

- If you mac crashes, you might get errors like `gpg: Note: database_open xxxx waiting for lock (held by xxxx) ...`, [superuser.com » GPG stops doing anything on Mac](https://superuser.com/questions/1811518/gpg-stops-doing-anything-on-mac)

```bash
$ ls ~/.gnupg/public-keys.d/*.lock
.
$ mv /Users/<username>/.gnupg/public-keys.d/pubring.db.lock /Users/<username>/.gnupg/public-keys.d/pubring.db.lock_bkp
```

[github.blog » easier-builds-and-deployments-using-git-over-https-and-oauth](https://github.blog/2012-09-21-easier-builds-and-deployments-using-git-over-https-and-oauth/)

- To replace any instance of `https://github.com/` with `https://$PAT:x-oauth-basic@github.com/` whenever you interact with a repository.
- This can be particularly useful if you want to use HTTPS authentication with a PAT.

```bash
git config --global url."https://$PAT:x-oauth-basic@github.com/".insteadOf "https://github.com/"
```

- To configures Git to replace any instance of the SSH URL `ssh://git@github.com/` with the HTTPS URL containing your PAT `(https://$PAT:x-oauth-basic@github.com/)` whenever you interact with a repository.

```bash
git config --global url."https://$PAT:x-oauth-basic@github.com/".insteadOf "ssh://git@github.com/"
```

- Switch between Secure Channel and OpenSSL for Git's HTTPS transport by setting the http.sslBackend config variable to "openssl" or "schannel". [How do I configure Git to trust certificates from the Windows Certificate Store?](https://stackoverflow.com/questions/16668508/how-do-i-configure-git-to-trust-certificates-from-the-windows-certificate-store)

```bash
git config --global http.sslBackend schannel
```

- To unset a config

```bash
git config --global --unset user.name
```

### rebase -- To rebase the changes

- How to change author of all commits from a particular commit [stackoverflow.com](https://stackoverflow.com/questions/3042437/how-can-i-change-the-commit-author-for-a-single-commit)
  - For example, if your commit history is A-B-C-D-E-F with F as HEAD, and you want to change the author of C and D, then you would...

```bash
EDITOR=vim git rebase -i B
```

- Change the lines for both C and D from pick to edit
- Exit the editor (for vim, this would be pressing Esc and then typing :wq).
- Once the rebase started, it would first pause at C
- You would then run the following commands

```bash
# To know your current author, you can go to recent commits URL and add .patch at the end. You should be signed in to see the details. Also you can run git log.
EDITOR=vim git commit --amend --author="Author Name <email@address.com> --no-edit
```

- Then you would run

```bash
git rebase --continue
```

- It would pause again at D
- Continue with the same steps as above until you reach HEAD i.e., F
- Once you are done, you can run

```bash
git push -f
```

### remote -- origin

- Incase you want to change the origin url then you can use the command

```bash
# To Check the existing origin
git remote show origin
```

```bash
# To set the origin to a new remote, let's say the new origin is git@github.com:codeaprendiz/devops_prv.git 
git remote set-url origin git@github.com:codeaprendiz/devops_prv.git
```

- If you haven't connected your local repository to a remote server, add the server to be able to push to it:

```bash
git remote add origin <server>
```

- List all currently configured remote repositories:

```bash
git remote -v
```

- To delete all stale branches from local that have been deleted from remote [stackoverflow.com » Git remote branch deleted, but still it appears in 'branch -a'](https://stackoverflow.com/questions/5094293/git-remote-branch-deleted-but-still-it-appears-in-branch-a)

```bash
git remote prune origin
```

### add -- To add a file to the staging area

- Add one or more files to staging (index):

```bash
git add <filename>
git add *
git add .
```

### commit -- To commit the changes to the repository

- Commit changes to head (but not yet to the remote repository)

```bash
git commit -m "Commit message"
```

- To amend the author of the most recent commit 

```bash
git commit --amend --author="Author Name <email@address.com>" --no-edit
```

```bash
git push -f
```

### push -- To push the changes to the remote repository

- Send changes to the master branch of your remote repository:

```bash
git push origin master
```

- Push the branch to your remote repository, so others can use it:

```bash
git push origin <branchname>
```

### status -- To check the status of the repository

- List the files you've changed and those you still need to add or commit:

```bash
git status
```

### checkout -- To checkout a branch

- Create a new branch and switch to it:

```bash
# git checkout -b <branchname>
git checkout -b feature/branch1
```

- To checkout a given branch

```bash
# git checkout <branchname>
# To checkout master
git checkout master
```

```bash
# To checkout feature/branch1
git checkout feature/branch1
```

### branch

- List all the branches in your repo, and also tell you what branch you're currently in:

```bash
git branch
```

```bash
git --no-pager branch
```

```bash
# for ZSH
gb
```

- Delete the feature branch:

```bash
git branch -d <branchname>
```

- To delete all branches `locally` that have been merged [stackoverflow](https://stackoverflow.com/questions/6127328/how-do-i-delete-all-git-branches-which-have-been-merged)

```bash
git --no-pager branch --merged  | egrep -v "master" | xargs git branch -d
```

- To list all remote branches and checkout

```bash
# list all remote branches
git branch -r
```

```bash
# to checkout branch1
git checkout branch1
```

### merge

- Merge local `master` branch to local `branch1`

```bash
# This command merges changes from local master into your current branch (e.g., branch1). If there are any conflicts, you will need to resolve them manually. A merge commit will be created to signify the merge.
git merge master
```

- To merge a different branch into your active branch:

```bash
git merge <branchname>
```

- To merge master to your current branch without rebasing

```bash
## This will fetch the latest changes from master and merge them into your current branch. If there are conflicts, you will be prompted to resolve them, and you will be asked to provide a commit message for the merge commit
git config pull.rebase false
```

```bash
git pull origin master
```

```bash
# you will be asked to give a commit for the changes in your default editor, save and close the file
# Push your changes to origin/branch1
git push -u origin branch1 # zsh alias | ggpush
```

- To merge master to your current branch with rebasing

```bash
## This will fetch the latest changes from master and reapply your local commits on top of these changes. It helps to maintain a linear project history.
git config pull.rebase true
```

```bash
$ git pull origin master
```

```bash
# Push your changes to origin/branch1
$ git push -u origin branch1 # zsh alias | ggpush
```

### diff

- View all the merge conflicts:

```bash
git diff
```

### log

- To check previous commit history

```bash
git log
```

- To check history of a particual file say `file1.txt`

```bash
git log -p -- file1.txt
```

- , fetch the latest history from the server and point your local master branch at it, do this:

### fetch -- To fetch the latest changes from the remote repository

```bash
git fetch origin
```

### reset -- To reset the changes

To drop all your local changes and commits

```bash
git reset --hard origin/master
```

```bash
# or if already updated with origin
git reset --hard
```

- To un-commit the changes you have recently committed to local. Note the "\" is due to the shell.

```bash
git reset --soft HEAD\^
```

- To permanently remove few commits from remote branch (USE WITH CAUTION) [stackoverflow link](https://stackoverflow.com/questions/3293531/how-to-permanently-remove-few-commits-from-remote-branch)
  - Let's say the remote commits are in this order (D <- C <- B <- A)
    - `B` is the last working commit
    - So we want the remote to be in state ( B <- A )

```bash
# git reset --hard <last_working_commit_id>
# This will make the remote to.           B <- A
git reset --hard B
```

```bash
git push --force
```

### grep

- Search the working directory for foo():

```bash
git grep "foo()"
```

### bundle

- To check the size of you git repo

```bash
git bundle create tmp.bundle --all
```

```bash
$ du -sh tmp.bundle
 19M    tmp.bundle
```

- To find the size of github repository locally [stackoverflow](https://stackoverflow.com/questions/8185276/find-size-of-git-repository)

```bash
git bundle create tmp.bundle --all
```

```bash
du -sh tmp.bundle
```

### tag

- To create a new tag and push to remote. You should be able to see the `tags` in `Releases` section of repository

```bash
# Creates a new tag named v1.0.0 at our current commit, typically used to mark a release.
git tag v1.0.0
```

```bash
# Pushes all of our local tags to the remote repository named origin.
git push origin --tags
```

- To create a tag on commit ID `abcdef` and push to remote

```bash
# Creates a new tag named v1.0.0 at the commit specified by the commit ID (abcdef).
git tag v1.0.0 abcdef
```

```bash
# Push the tag to the remote repository named origin.
git push origin v1.0.0
```

- To get the tag that points at HEAD

```bash
git --no-pager tag --points-at HEAD
```

- To delete a tag

```bash
# To delete a tag locally
git tag -d v1.0.0
```

```bash
# To delete a tag from remote
$ git push origin :refs/tags/v1.0.0
```

### ls-remote

```bash
# To list all the tags in the repository
git ls-remote --tags
```

### To do a commit on particual date

- To do a git commit on a particular date say 11th Dec 2023

```bash
GIT_AUTHOR_DATE="2023-12-11 21:00:56" GIT_COMMITTER_DATE="2023-12-11 21:00:56" git commit -m "Commit for December 11th"
```

### rm

- To ignore all occurance of a file say `mvnw` from git (assuming it was commited previously and version tracked)

```bash
# To untrack a specific file without deleting it
git rm --cached <file-path>
```

```bash
# Example for 'mvnw' files
git rm --cached **/mvnw
# Then add the following to .gitignore
# **/mvnw
```

- To ingnore all occurance of a folder `.mvn` from git (assuming it was commited previously and version controlled)

```bash
# To untrack everything under '.mvn'
# Note, the -r that is required for recursive operation
git rm --cached **/.mvn -r

# Then add the following to .gitignore
# **/.mvn
```

### rev-list | To get the commit-id associated with a git tag

[stackoverflow.com » How to tell which commit a tag points to in Git](https://stackoverflow.com/questions/1862423/how-to-tell-which-commit-a-tag-points-to-in-git)

If you want to find the commit associated with `dev-1.1` tag, you can use the following command

```bash
git rev-list  -n 1 dev-1.1
```
