# OCI Commands


# oci


Command / Options |  Use Case        |     Example      |  
| ------------- |-------------| -------------| 
| [create](https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.9.1/oci_cli_docs/cmdref/os/bucket/create.html) | Create OCI bucket | `╰─ oci os bucket create --compartment-id <compartment-id> --name sandbox-v1-bucket`
| [list](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.16.0/oci_cli_docs/cmdref/os/bucket/list.html)| List OCI buckets | `╰─ oci os bucket list --compartment-id <compartment-id> | jq '.data[] | {name} '` |