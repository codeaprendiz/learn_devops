# shasum

## Examples

To calculate the sha1sum of a file:

```bash
shasum /tmp/yq
```

Typically used to verify the integrity of a file.

```bash
curl -Lo /tmp/yq https://github.com/reponame/yq/releases/download/v4.44.3/yq_linux_amd64
EXPECTED_CHECKSUM="a3d28b3x5xxxxxxxxxxxxx0d07" # You can calculate the checksum using shasum /tmp/yq and then copy the output here for subsequent runs
echo "$EXPECTED_CHECKSUM  /tmp/yq" | sha256sum -c || exit 1
```
