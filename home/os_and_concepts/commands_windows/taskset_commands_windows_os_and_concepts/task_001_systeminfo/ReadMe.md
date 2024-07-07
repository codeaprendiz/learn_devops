# [systeminfo](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/systeminfo)

## Examples

[Using Command Prompt or PowerShell](https://learn.microsoft.com/en-us/windows/client-management/client-tools/windows-version-search)

```batch
systeminfo | findstr /B /C:"OS Name" /B /C:"OS Version"
```

```batch
C:\Users\adminuser>systeminfo | findstr /B /C:"OS Name" /B /C:"OS Version"
OS Name:                   Microsoft Windows Server 2022 Datacenter Azure Edition
OS Version:                10.0.20348 N/A Build 20348
```
