
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