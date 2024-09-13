# Scans

- [Scans](#scans)
  - [Image Scan](#image-scan)
  - [Filesystem scan](#filesystem-scan)
  - [Rootfs scan](#rootfs-scan)

## Image Scan

[Language-specific Packages](https://aquasecurity.github.io/trivy/v0.41/docs/scanner/vulnerability/language/)

[Use container image](https://aquasecurity.github.io/trivy/v0.55/getting-started/installation/)

```bash
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/trivycache:/root/.cache/ \
  aquasec/trivy image alpine:latest --timeout 10m
```

## Filesystem scan

Scan the jar files in using gradle.lockfile

```bash
docker run --rm \
  -v /tmp/trivycache:/root/.cache/ \
  -v $(pwd)/gradle.lockfile:/root/gradle.lockfile \
  aquasec/trivy fs /root/gradle.lockfile
```

## Rootfs scan

Scan the maven cache for vulnerabilities

```bash
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/trivycache:/root/.cache/ \
  -v $HOME/.m2:/root/.m2/ \
  aquasec/trivy rootfs /root/.m2/
```

```bash
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/trivycache:/root/.cache/ \
  -v $HOME/.m2:/root/.m2/ \
  aquasec/trivy rootfs /root/.m2/repository/org/iq80/snappy/snappy/0.4/snappy-0.4.jar
```
