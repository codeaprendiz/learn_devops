[Setting up visual studio for python](https://code.visualstudio.com/docs/python/python-tutorial)


- Ensure that you have installed [Visual Studio Code (at the time of commit - Version 1.62)](https://visualstudio.microsoft.com/downloads/)

- Install the following extensions

  - Python

![](.images/python-extension.png)


  - Visual Studio Intellicode for AutoComplete 
![](.images/visual-studio-intellicode.png)

  - Pylance

![](.images/pylance.png)


- Create a directory workspace

```bash
$ mkdir -p ~/workspace/proj
$ cd ~/workspace

### Create a virtual env
$ python3 -m venv venv
$ ls
proj venv
```


- Now you can open visual studio from terminal 

```bash
$ cd ~/workspace
$ code .
```