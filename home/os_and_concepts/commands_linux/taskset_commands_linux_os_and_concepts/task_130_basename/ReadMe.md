# basename

## NAME

basename, dirname – return filename or directory portion of pathname

## Examples

```bash
basename /home/user/file.txt
```

Output

```bash
file.txt
```

For URLs

```bash
curl -L -o /tmp/$(basename https://repo1.maven.org/maven2/org/tomlj/tomlj/1.0.0/tomlj-1.0.0.pom) https://repo1.maven.org/maven2/org/tomlj/tomlj/1.0.0/tomlj-1.0.0.pom
```

```bash
$ ls /tmp/*.pom
/tmp/tomlj-1.0.0.pom
```
