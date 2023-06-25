- [Sample APP](https://docs.docker.com/get-started/02_our_app/)


- Build 

```bash
$ docker build -t getting-started .
```

- Start the app container

```bash
$ docker run -dp 3000:3000 getting-started
ec25cae23f5fa1d421c7a750b70d1ba914286eee2e46f464db8fbb8d1f7314ba
```

- Then visit the app on localhost:3000

![](.images/2022-07-24-11-00-29.png)