# [setx](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/setx)

- [setx](#setx)
  - [Examples](#examples)
    - [Append a directory to the PATH environment variable](#append-a-directory-to-the-path-environment-variable)

## Examples

### Append a directory to the PATH environment variable 

Run the following in cmd to set the PATH environment variable to include `C:\Users\adminuser\Downloads\node-v20.15.0-win-x64`

- `/M` - Set the variable in the system environment.

```batch
setx /M PATH "%PATH%;C:\Users\adminuser\Downloads\node-v20.15.0-win-x64"
```
