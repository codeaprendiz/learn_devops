# ReadMe-static

## Mac

[hub.docker.com » starting postgres locally](https://hub.docker.com/_/postgres)

Start the PostgreSQL database locally with the following command:

```bash
docker run --rm --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine
```
