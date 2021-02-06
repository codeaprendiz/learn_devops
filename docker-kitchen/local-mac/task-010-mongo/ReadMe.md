
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