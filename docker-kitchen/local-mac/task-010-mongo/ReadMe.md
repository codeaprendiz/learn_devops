
[Referenced link](https://www.code4it.dev/blog/run-mongodb-on-docker)

```bash
$ docker run -d  --name mongo-on-docker  -p 27888:27017 -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret mongo
0f4060b2b64f35642a4988c5dde5eb9461f87de36ac297b10142a2701269ba8f
```

- While connecting using the client, the following details are required
```bash
Server:   localhost
Port:     27888
Username: mongoadmin
Password: secret
``` 

- You can use the following to connect to the shell

```bash
$ mongo --username mongoadmin --password secret --port 27888 --host  127.0.0.1
MongoDB shell version v4.4.3
connecting to: mongodb://127.0.0.1:27888/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("7e4758b6-a551-4f20-bece-584fb042996d") }
MongoDB server version: 4.4.4
---
The server generated these startup warnings when booting: 
        2021-05-30T07:21:09.404+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
---
---
        Enable MongoDB's free cloud-based monitoring service, which will then receive and display
        metrics about your deployment (disk utilization, CPU, operation statistics, etc).

        The monitoring data will be available on a MongoDB website with a unique URL accessible to you
        and anyone you share the URL with. MongoDB may use this information to make product
        improvements and to suggest MongoDB products and deployment options to you.

        To enable free monitoring, run the following command: db.enableFreeMonitoring()
        To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
---
>
```
