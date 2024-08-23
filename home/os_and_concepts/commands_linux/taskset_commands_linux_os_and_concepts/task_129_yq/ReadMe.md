# yq

## Examples

### e - Edit

```bash
cat <<EOF | yq e '.app.environment = "development"' -
version: 1
app:
  name: MyApp
  environment: qa 
EOF
```

Output

```bash
version: 1
app:
  name: MyApp
  environment: development
```

### -i - Inplace

```bash
$ cat file.yaml
version: 1
app:
  name: MyApp
  environment: qa
```

```bash
yq -i e '.app.environment = "development"' file.yaml
```

```bash
$ cat file.yaml
version: 1
app:
  name: MyApp
  environment: development
```
