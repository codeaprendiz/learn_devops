## git

### NAME

git - the content tracker

### SYNOPSIS

> git [--version] [--help] [-C <path>] [-c <name>=<value>] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path][-p|--paginate|--no-pager] [--no-replace-objects][--bare][--git-dir=<path>] [--work-tree=<path>][--namespace=<name>][--super-prefix=<path>] <command> [<args>]

### DESCRIPTION

Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.

### EXAMPLES BASICS

Create a new repository using the command line

- Create a directory using mkdir command or manually
- Go inside that directory using the terminal
- Execute the following set of commands for following set of functions
- To clone a repository

```bash
git init
git clone https://repository-url
```

- To pull the latest changes  (when you are already inside the directory containing the .git file which is generated when you execute the git init command for the first time)

```bash
git pull origin <branch-name>
```

To push the changes to the master branch

Points worth noting here
- git add -A stages All
- git add . stages new and modified, without deleted
- git add -u stages modified and deleted, without new

```bash
git remote show origin
git add .
git status
git commit -m "Name-for-this-commit"
git push -u origin master
```

Incase you want to change the origin url then you can use the command 

```bash
git remote show origin
git remote set-url origin https://repository-url
git remote add origin https://repository-url
```

### EXAMPLES

Tell Git who you are

```bash
git config --global user.name "Sam Smith"
git config --global user.email sam@example.com
```

Create a new local repository

```bash
git init
```

Checkout a repository
- Create a working copy of a local repository:

```bash
git clone /path/to/repository
```

For a remote server, use:

```bash
git clone username@host:/path/to/repository
```

Add one or more files to staging (index):

```bash
git add <filename>
git add *
git add .
```

Commit changes to head (but not yet to the remote repository)

```bash
git commit -m "Commit message"
```

Commit any files you've added with git add, and also commit any files you've changed since then:

```bash
git commit -a
```

Send changes to the master branch of your remote repository:

```bash
git push origin master
```

List the files you've changed and those you still need to add or commit:

```bash
git status
```

If you haven't connected your local repository to a remote server, add the server to be able to push to it:

```bash
git remote add origin <server>
```

List all currently configured remote repositories:

```bash
git remote -v
```

Create a new branch and switch to it:

```bash
git checkout -b <branchname>
```

Switch from one branch to another:

```bash
git checkout <branchname>
```

**Other Essential commands**

List all the branches in your repo, and also tell you what branch you're currently in:

```bash
git branch
```

Delete the feature branch:

```bash
git branch -d <branchname>
```

Push the branch to your remote repository, so others can use it:

```bash
git push origin <branchname>
```

Push all branches to your remote repository:

```bash
git push --all origin
```

Fetch and merge changes on the remote server to your working directory:

```bash
git pull
```

To merge a different branch into your active branch:

```bash
git merge <branchname>
```

View all the merge conflicts:

```bash
git diff
```

View the conflicts against the base file:

```bash
git diff --base <filename>
```

Preview changes, before merging:

```bash
git diff <sourcebranch> <targetbranch>
```

After you have manually resolved any conflicts, you mark the changed file:

```bash
git add <filename>
```

You can use tagging to mark a significant changeset, such as a release:

```bash
git tag 1.0.0 <commitID>
```

CommitId is the leading characters of the changeset ID, up to 10, but must be unique. Get the ID using: 

```bash
git log
```

Push all tags to remote repository: 

```bash
git push --tags origin
```

If you mess up, you can replace the changes in your working tree with the last content in head: 

Changes already added to the index, as well as new files, will be kept.

```bash
git checkout -- <filename>
```

Instead, to drop all your local changes and commits, fetch the latest history from the server and point your local master branch at it, do this: 

```bash
git fetch origin
git reset --hard origin/master
```

Search the working directory for foo():

```bash
git grep "foo()"
```


To un-commit the changes you have recently committed to local. Note the "\" is due to the shell.

```bash
git reset --soft HEAD\^
```


To check the size of you git repo 

```bash
$ git bundle create tmp.bundle --all
$ du -sh tmp.bundle
 19M    tmp.bundle
```