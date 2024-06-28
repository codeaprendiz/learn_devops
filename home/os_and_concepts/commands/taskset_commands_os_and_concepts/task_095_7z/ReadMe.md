# 7z

- [7z](https://manpages.ubuntu.com/manpages/focal/en/man1/7z.1.html)

## NAME

7z - A file archiver with high compression ratio format

## EXAMPLES

- To create an encrypted archive with 7z, use the following command:

```bash
$ 7za a -t7z -mhe=on -p'yourpasswordforencryption' encryptedArchive.7z  directoryToArchiveAndEncrypt
.
```

- To uncompress an encrypted archive with 7z, use the following command:

```bash
$ 7za e encryptedArchive.7z  
.
```
