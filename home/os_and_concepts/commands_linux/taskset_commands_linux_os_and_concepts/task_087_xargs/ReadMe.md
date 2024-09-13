# xargs

## NAME

xargs -- construct argument list(s) and execute utility

## EXAMPLES

### -I | Replace string

To echo the arguments passed to xargs

```bash
cat <<EOF                                                           
1
2
3
EOF
```

Output

```bash
1
2
3
```

```bash
cat <<EOF | xargs -I % echo " -- % -- % -- '%' "
1
2
3
EOF
```

Output

```bash
 -- 1 -- 1 -- '1' 
 -- 2 -- 2 -- '2' 
 -- 3 -- 3 -- '3'
```

To download poms to /tmp directory

```bash
cat <<EOF | xargs -I % bash -c 'curl -L -o /tmp/$(basename %) %'
https://repo1.maven.org/maven2/org/tomlj/tomlj/1.0.0/tomlj-1.0.0.pom
EOF
```

```bash
$ ls /tmp/*.pom
/tmp/commons-lang3-3.12.0.pom /tmp/tomlj-1.0.0.pom
```
