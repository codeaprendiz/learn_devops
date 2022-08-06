## sed
 

### NAME

sed - stream editor for filtering and transforming text

### SYNOPSIS

> sed [OPTION]... {script-only-if-no-other-script} [input-file]...

### DESCRIPTION

Sed  is a stream editor.  A stream editor is used to perform basic text transformations on an input stream (a file or input from a pipeline).  While in some ways similar to an editor which permits scripted edits (such as ed), sed works by making only one pass over the input(s), and is consequently more efficient.  But it is sed's ability to filter text in a pipeline which particularly distinguishes it from other types of editors.

### OPTIONS

* -n, --quiet, --silent
  * suppress automatic printing of pattern space
* -e script, --expression=script
  * add the script to the commands to be executed


### EXAMPLE

```bash
$ [root@sso-service-324448229-1-348775404 app]# echo | openssl s_client -connect qa.iam.platform.prod.company.com:443 2>&1 | sed -n  '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
-----BEGIN CERTIFICATE-----
MIIIIjCCBgqgAwIBAgITQwABQ1+wYMQQh31Y0AAAAAFDXzANBgkqhkiG9w0BAQsF
ADB0MRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIV2FsLdNorWKR4Rmw9aYU3lF2E6HhGhIElg5FufBlZB7zA6hT0WqCkqh3TVaiOXeksGf1r
CF8fUdFhXno3uxU84miFLfvwLEFCIBwphv6WrlSjyRSFgvZfBoSPpZHTBEyMuS+h
UHCe1yohx1F1ERwag04DUH2wFKJGTef5pwokXRJBEIn6lwbTuAHk4AsKxYqa/iBa
HVO6kWJSb+J7loXle/W3GsDh5xs/64bGYoTOqyFwYtZTTCEZ5GPhGvTT256xjfPy
Ay9VfEiyqJOh0xWsoP2duhPped2nrS8Muxdbjy95lDkDVsYgpFk3kX3qQtv4RVRO
RCKjnb6VF2+h+p21EQzmmf0UpGavlQ==
-----END CERTIFICATE-----
[root@sso-service-324448229-1-348775404 app]#
```

Using sed to replace ‘/’ with ‘-’ globally

```bash
-bash-3.2$ echo hello/world
hello/world
-bash-3.2$ echo hello/world  | sed 's/\//-/g'
hello-world
-bash-3.2$
```

To replace ‘branches’ with ‘    ’ with 4 spaces

```bash
-bash-3.2$ xargs svn info <$HOME/.BUILD_SCRIPTS_AREA/modules.full |grep "^URL" | awk '{print $NF}'
http://dxbmiap19pv:81/svn/ngcsay/branches/DEV/AY-5.4.0.0
-bash-3.2$ xargs svn info <$HOME/.BUILD_SCRIPTS_AREA/modules.full |grep "^URL"|awk '{print $NF}'|sed 's/branches/  /g'
http://dxbmiap19pv:81/svn/ngcsay/  /DEV/AY-5.4.0.0
```