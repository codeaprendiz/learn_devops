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

####NAME

openssl-enc, enc - symmetric cipher routines


#### SYNOPSIS

> openssl enc -cipher [-help] [-ciphers] [-in filename] [-out filename] [-pass arg] [-e] [-d] [-a] [-base64] [-A] [-k password] [-kfile filename] [-K key] [-iv IV] [-S salt] [-salt] [-nosalt] [-z] [-md digest] [-p] [-P] [-bufsize number] [-nopad] [-debug] [-none] [-rand file...] [-writerand file] [-engine id]

> openssl [cipher] [...]

#### DESCRIPTION

The symmetric cipher commands allow data to be encrypted or decrypted using various block and stream ciphers using keys based on passwords or explicitly provided. Base64 encoding or decoding can also be performed either by itself or in addition to the encryption or decryption.

#### OPTIONS

#### OPTIONS

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
  
#### EXAMPLES

Just base64 encode a binary file:

```bash
$ openssl base64 -in file.bin -out file.b64
```
Decode the same file

$ openssl base64 -d -in file.b64 -out file.bin