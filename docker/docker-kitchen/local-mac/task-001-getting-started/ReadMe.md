[Getting Started](https://docs.docker.com/get-started/)

- Run

```bash
$ docker run -d -p 80:80 docker/getting-started
Unable to find image 'docker/getting-started:latest' locally
latest: Pulling from docker/getting-started
df9b9388f04a: Pull complete 
5867cba5fcbd: Pull complete 
4b639e65cb3b: Pull complete 
061ed9e2b976: Pull complete 
bc19f3e8eeb1: Pull complete 
4071be97c256: Pull complete 
79b586f1a54b: Pull complete 
0c9732f525d6: Pull complete 
Digest: sha256:b558be874169471bd4e65bd6eac8c303b271a7ee8553ba47481b73b2bf597aae
Status: Downloaded newer image for docker/getting-started:latest
4fb7848e41a1f4135e029b438f3e0fe424dbe5d458618b625128c8f72013b1ff

$ docker ps                                    
CONTAINER ID   IMAGE                    COMMAND                  CREATED         STATUS         PORTS                NAMES
4fb7848e41a1   docker/getting-started   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:80->80/tcp   quirky_rosalind

```