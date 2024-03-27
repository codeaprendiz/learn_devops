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

```bash
# -connect host:port » This specifies the host and optional port to connect to. If not specified then an attempt is made to connect to the local host on port 4433.
$ openssl s_client -connect www.company.com:443
CONNECTED(00000003)
depth=3 /C=SE/O=AddTrust AB/OU=AddTrust External TTP Network/CN=AddTrust External CA Root
verify error:num=19:self signed certificate in certificate chain
verify return:0
---
Certificate chain
 0 s:/OU=Domain Control Validated/OU=PositiveSSL/CN=www.company.com
   i:/C=GB/ST=Greater Manchester/L=Salford/O=COMODO CA Limited/CN=COMODO RSA Domain Validation Secure Server CA
 1 s:/C=GB/ST=Greater Manchester/L=Salford/O=COMODO CA Limited/CN=COMODO RSA Domain Validation Secure Server CA
   i:/C=GB/ST=Greater Manchester/L=Salford/O=COMODO CA Limited/CN=COMODO RSA Certification Authority
 2 s:/C=GB/ST=Greater Manchester/L=Salford/O=COMODO CA Limited/CN=COMODO RSA Certification Authority
   i:/C=SE/O=AddTrust AB/OU=AddTrust External TTP Network/CN=AddTrust External CA Root
 3 s:/C=SE/O=AddTrust AB/OU=AddTrust External TTP Network/CN=AddTrust External CA Root
   i:/C=SE/O=AddTrust AB/OU=AddTrust External TTP Network/CN=AddTrust External CA Root
---
Server certificate
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
subject=/OU=Domain Control Validated/OU=PositiveSSL/CN=www.company.com
issuer=/C=GB/ST=Greater Manchester/L=Salford/O=COMODO CA Limited/CN=COMODO RSA Domain Validation Secure Server CA
---
No client certificate CA names sent
---
SSL handshake has read 6361 bytes and written 456 bytes
---
New, TLSv1/SSLv3, Cipher is DHE-RSA-AES128-SHA
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
SSL-Session:
    Protocol  : TLSv1
    Cipher    : DHE-RSA-AES128-SHA
    Session-ID: E9C40EAFA4BB7A521E940355E619401BA22DBB7AD915C4A23717335AC41974C4
    Session-ID-ctx: 
    Master-Key: 72044D05FF62C4E075A47DB35FA6C7F3AF77022368A73C82964ACF2BFCA8A857259F134453F4B4FD45D6421B35465796
    Key-Arg   : None
    Start Time: 1521986055
    Timeout   : 300 (sec)
    Verify return code: 0 (ok)
---
HEAD / HTTP/1.0
Host: www.company.com
HTTP/1.1 400 Bad Request
Date: Sun, 25 Mar 2018 13:57:33 GMT
Server: Apache
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
Content-Length: 226
Connection: close
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>400 Bad Request</title>
</head><body>
<h1>Bad Request</h1>
<p>Your browser sent a request that this server could not understand.<br />
</p>
</body></html>
read:errno=0
```

- Once you type the command, you’re going to see a lot of diagnostic output (more about that in a moment) followed by an opportunity to type whatever you want. Because we’re talking to an HTTP server, the most sensible thing to do is to submit an HTTP request. In the following example, I use a HEAD request because it instructs the server not to send the response body:
- Now we know that the TLS communication layer is working: we got through to the HTTP server, submitted a request, and received a response back. Let’s go back to the diagnostic output. The first couple of lines will show the information about the server certificate:
- On my system (and possibly on yours), s_client doesn’t pick up the default trusted certificates; it complains that there is a self-signed certificate in the certificate chain. In most cases, you won’t care about certificate validation;
- The next section in the output lists all the certificates presented by the server in the order in which they were delivered:
- For each certificate, the first line shows the subject and the second line shows the issuer information.
- This part is very useful when you need to see exactly what certificates are sent; browser certificate viewers typically display reconstructed certificate chains that can be almost completely different from the presented ones. To determine if the chain is nominally correct, you might wish to verify that the subjects and issuers match. You start with the leaf (web server) certificate at the top, and then you go down the list, matching the issuer of the current certificate to the subject of the next. The last issuer you see can point to some root certificate that is not in the chain, or—if the self-signed root is included—it can point to itself.
- The next item in the output is the server certificate;
- The next is a lot of information about the TLS connection, most of which is self-explanatory:
- The most important information here is the protocol version (TLS 1.1) and cipher suite used (DHE-RSA-AES128-SHA). You can also determine that the server has issued to you a session ID and a TLS session ticket (a way of resuming sessions without having the server maintain state) and that secure renegotiation is supported. Once you understand what all of this output contains, you will rarely look at it.

USEFUL IMPLEMENTATION

To download the certificate directly we use the following command

```bash
$ echo | openssl s_client -connect qa.iam.platform.prod.company.com:443 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/iam_cert.pem;
.
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

To get detailed information

```bash
# -text : prints out the certificate in text form. Full details are output including the public key, signature algorithms, issuer and subject names, serial number any extensions present and any trust settings.
$ openssl x509 -in georgebackend.oms.prod.company.com.pem -text -noout                                                                                     . 
```

#### req

RSA Key Management

##### EXAMPLES for req

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
