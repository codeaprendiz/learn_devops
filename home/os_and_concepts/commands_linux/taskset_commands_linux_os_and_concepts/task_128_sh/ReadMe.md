# sh

## Examples

### -s  | read from stdin

Here's a brief explanation of the command:

1. `| sh -s -- -b /usr/local/bin v0.18.3`: Pipes the script's content to `sh` for execution.
   - `-s`: Tells `sh` to read the script from stdin.
   - `--`: Indicates the end of options for `sh` and starts arguments for the script.
   - `-b /usr/local/bin`: Argument for the script specifying where to install the binaries.
   - `v0.18.3`: Specifies the version to install.

```bash
# https://aquasecurity.github.io/trivy/v0.18.3/installation/
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3
```
