# Connecting to the database

- [https://hub.docker.com/_/microsoft-mssql-tools](https://hub.docker.com/_/microsoft-mssql-tools)

- You can start a mssql-tools container to connect to the database

```bash
$ docker run -it mcr.microsoft.com/mssql-tools bash  # You can use kubectl run as well in kubernetes environment : kubectl run mssql-client --image=mcr.microsoft.com/mssql-tools --restart=Always -it -- bash
root@1234567 $ sqlcmd -S <hostname> -U <username> -P <password> # sqlcmd -S 127.0.0.1 -U sa -P MyPassword100
.
```
