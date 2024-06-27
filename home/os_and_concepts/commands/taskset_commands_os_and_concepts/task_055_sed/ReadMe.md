# sed

- [sed](#sed)
  - [NAME](#name)
  - [EXAMPLE on Linux](#example-on-linux)
  - [EXAMPLE on macOS](#example-on-macos)

<br>

## NAME

sed - stream editor for filtering and transforming text

<br>

## EXAMPLE on Linux

```bash
$ [root@sso-service-324448229-1-348775404 app]# echo | openssl s_client -connect qa.iam.platform.prod.company.com:443 2>&1 | sed -n  '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
-----BEGIN CERTIFICATE-----
....
-----END CERTIFICATE-----
[root@sso-service-324448229-1-348775404 app]#
```

To replace ‘branches’ with ‘    ’ with 4 spaces

```bash
-bash-3.2$ xargs svn info <$HOME/.BUILD_SCRIPTS_AREA/modules.full |grep "^URL" | awk '{print $NF}'
http://dxbmiap19pv:81/svn/xxxxxx/branches/DEV/YY-5.4.0.0
-bash-3.2$ xargs svn info <$HOME/.BUILD_SCRIPTS_AREA/modules.full |grep "^URL"|awk '{print $NF}'|sed 's/branches/  /g'
http://dxbmiap19pv:81/svn/xxxxxx/  /DEV/YY-5.4.0.0
```

<br>

## EXAMPLE on macOS

To recursively searches for all files in the current directory and its subdirectories, then uses `sed` to replace occurrences of `oldstring` with `newstring` in-place within each file.

```bash
find . -type f -exec sed -i '' 's/oldstring/newstring/g' {} +
```
