# [openssl](https://www.openssl.org/docs/manpages.html)

- [openssl](#openssl)
  - [NAME](#name)
    - [DESCRIPTION](#description)
    - [COMMANDS](#commands)
      - [enc](#enc)
        - [EXAMPLES for enc](#examples-for-enc)
      - [pkcs12](#pkcs12)
        - [Examples for pkcs12](#examples-for-pkcs12)
      - [rsa](#rsa)
        - [EXAMPLES for rsa](#examples-for-rsa)
      - [s\_client](#s_client)
        - [EXAMPLES for s\_client](#examples-for-s_client)
      - [x509](#x509)
        - [EXAMPLES for x509](#examples-for-x509)
      - [req](#req)
        - [EXAMPLES for req](#examples-for-req)

## NAME

openssl - OpenSSL command line tool

### DESCRIPTION

OpenSSL is a cryptography toolkit implementing the Secure Sockets Layer (SSL v2/v3) and Transport Layer Security (TLS v1) network protocols and related cryptography standards required by them.

The openssl program is a command line tool for using the various cryptography functions of OpenSSL's crypto library from the shell.  It can be used for

- Creation of RSA, DH and DSA key parameters
- Creation of X.509 certificates, CSRs and CRLs
- Calculation of Message Digests
- Encryption and Decryption with Ciphers
- SSL/TLS Client and Server Tests
- Handling of S/MIME signed or encrypted mail

### COMMANDS

#### enc

NAME

openssl-enc, enc - symmetric cipher routines

DESCRIPTION

The symmetric cipher commands allow data to be encrypted or decrypted using various block and stream ciphers using keys based on passwords or explicitly provided. Base64 encoding or decoding can also be performed either by itself or in addition to the encryption or decryption.
  
##### EXAMPLES for enc

Just base64 encode a binary file:

```bash
#   -in filename : The input filename, standard input by default.
#   -out filename : The output filename, standard output by default.
$ openssl base64 -in file.bin -out file.b64
.
```

Decode the same file

```bash
# -d : Decrypt the input data.
$ openssl base64 -d -in file.b64 -out file.bin
.
```

#### pkcs12

NAME

pkcs12 - PKCS#12 file utility

DESCRIPTION

The pkcs12 command allows PKCS#12 files (sometimes referred to as PFX files) to be created and parsed. PKCS#12 files are used by several programs including Netscape, MSIE and MS Outlook.

##### Examples for pkcs12

```bash
# -in filename : This specifies filename of the PKCS#12 file to be parsed. Standard input is used by default.
# -out filename : The filename to write certificates and private keys to, standard output by default.  They are all written in PEM format.
$ openssl pkcs12 -in asda-gr-int.company.com.pfx -out asda-gr-text.int.company.com.pem
.
```

#### rsa

NAME

openssl-rsa, rsa - RSA key processing tool

DESCRIPTION

The rsa command processes RSA keys. They can be converted between various forms and their components printed out. Note this command uses the traditional SSLeay compatible format for private key encryption: newer applications should use the more secure PKCS#8 format using the pkcs8 utility.
  
##### EXAMPLES for rsa

Consider a certificate “certificate.pem” containing encrypted private key. You can decrypt it using the following command

```bash
# -in filename : This specifies the input filename to read a key from or standard input if this option is not specified. If the key is encrypted a pass phrase will be prompted for.
# -out filename : This specifies the output filename to write a key to or standard output if this option is not specified. If any encryption options are set then a pass phrase will be prompted for. The output filename should not be the same as the input filename.
$ openssl rsa -in certificate.pem -out decryptedKeyFile.crt
.
```

#### s_client

NAME

s_client - SSL/TLS client program

DESCRIPTION

The s_client command implements a generic SSL/TLS client which connects to a remote host using SSL/TLS. It is a very useful diagnostic tool for SSL servers.

##### EXAMPLES for s_client

To download the certificate directly we use the following command

```bash
$ echo | openssl s_client -connect qa.iam.platform.prod.company.com:443 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/iam_cert.pem;
.
```

To download the self-signed certificate of nginx server with server name configured as  `repo.maven.apache.org`

- 10.0.1.4 is your nginx IP

```nginx
...
  listen 443 ssl;

  server_name 
    repo.maven.apache.org
...
```

```bash
# You run this from a client, say 10.0.1.5 which is ubuntu machine and has openssl installed. You want to do this so your https connection from client (ubuntu) using curl to nginx via curl does not complain that it does not trust the nginx's servers self signed certs.
openssl s_client -showcerts -connect 10.0.1.4:443 < /dev/null | sed -ne "/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p" > /usr/local/share/ca-certificates/server.crt
```

This might be followed by following

```bash
# Install ca-certificates if not installed: Make sure ca-certificates is installed on ubuntu
apt-get update && apt-get install -y ca-certificates

# Update the CA Certificates: Update the certificate authority (CA) store to include your new self-signed certificate:
update-ca-certificates
# look for following line inoutput
# 1 added, 0 removed; done.

# Now you can run the following from your client to test the https connection
curl -v -H "Host: repo.maven.apache.org" --resolve "repo.maven.apache.org:443:10.0.1.4" https://repo.maven.apache.org:443
# Look for in output
# *  SSL certificate verify ok.

# Alternatively, if you don't want to udpate the OS CA certificates, you can also specify the file as an arguemnt to the client curl using the --cacert option
# When you don't want to run          $ update-ca-certificates
curl -v -H "Host: repo.maven.apache.org" --cacert /usr/local/share/ca-certificates/server.crt --resolve "repo.maven.apache.org:443:10.0.1.4" https://repo.maven.apache.org:443
```

#### x509

NAME

> x509 - Certificate display and signing utility

DESCRIPTION

The x509 command is a multi purpose certificate utility. It can be used to display certificate information, convert certificates to various forms, sign certificate requests like a "mini CA" or edit certificate trust settings.
  
##### EXAMPLES for x509

To get the certificate expiry dates

```bash
# -noout : this option prevents output of the encoded version of the request.
# -dates : prints out the start and expiry dates of a certificate.
# -in filename : This specifies the input filename to read a certificate from or standard input if this option is not specified.
$ openssl s_client -connect 10.57.148.133:443 2>/dev/null | openssl x509 -noout -dates
notBefore=Nov  8 23:47:37 2017 GMT
notAfter=Nov  9 23:47:37 2019 GMT
```

To get detailed information.

> Note: This will also validate if the certificate is tampered with or not.

```bash
# -text : prints out the certificate in text form. Full details are output including the public key, signature algorithms, issuer and subject names, serial number any extensions present and any trust settings. 
openssl x509 -in georgebackend.oms.prod.company.com.pem -text -noout                                                                                     . 
```

Useful output

- To check if the certificate is CA cert `CA: TRUE`
- To check for domains for which the certificate is valid
- To check Issuer and Validity

```bash
...
        Issuer: C = AE, ST = India, L = India, O = NA, OU = IT, CN = nginx, emailAddress = it@sre.net
        Validity
            Not Before: Sep 18 07:44:56 2022 GMT
            Not After : Sep 16 07:44:56 2032 GMT
...
...
                CA:TRUE
            X509v3 Subject Alternative Name: 
                DNS:nginx, DNS:nexus, DNS:repo.maven.apache.org, DNS:repo1.maven.org, DNS:plugins.gradle.org
```

#### req

RSA Key Management

##### EXAMPLES for req

To create RootCA, server certificate and client certificate

- To create RootCA

```bash
openssl \
    req \
    -new \
    -newkey rsa:4096 \
    -days 1024 \
    -nodes \
    -x509 \
    -subj "/C=US/ST=CA/O=MyOrg/CN=myOrgCA" \
    -keyout confs/rootCA.key \
    -out confs/rootCA.crt
```

| Option  | Value                                    | Description                                                            |
|---------|------------------------------------------|------------------------------------------------------------------------|
| req     |                                          | X.509 Certificate Signing Request (CSR) management command.            |
| -new    |                                          | Specifies that a new CSR is being requested.                           |
| -newkey | rsa:4096                                 | Creates a new RSA private key of 4096 bits.                            |
| -days   | 1024                                     | The certificate will be valid for 1024 days.                           |
| -nodes  |                                          | No DES; Specifies that the private key should not be encrypted.        |
| -x509   |                                          | Produces a self-signed certificate instead of a CSR.                   |
| -subj   | "/C=US/ST=CA<br>/O=MyOrg/<br>CN=myOrgCA" | Sets the subject field for the certificate using the specified format. |
| -keyout | confs/rootCA.key                         | The file to write the newly created private key to.                    |
| -out    | confs/rootCA.crt                         | The file to write the newly created certificate to.                    |

- To create server certificate

```bash
openssl \
    req \
    -new \
    -newkey rsa:2048 \
    -days 372 \
    -nodes \
    -x509 \
    -subj "/C=US/ST=CA/O=MyOrg/CN=myOrgCA" \
    -addext "subjectAltName=DNS:example.com,DNS:example.net,DNS:otel_collector,DNS:localhost" \
    -CA confs/rootCA.crt \
    -CAkey confs/rootCA.key  \
    -keyout confs/server.key \
    -out confs/server.crt
```

| Option  | Value                                                                                             | Description                                                              |
|---------|---------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| req     |                                                                                                   | X.509 Certificate Signing Request (CSR) management command.              |
| -new    |                                                                                                   | Specifies that a new CSR is being requested.                             |
| -newkey | rsa:2048                                                                                          | Creates a new RSA private key of 2048 bits.                              |
| -days   | 372                                                                                               | The certificate will be valid for 372 days.                              |
| -nodes  |                                                                                                   | No DES; Specifies that the private key should not be encrypted.          |
| -x509   |                                                                                                   | Produces a self-signed certificate instead of a CSR.                     |
| -subj   | "/C=US/ST<br>=CA/O=MyOrg<br>/CN=myOrgCA"                                                          | Sets the subject field for the certificate using the specified format.   |
| -addext | "subjectAltName<br>=DNS:example.com,<br>DNS:example.net,DNS<br>:otel_collector,<br>DNS:localhost" | Specifies additional extensions to be added to the certificate.          |
| -CA     | confs/rootCA.crt                                                                                  | Specifies the CA certificate to be used for signing the new certificate. |
| -CAkey  | confs/rootCA.key                                                                                  | Specifies the private key of the CA used for signing.                    |
| -keyout | confs/server.key                                                                                  | The file to write the newly created private key to.                      |
| -out    | confs/server.crt                                                                                  | The file to write the newly created certificate to.                      |

- To create client certs

```bash
openssl \
    req \
    -new \
    -newkey rsa:2048 \
    -days 372 \
    -nodes \
    -x509 \
    -subj "/C=US/ST=CA/O=MyOrg/CN=myOrgCA" \
    -addext "subjectAltName=DNS:example.com,DNS:example.net,DNS:otel_collector,DNS:localhost" \
    -CA confs/rootCA.crt \
    -CAkey confs/rootCA.key  \
    -keyout confs/client.key \
    -out confs/client.crt
```

| Option  | Value                                                                                         | Description                                                              |
|---------|-----------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| req     |                                                                                               | X.509 Certificate Signing Request (CSR) management command.              |
| -new    |                                                                                               | Specifies that a new CSR is being requested.                             |
| -newkey | rsa:2048                                                                                      | Creates a new RSA private key of 2048 bits.                              |
| -days   | 372                                                                                           | The certificate will be valid for 372 days.                              |
| -nodes  |                                                                                               | Specifies that the private key should not be encrypted.                  |
| -x509   |                                                                                               | Produces a self-signed certificate instead of a CSR.                     |
| -subj   | "/C=US/ST=CA<br>/O=MyOrg/CN=<br>myOrgCA"                                                      | Sets the subject field for the certificate using the specified format.   |
| -addext | "subjectAltName=DNS<br>:example.com,DNS:<br>example.net,DNS:otel_collector,<br>DNS:localhost" | Specifies additional extensions to be added to the certificate.          |
| -CA     | confs/rootCA.crt                                                                              | Specifies the CA certificate to be used for signing the new certificate. |
| -CAkey  | confs/rootCA.key                                                                              | Specifies the private key of the CA used for signing.                    |
| -keyout | confs/server.key                                                                              | The file to write the newly created private key to.                      |
| -out    | confs/server.crt                                                                              | The file to write the newly created certificate to.                      |

To create self-signed certificates for nginx

```bash
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -extensions v3_ca \
    -subj '/C=AE/ST=India/L=India/O=NA/OU=IT/CN=nginx/emailAddress=it@sre.net' \
    -addext 'subjectAltName=DNS:nginx,DNS:nexus,DNS:repo.maven.apache.org,DNS:repo1.maven.org,DNS:plugins.gradle.org,DNS:registry.npmjs.org,DNS:docker.io,DNS:registry-1.docker.io,DNS:gcr.io,DNS:ghcr.io,DNS:quay.io,DNS:registry.k8s.io' \
    -keyout /etc/ssl/certs/nginx.key -out /etc/ssl/certs/nginx.crt
```

| **Command/Option**                                                           | **Description**                                                                                                                                                                                                                          |
|------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `openssl req`                                                                | Starts the process of generating a new self-signed certificate using `openssl`.                                                                                                                                                          |
| `-new`                                                                       | Generates a **new certificate**. When used with the `-x509` option, it creates a self-signed certificate rather than generating a CSR.                                                                                                   |
| `-newkey rsa:4096`                                                           | Generates a **new private key** and a **new certificate** at the same time, using RSA with a key size of 4096 bits.                                                                                                                      |
| `-days 3650`                                                                 | Sets the certificate's validity to 3650 days (10 years).                                                                                                                                                                                 |
| `-nodes`                                                                     | Indicates that the private key should not be encrypted, allowing it to be used without needing a password.                                                                                                                               |
| `-x509`                                                                      | Specifies that this is a **self-signed certificate** instead of generating a certificate signing request (CSR).                                                                                                                          |
| `-extensions v3_ca`                                                          | Adds the `v3_ca` extension, enabling the certificate to function as a certificate authority (CA).                                                                                                                                        |
| `-subj '/C=AE/ST=India/L=India/O=NA/OU=IT/CN=nginx/emailAddress=it@sre.net'` | Defines the subject (certificate details) with fields like country (`C=AE`), state (`ST=India`), locality (`L=India`), organization (`O=NA`), organizational unit (`OU=IT`), common name (`CN=nginx`), and email address (`it@sre.net`). |
| `-addext 'subjectAltName=DNS:nginx,...'`                                     | Adds the Subject Alternative Name (SAN) extension, allowing the certificate to be valid for multiple domain names like `nginx`, `nexus`, `repo.maven.apache.org`, `docker.io`, etc.                                                      |
| `-keyout /etc/ssl/certs/nginx.key`                                           | Specifies the location where the private key will be saved (`/etc/ssl/certs/nginx.key`).                                                                                                                                                 |
| `-out /etc/ssl/certs/nginx.crt`                                              | Specifies the location where the self-signed certificate will be saved (`/etc/ssl/certs/nginx.crt`).                                                                                                                                     |