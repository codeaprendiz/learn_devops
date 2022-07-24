- [Updating App](https://docs.docker.com/get-started/03_updating_app/)

- Build the app again

```bash
$ docker build -t getting-started .
```

- Run the container again

```bash
$ docker run -dp 3000:3000 getting-started
621a5b57dca2c43892d2b63810fe3d1834b709eff19b42a5c4a31767910fefe2
docker: Error response from daemon: driver failed programming external connectivity on endpoint admiring_chatelet (2ff9d0818c690b6ff3b86d8857d5110a595e696e5c2f4032cbf78b26c1904de1): Bind for 0.0.0.0:3000 failed: port is already allocated

$ docker rm -f 621a5b57dca2c43892d2b63810fe3d1834b709eff19b42a5c4a31767910fefe2               
621a5b57dca2c43892d2b63810fe3d1834b709eff19b42a5c4a31767910fefe2

$ docker run -dp 3000:3000 getting-started                                     
460c1d91eb69a385c27e03baee7d3c7687abf6f0c67e788c39acd9fd44ec7983
```

- Images

![](.images/2022-07-24-13-49-04.png)