## Full container capabilities, Set working directory And Mount Volumes

Version Stack

| Stack  | Version  |
|--------|----------|
| Docker | 20.10.14 |

### Full container capabilities

[full-container-capabilities---privileged](https://docs.docker.com/engine/reference/commandline/run/#full-container-capabilities---privileged)

```bash
❯ docker run -t -i --rm ubuntu bash
root@ae4994d93a27:/# mount -t tmpfs none /mnt
mount: /mnt: permission denied.
root@ae4994d93a27:/# exit
exit


❯ docker run -t -i --privileged ubuntu bash
root@6ad992ced205:/# mount -t tmpfs none /mnt
root@6ad992ced205:/# df -h | egrep "Filesystem|tmpfs"
Filesystem      Size  Used Avail Use% Mounted on
tmpfs            64M     0   64M   0% /dev
```


### Set working directory

[set-working-directory--w](https://docs.docker.com/engine/reference/commandline/run/#set-working-directory--w)

```bash
❯ docker  run -w /path/to/dir/ -i -t  ubuntu pwd   
/path/to/dir
```


### Mount Volumes

[mount-volume](https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v---read-only)

```bash
## Terminal session 1
❯ ls
ReadMe.md

# Note that the container also see the file ReadMe.md as we have mounted the same using pwd
❯ docker  run  -v `pwd`:`pwd` -w `pwd` -i -t  ubuntu ls
ReadMe.md

## Terminal session 2
# Let's create another directory and see
❯ mkdir -p /tmp/test
❯ cd /tmp/test
❯ touch test.txt


# Terminal session 1
❯ docker run --rm -v /tmp/test:/foo -w /foo -i -t ubuntu bash
# Let's see if the container can see the file
root@0e19af311731:/foo# ls
test.txt
root@0e19af311731:/foo# exit
exit

## The same can also be achieved using mount flag
❯ docker run -t -i -w /foo --mount type=bind,src=/tmp/test,dst=/foo busybox sh
/foo # ls
test.txt
/foo # touch newfile.txt
/foo # exit
❯ ls /tmp/test        
newfile.txt test.txt
```