## Contents

More details at [Offical Guide](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
- [image](#image)
    - [rm](#rm-id-of-the-image)
- [images](#images)
- [run](#run)
    - [interactive](#interactive)
    - [tty](#tty)



## image
### rm [id-of-the-image]
To remove the image with specific ID
```bash
$ sudo docker images | grep ubuntu
Password:
ubuntu                               latest                     4e5021d210f6        2 weeks ago         64.2MB
 
$ sudo docker image rm 4e5021d210f6
Untagged: ubuntu:latest
Untagged: ubuntu@sha256:bec5a2727be7fff3d308193cfde3491f8fba1a2ba392b7546b43a051853a341d
Deleted: sha256:4e5021d210f65ebe915670c7089120120bc0a303b90208592851708c1b8c04bd
Deleted: sha256:1d9112746e9d86157c23e426ce87cc2d7bced0ba2ec8ddbdfbcc3093e0769472
Deleted: sha256:efcf4a93c18b5d01aa8e10a2e3b7e2b2eef0378336456d8653e2d123d6232c1e
Deleted: sha256:1e1aa31289fdca521c403edd6b37317bf0a349a941c7f19b6d9d311f59347502
Deleted: sha256:c8be1b8f4d60d99c281fc2db75e0f56df42a83ad2f0b091621ce19357e19d853
```

## images
To show all the images present
```bash
$ sudo docker images               
Password:
REPOSITORY                           TAG                        IMAGE ID            CREATED             SIZE
ubuntu                               latest                     4e5021d210f6        2 weeks ago         64.2MB
busybox                              latest                     83aa35aa1c79        3 weeks ago         1.22MB
```

## run
### interactive
>--interactive , -i	
>	
>Keep STDIN open even if not attached 
```bash
$ sudo docker run -i ubuntu:latest bash
pwd
/
exit

$
```
### tty
>--tty , -t	
>	
>Allocate a pseudo-TTY

You have to externally kill the container in this case
```bash
$ sudo docker run -t ubuntu:latest bash
root@b01ba82675f5:/# pwd
ls
exit
^C^C
root@b01ba82675f5:/# exit
```

When you combine -i and -t, you get a proper terminal like experience
```bash
$ sudo docker run -i -t ubuntu:latest bash
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
5bed26d33875: Pull complete
f11b29a9c730: Pull complete
930bda195c84: Pull complete
78bf9a5ad49e: Pull complete
Digest: sha256:bec5a2727be7fff3d308193cfde3491f8fba1a2ba392b7546b43a051853a341d
Status: Downloaded newer image for ubuntu:latest
root@e421090e426a:/#
```






