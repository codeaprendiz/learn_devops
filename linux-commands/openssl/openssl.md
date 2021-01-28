## openssl


### NAME

openssl - OpenSSL command line tool

### SYNOPSIS

> openssl command [ command_opts ] [ command_args ]

> openssl [ list-standard-commands | list-message-digest-commands | list-cipher-commands ]

> openssl no-XXX [ arbitrary options ]


## DESCRIPTION

OpenSSL is a cryptography toolkit implementing the Secure Sockets Layer (SSL v2/v3) and Transport Layer Security (TLS v1) network protocols and related cryptography standards required by them.

The openssl program is a command line tool for using the various cryptography functions of OpenSSL's crypto library from the shell.  It can be used for

- Creation of RSA, DH and DSA key parameters
- Creation of X.509 certificates, CSRs and CRLs
- Calculation of Message Digests
- Encryption and Decryption with Ciphers
- SSL/TLS Client and Server Tests
- Handling of S/MIME signed or encrypted mail



### COMMAND SUMMARY

The openssl program provides a rich variety of commands (command in the SYNOPSIS above), each of which often has a wealth of options and arguments (command_opts and command_args in the SYNOPSIS).

The pseudo-commands list-standard-commands, list-message-digest-commands, and list-cipher-commands output a list (one entry per line) of the names of all standard commands, message digest commands, or cipher commands, respectively, that are available in the present openssl utility.

The pseudo-command no-XXX tests whether a command of the specified name is available.  If no command named XXX exists, it returns 0 (success) and prints no-XXX; otherwise it returns 1 and prints XXX.  In both cases, the output goes to stdout and nothing is printed to stderr. Additional command line arguments are always ignored.  Since for each cipher there is a command of the same name, this provides an easy way for shell scripts to test for the availability of ciphers in the openssl program.  (no-XXX is not able to detect pseudo-commands such as quit, list-...-commands, or no-XXX itself.)


### PASS PHRASE ARGUMENTS

Several commands accept password arguments, typically using -passin and -passout for input and output passwords respectively. These allow the password to be obtained from a variety of sources. Both of these options take a single argument whose format is described below. If no password argument is given and a password is required then the user is prompted to enter one: this will typically be read from the current terminal with echoing turned off.

* pass:password
  * the actual password is password. Since the password is visible to utilities (like 'ps' under Unix) this form should only be used where security is not important.
* env:var   
  * obtain the password from the environment variable var. Since the environment of other processes is visible on certain platforms (e.g. ps under certain Unix OSes) this option should be used with caution.
* file:pathname
  * the first line of pathname is the password. If the same pathname argument is supplied to -passin and -passout arguments then the first line will be used for the input password and the next line for the output password. pathname need not refer to a regular file: it could for example refer to a device or named pipe.
* fd:number 
  * read the password from the file descriptor number. This can be used to send the data via a pipe for example.
* stdin     
  * read the password from standard input.


### EXAMPLE

Consider the following example. Here ‘password’ is encrypted into ‘U2FsdGVkX1817zbt5MrD6zrTygx4dRgXUb6NHUmt6po=’ by using the password as ‘testapp’.

```bash
$ echo password | openssl enc -aes-128-cbc -a -salt -pass pass:testapp                                                          U2FsdGVkX1817zbt5MrD6zrTygx4dRgXUb6NHUmt6po=
```

- Now to decrypt the ‘password’ we use the same password ‘testapp’ again but we have to give it the encrypted word as input i.e. ‘‘U2FsdGVkX1817zbt5MrD6zrTygx4dRgXUb6NHUmt6po=’.
- To get the meaning of -a -d and -salt, refer to the very next snippet ‘openssl enc’.
- You can also refer to https://www.madboa.com/geek/openssl/ as reference article.

```bash
$ echo U2FsdGVkX1817zbt5MrD6zrTygx4dRgXUb6NHUmt6po= | openssl enc -aes-128-cbc -a -d -salt -pass pass:testapp
password
```

### COMMAND

#### enc

###### NAME

openssl-enc, enc - symmetric cipher routines


###### SYNOPSIS

> openssl enc -cipher [-help] [-ciphers] [-in filename] [-out filename] [-pass arg] [-e] [-d] [-a] [-base64] [-A] [-k password] [-kfile filename] [-K key] [-iv IV] [-S salt] [-salt] [-nosalt] [-z] [-md digest] [-p] [-P] [-bufsize number] [-nopad] [-debug] [-none] [-rand file...] [-writerand file] [-engine id]

> openssl [cipher] [...]

###### DESCRIPTION

The symmetric cipher commands allow data to be encrypted or decrypted using various block and stream ciphers using keys based on passwords or explicitly provided. Base64 encoding or decoding can also be performed either by itself or in addition to the encryption or decryption.

###### OPTIONS


* -ciphers
  * List all supported ciphers.
* -in filename
  * The input filename, standard input by default.
* -out filename
  * The output filename, standard output by default.
* -pass arg
  * The password source. For more information about the format of arg see the PASS PHRASE ARGUMENTS section in openssl(1).
* -e
  * Encrypt the input data: this is the default.
* -d
  * Decrypt the input data.
* -a
  * Base64 process the data. This means that if encryption is taking place the data is base64 encoded after encryption. If decryption is set then the input data is base64 decoded before being decrypted.
* -base64
  * Same as -a
* -A
  * If the -a option is set then base64 process the data on one line.
* -nosalt
  * Don't use a salt in the key derivation routines. This option SHOULD NOT be used except for test purposes or compatibility with ancient versions of OpenSSL.
* -salt
  * Use salt (randomly generated or provide with -S option) when encrypting, this is the default.
* -z
  * Compress or decompress clear text using zlib before encryption or after decryption. This option exists only if OpenSSL with compiled with zlib or zlib-dynamic option.
  
###### EXAMPLES

Just base64 encode a binary file:

```bash
$ openssl base64 -in file.bin -out file.b64
```
Decode the same file

```bash
$ openssl base64 -d -in file.b64 -out file.bin
```

#### pkcs12


##### NAME

pkcs12 - PKCS#12 file utility

##### SYNOPSIS

> openssl pkcs12 [-export] [-chain] [-inkey filename] [-certfile filename] [-name name] [-caname name] [-in filename] [-out filename] [-noout] [-nomacver] [-nocerts] [-clcerts][-cacerts] [-nokeys] [-info] [-des] [-des3] [-idea] [-nodes] [-noiter] [-maciter] [-twopass] [-descert] [-certpbe] [-keypbe] [-keyex] [-keysig] [-password arg] [-passin arg][-passout arg] [-rand file(s)]

##### DESCRIPTION

The pkcs12 command allows PKCS#12 files (sometimes referred to as PFX files) to be created and parsed. PKCS#12 files are used by several programs including Netscape, MSIE and MS Outlook.

##### OPTIONS

* -in filename
  * This specifies filename of the PKCS#12 file to be parsed. Standard input is used by default.
* -out filename
  * The filename to write certificates and private keys to, standard output by default.  They are all written in PEM format.

```bash
$ openssl pkcs12 -in asda-gr-int.company.com.pfx -out asda-gr-text.int.company.com.pem
```


#### rsa

##### NAME

openssl-rsa, rsa - RSA key processing tool

##### SYNOPSIS

> openssl rsa [-help] [-inform PEM|NET|DER] [-outform PEM|NET|DER] [-in filename] [-passin arg] [-out filename] [-passout arg] [-aes128] [-aes192] [-aes256] [-aria128] [-aria192] [-aria256] [-camellia128] [-camellia192] [-camellia256] [-des] [-des3] [-idea] [-text] [-noout] [-modulus] [-check] [-pubin] [-pubout] [-RSAPublicKey_in] [-RSAPublicKey_out] [-engine id]

##### DESCRIPTION

The rsa command processes RSA keys. They can be converted between various forms and their components printed out. Note this command uses the traditional SSLeay compatible format for private key encryption: newer applications should use the more secure PKCS#8 format using the pkcs8 utility.
OPTIONS

* -in filename
  * This specifies the input filename to read a key from or standard input if this option is not specified. If the key is encrypted a pass phrase will be prompted for.
* -out filename
  * This specifies the output filename to write a key to or standard output if this option is not specified. If any encryption options are set then a pass phrase will be prompted for. The output filename should not be the same as the input filename.
  
##### EXAMPLES

Consider a certificate “certificate.pem” containing encrypted private key. You can decrypt it using the following command

```bash
$ openssl rsa -in certificate.pem -out decryptedKeyFile.crt
```




#### s_client

##### NAME

s_client - SSL/TLS client program

##### SYNOPSIS

> openssl s_client [-connect host:port] [-verify depth] [-cert filename] [-certform DER|PEM] [-key filename] [-keyform DER|PEM] [-pass arg] [-CApath directory] [-CAfile filename][-attime timestamp] [-check_ss_sig] [-crl_check] [-crl_check_all] [-explicit_policy] [-ignore_critical] [-inhibit_any] [-inhibit_map] [-issuer_checks] [-policy arg] [-policy_check] [-policy_print] [-purpose purpose] [-use_deltas] [-verify_depth num] [-x509_strict] [-reconnect] [-pause] [-showcerts] [-debug] [-msg] [-nbio_test] [-state][-nbio] [-crlf] [-ign_eof] [-quiet] [-ssl2] [-ssl3] [-tls1] [-no_ssl2] [-no_ssl3] [-no_tls1] [-fallback_scsv] [-bugs] [-cipher cipherlist] [-starttls protocol] [-xmpphost hostname] [-engine id] [-tlsextdebug] [-no_ticket] [-sess_out filename] [-sess_in filename] [-rand file(s)]

##### DESCRIPTION

The s_client command implements a generic SSL/TLS client which connects to a remote host using SSL/TLS. It is a very useful diagnostic tool for SSL servers.

##### OPTIONS

* -connect host:port
  * This specifies the host and optional port to connect to. If not specified then an attempt is made to connect to the local host on port 4433.
  * This implements a generic SSL/TLS client which can establish a transparent connection to a remote server speaking SSL/TLS. It's intended for testing purposes only and provides only rudimentary interface functionality but internally uses mostly all functionality of the OpenSSL ssl library.
  * Connecting to SSL Services
  * Doc referred : https://www.feistyduck.com/library/openssl-cookbook/online/ch-testing-with-openssl.html
  * OpenSSL comes with a client tool that you can use to connect to a secure server. The tool is similar to telnet or nc, in the sense that it handles the SSL/TLS layer but allows you to fully control the layer that comes next.
  * To connect to a server, you need to supply a hostname and a port. For example:
  
```bash
$ openssl s_client -connect www.feistyduck.com:443
CONNECTED(00000003)
depth=3 /C=SE/O=AddTrust AB/OU=AddTrust External TTP Network/CN=AddTrust External CA Root
verify error:num=19:self signed certificate in certificate chain
verify return:0
---
Certificate chain
 0 s:/OU=Domain Control Validated/OU=PositiveSSL/CN=www.feistyduck.com
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
subject=/OU=Domain Control Validated/OU=PositiveSSL/CN=www.feistyduck.com
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
Host: www.feistyduck.com
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
```



#### x509

##### NAME

> x509 - Certificate display and signing utility

##### SYNOPSIS

openssl x509 [-inform DER|PEM|NET] [-outform DER|PEM|NET] [-keyform DER|PEM] [-CAform DER|PEM] [-CAkeyform DER|PEM] [-in filename] [-out filename] [-serial] [-hash] [-subject_hash] [-issuer_hash] [-ocspid] [-subject] [-issuer] [-nameopt option] [-email] [-startdate] [-enddate] [-purpose] [-dates] [-checkend num] [-modulus] [-fingerprint][-alias] [-noout] [-trustout] [-clrtrust] [-clrreject] [-addtrust arg] [-addreject arg] [-setalias arg] [-days arg] [-set_serial n] [-signkey filename] [-passin arg][-x509toreq] [-req] [-CA filename] [-CAkey filename] [-CAcreateserial] [-CAserial filename] [-text] [-certopt option] [-C] [-md2|-md5|-sha1|-mdc2] [-clrext] [-extfile filename][-extensions section] [-engine id]

##### DESCRIPTION

The x509 command is a multi purpose certificate utility. It can be used to display certificate information, convert certificates to various forms, sign certificate requests like a "mini CA" or edit certificate trust settings.

##### OPTIONS

* -noout
  * this option prevents output of the encoded version of the request.

* -dates
  * prints out the start and expiry dates of a certificate.

* -in filename
  * This specifies the input filename to read a certificate from or standard input if this option is not specified.

* -text
  * prints out the certificate in text form. Full details are output including the public key, signature algorithms, issuer and subject names, serial number any extensions present and any trust settings.
  
##### EXAMPLES

To get the certificate expiry dates

```bash
$ openssl s_client -connect 10.57.148.133:443 2>/dev/null | openssl x509 -noout -dates
notBefore=Nov  8 23:47:37 2017 GMT
notAfter=Nov  9 23:47:37 2019 GMT
```

To get detailed information

```bash
$ openssl x509 -in georgebackend.oms.prod.company.com.pem -text -noout                                                                                                             ``
```