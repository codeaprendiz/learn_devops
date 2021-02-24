
### Nodejs Mongo Application on kubernetes

- Build Project

```bash
$ docker build -t codeaprendiz/node-kubernetes .  
```

- Docker Login

```bash
$ docker login -u codeaprendiz                  
Password: 
Login Succeeded
```

- Push the image

```bash
$ docker push codeaprendiz/node-kubernetes                                    
```


- Create secets

 - username
```bash
$ echo "admin" | base64
YWRtaW4K
```

 - password
 
```bash
$ echo "password" | base64
cGFzc3dvcmQK
```