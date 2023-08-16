# Set up OCI Cli

[docs.oracle.com » Developer Resources » Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#two)
[docs.oracle.com » Developer Resources » Working with CLI » Configuring the CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliconfigure.htm)

- Login to oracle cloud

- Go to your profile and download the API Keys

- Download private and public key pairs

- Create the OCI directory

```bash
╰─ mkdir -p ~/.oci/
╰─ touch ~/.oci/config
```

- Move the downloaded keys to the OCI directory

```bash
╰─ ls
config          oci-private.pem oci-public.pem
```


- Set up your config file and repiar the config file permissions if needed

```bash
╰─ oci setup repair-file-permissions --file ~/.oci/oci-private.pem 
```

```bash
╰─ cat config
[DEFAULT]
user=<username>
fingerprint=<key-fingerprint>
tenancy=<tenancy>
region=<region>
key_file=~/.oci/oci-private.pem
```

- If you have created any buckets, then you can list those buckets using the following command

```bash
╰─ oci os bucket list --compartment-id <compartment-id> | jq '.data[] | {name} '
## Alternatively you can pass the config file as argument as well
╰─ oci os bucket list --compartment-id <compartment-id> --config-file </path/to/file> | jq '.data[] | {name} '
.
```
