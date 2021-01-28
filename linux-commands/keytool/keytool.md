## keytool 

### NAME

keytool - key and certificate management tool

### SYNOPSIS

> keytool [ commands ]

### DESCRIPTION

keytool  is a key and certificate management utility. 

It enables users to administer their own public/private key pairs and associated certificates for use in self-authentication (where the user authenticates himself/herself to other users/services) or data integrity and authentication services, using digital signatures.

It  also allows users to cache the public keys (in the form of certificates) of their communicating peers.

- A  certificate is a digitally signed statement from one entity (person, company, and so forth), saying that the public key (and some other information) of some other entity has a particular value. 

- When data is digitally signed, the signature can be verified to check the data integrity and authenticity. 

    - Integrity means that the data has not been modified or tampered with, and authenticity means the data indeed comes from whoever claims to have created and signed it.

keytool  stores the keys and certificates in a so-called **keystore**.  The keytool default keystore implementation implements the keystore as a file. It protects private keys with a password.


**Keystore Entries**

There are two different types of entries in a keystore:

* key entries
  * --each holds very sensitive cryptographic key information, which is stored in a protected format to prevent unauthorized access.  
  * Typically, a key stored in this type of entry is a secret key, or a private key accompanied by the certificate "chain" for the corresponding public key. The keytool and jarsigner(1) tools only handle the latter type of entry, that is, private keys and their associated certificate chains.
* trusted certificate entries
  * --each contains a single public key certificate belonging to another party. It is called a "trusted  certificate" because the keystore owner trusts that the public key in the certificate indeed belongs to the identity identified by the "subject" (owner) of the certificate. The issuer of the certificate vouches for this, by signing the certificate.
  

**Keystore Aliases**

All keystore entries (key and trusted certificate entries) are accessed via unique aliases. 

Aliases are case-insensitive; the aliases Hugo and hugo would refer to the same keystore entry.

An  alias  is specified  when you add an entity to the keystore using the -genkey subcommand to generate a key pair (public and private key) or the -import subcommand to add a certificate or certificate chain to the list of trusted certificates. 

Subsequent keytool commands must use this same alias to refer to the entity. For example, suppose you use the alias duke to generate a new public/private key pair and wrap the public key into a self-signed certificate via the following command:

> keytool -genkey -alias duke -keypass dukekeypasswd

- This  specifies an inital password of dukekeypasswd required by subsequent commands to access the private key assocated with the alias duke.  If you later want to change duke's private key password, you use a command like the following:

> keytool -keypasswd -alias duke -keypass dukekeypasswd -new newpass

This changes the password from "dukekeypasswd" to "newpass".


**Keystore Location**

Each keytool command has a -keystore option for specifying the name and location of the persistent keystore file for the keystore  managed by keytool. The keystore is by default stored in a file named .keystore in the user's home directory, as determined by the "user.home" system property.


**Keystore Creation**

- A keystore is created whenever you use a -genkey, -import, or -identitydb subcommand to add data to a keystore that doesn't yet exist.

- More specifically, if you specify, in the -keystore option, a keystore that doesn't yet exist, that keystore will be created. If you don't specify a -keystore option, the default keystore is a file named .keystore in your home directory.  If that file does not yet exist, it will be created.


**Keystore Implementation**

The KeyStore class provided in the java.security package supplies well-defined interfaces to access and modify the information in a keystore.  It is possible for there to be multiple different concrete implementations, where each implementation is that for a particular type of keystore.

Currently,  there are two command-line tools (keytool and jarsigner(1)) and also a GUI-based tool named policytool.  Since KeyStore is publicly available, JDK users can write additional security applications that use it.

Keystore  implementations  are provider-based.   More specifically, the application interfaces supplied by KeyStore are implemented in terms of a "Service Provider Interface" (SPI).  That is, there is a corresponding abstract KeystoreSpi class, also in the java.security package, which defines the Service Provider Interface methods  that "providers" must implement. (The term "provider" refers to a package or a set of packages that supply a concrete implementation of a subset of services that can be accessed by the Java Security API.)  Thus, to provide a keystore implementation, clients must implement a "provider" and supply a KeystoreSpi subclass implementation, as described in How to Implement a Provider for the Java Cryptography Architecture.

Applications  can choose different types of keystore implementations from different providers, using the "getInstance" factory method supplied in the KeyStore class. A keystore type defines the storage and data format of the keystore information, and the algorithms used to protect private keys in the keystore and the integrity of the keystore  itself.

Keystore implementations of different types are not compatible.

keytool works on any file-based keystore implementation.  (It treats the keystore location that is passed to it at the command line as a filename and converts it to a FileInput-Stream, from which it loads the keystore information.) The jarsigner(1) and policytool tools, on the other hand, can read a keystore from any location  that can be specified using a URL.

For  keytool and jarsigner(1), you can specify a keystore type at the command line, via the -storetype option.  For Policy Tool, you can specify a keystore type via the "Change Keystore" command in the Edit menu.

If you don't explicitly specify a keystore type, the tools choose a keystore implementation based simply on the value of the keystore.type property specified  in the security properties file. The security properties file is called java.security, and it resides in the JDK security properties directory, java.home/lib/security, where java.home is the JDK installation directory. Each tool gets the keystore.type value and then examines all the currently-installed providers until it finds one that implements keystores of that type. It then uses the  key-store implementation from that provider.

The  KeyStore class defines a static method named getDefaultType that lets applications and applets retrieve the value of the keystore.type property. The following line of code creates an instance of the default keystore type (as specified in the keystore.type property):

KeyStore keyStore = KeyStore.getInstance(KeyStore.getDefaultType());

The default keystore type is "jks" (the proprietary type of the keystore implementation provided by Sun). This is specified by the following line  in the security properties file:

keystore.type=jks

To have the tools utilize a keystore implementation other than the default, you can change that line to specify a different keystore type.

For example, if you have a provider package that supplies a keystore implementation for a keystore type called "pkcs12", change the line to

keystore.type=pkcs12


### OPTIONS

* -delete

  * Syntax

    > [-alias alias] {-storetype storetype} {-keystore keystore} [-storepass storepass] [-provider provider_class_name] {-v} {-Jjavaoption}

  * Deletes from the keystore the entry identified by alias.  The user is prompted for the alias, if no alias is provided at the command line.

* -import

  * Syntax
    
    > -import {-alias alias} {-file cert_file} [-keypass keypass]{-noprompt} {-trustcacerts} {-storetype storetype}{-keystore keystore} [-storepass storepass][-provider provider_class_name]{-v} {-Jjavaoption}

  * Reads the certificate or certificate chain (where the latter is supplied in a PKCS#7 formatted reply) from the file cert_file, and stores it in the keystore entry  identified by alias given, the certificate or PKCS#7 reply is read from stdin.

  * keytool  can import  X.509 v1, v2, and v3 certificates, and PKCS#7 formatted certificate chains consisting of certificates of that type. The data to be imported must be provided either in binary encoding format, or in printable encoding format (also known as Base64 encoding) as defined by the Internet RFC 1421 standard.  In the latter case, the encoding must be bounded at the beginning by a string that starts with "-----BEGIN", and bounded at the end by a string that starts with "-----END".

  * You import a certification for two reasons:
    
    * to add it to the list of trusted certificates, or

    * to import a certificate reply received from a CA as the result of submitting a Certificate Signing Request (see the -certreq command) to that CA.
    
    
* -list

  * Syntax

    > -list {-alias alias} {-storetype storetype} {-keystore keystore} [-storepass storepass] [-provider provider_class_name] {-v | -rfc} {-Jjavaoption}

  * Prints (to stdout) the contents of the keystore entry identified by alias.  If no alias is specified, the contents of the entire keystore are printed.

  * If the -v option is specified, the certificate is printed in human-readable format, with additional information  such as the owner, issuer, and serial number. If the -rfc option is specified, certificate contents are printed using the printable encoding format, as defined by the Internet RFC 1421 standard You cannot specify both -v and -rfc.

  * The keystore password is normally ‘changeit’ without quotes.

* -noprompt

  * If the -noprompt option is given, there is no interaction with the user.

* -printcert {-file cert_file} {-v} {-Jjavaoption}
  
  * Reads the certificate from the file cert_file, and prints its contents in a human-readable format. If no file is given, the certificate is read from stdin.
  * The certificate may be either binary encoded or in printable encoding format, as defined by the Internet RFC 1421 standard.
  * Note: This option can be used independently of a keystore.

* -storepass storepass

  * The password which is used to protect the integrity of the keystore.

* -v

  * The -v option can appear for all subcommands except -help.  If it appears, it signifies "verbose" mode; detailed certificate information will be output.
  
  
### EXAMPLES

* -import

  * To import a certificate a.cer with alias name iam_qa into keystore cacerts we use
  
```bash
$ keytool -v -import -file /app/a.cer -alias iam_qa -keystore /usr/java/default/jre/lib/security/cacerts
```

  * Similarly to import the .cer into .jks keystore we use

```bash
$ keytool -v -import -file xi52-cert.cert.hosting.asda.com2018.cer -alias ukil -keystore keystore.jks
```

  * Similarly to import the .cer into .jks keystore we can also use

```bash
$ keytool -keystore kestore.jks -importcert -file xi52-cert.cert.hosting.asda.com2018.cer -alias ukil
```

* -list

  * to print (to stdout) the contents of the keystore entry identified by alias. 

```bash
$ keytool -v -list -keystore sample.truststore -alias aliasNameGiven
Enter keystore password
```

* -noprompt, -storepass

```bash
$ echo | openssl s_client -connect qa.iam.platform.prod.company.com:443 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/a.cer
$ keytool -noprompt -import -file /tmp/a.cer -alias iam1233_qa -keystore /usr/java/default/jre/lib/security/cacerts -storepass changeit 
Certificate was added to keystore
$
```