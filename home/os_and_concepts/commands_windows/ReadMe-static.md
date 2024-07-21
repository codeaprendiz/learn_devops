# ReadMe_static.md

- [ReadMe\_static.md](#readme_staticmd)
  - [Installing Nodejs](#installing-nodejs)
  - [Installing WSL](#installing-wsl)

## Installing Nodejs

[Prebuild Binaries](https://nodejs.org/en/download/prebuilt-binaries)

Run the following in cmd `Download` folder

```batch
dir | findstr ".zip
```

```batch
C:\Users\adminuser\Downloads>dir | findstr ".zip"
07/07/2024  02:24 PM        29,463,958 node-v20.15.0-win-x64.zip
```

Unzip the file

```batch
tar -xf node-v20.15.0-win-x64.zip
```

```batch
setx /M PATH "%PATH%;C:\Users\adminuser\Downloads\node-v20.15.0-win-x64"
```

Close and reopen cmd and run the following to verify the installation

```batch
node -v
```

```batch
npm -v
```

## Installing WSL

[How to install Linux on Windows with WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

```batch
wsl --install
```
