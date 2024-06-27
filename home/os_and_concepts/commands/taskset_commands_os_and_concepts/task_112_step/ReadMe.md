# Step

[smallstep.com](https://smallstep.com/cli)

[github.com » smallstep/cli](https://github.com/smallstep/cli)

<br>

## Examples

Generating a [trust anchor certificate](https://linkerd.io/2.14/tasks/generate-certificates/#trust-anchor-certificate) in linkerd

| Command/Option               | Description                                            |
|------------------------------|--------------------------------------------------------|
| `step certificate create`    | Command to create a certificate and private key.       |
| `root.linkerd.cluster.local` | Specifies the name of the certificate being created.   |
| `ca.crt`                     | The output filename for the root certificate.          |
| `ca.key`                     | The output filename for the certificate's private key. |
| `--profile root-ca`          | Sets the certificate profile to root CA.               |
| `--no-password`              | Generates the key without a passphrase for simplicity. |
| `--insecure`                 | Skips encryption of the key for easier automation.     |

```bash
step certificate create root.linkerd.cluster.local ca.crt ca.key \
--profile root-ca --no-password --insecure
```

Generating [Issuer certificate and key](https://linkerd.io/2.14/tasks/generate-certificates/#issuer-certificate-and-key)

| Command/Option                   | Description                                                         |
|----------------------------------|---------------------------------------------------------------------|
| `step certificate create`        | Command to create a certificate and private key.                    |
| `identity.linkerd.cluster.local` | Specifies the name for the intermediate certificate.                |
| `issuer.crt`                     | The output filename for the intermediate certificate.               |
| `issuer.key`                     | The output filename for the intermediate certificate's private key. |
| `--profile intermediate-ca`      | Sets the certificate profile to intermediate CA.                    |
| `--not-after 8760h`              | Sets the certificate's validity period to 8760 hours (1 year).      |
| `--no-password`                  | Generates the key without a passphrase for simplicity.              |
| `--insecure`                     | Skips encryption of the key for easier automation.                  |
| `--ca ca.crt`                    | Specifies the root certificate to use.                              |
| `--ca-key ca.key`                | Specifies the root certificate's private key to use.                |

```bash
step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
--profile intermediate-ca --not-after 8760h --no-password --insecure \
--ca ca.crt --ca-key ca.key
```
