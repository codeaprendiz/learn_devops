# TLS Basics
  
In this section, we will take a look at TLS Basics

## Certificate
- A certificate is used to guarantee trust between 2 parties during a transaction.
- Example: when a user tries to access web server, tls certificates ensure that the communication between them is encrypted.

  ![cert1](../.images/.tls/cert1.PNG)
  
  
## Symmetric Encryption
- It is a secure way of encryption, but it uses the same key to encrypt and decrypt the data and the key has to be exchanged between the sender and the receiver, there is a risk of a hacker gaining access to the key and decrypting the data.

  ![cert2](../.images/.tls/cert2.PNG)
  
## Asymmetric Encryption
- Instead of using single key to encrypt and decrypt data, asymmetric encryption uses a pair of keys, a private key and a public key.

  ![cert3](../.images/.tls/cert3.PNG)
  
  ![cert4](../.images/.tls/cert4.PNG)
  
  ![cert5](../.images/.tls/cert5.PNG)
  
  ![cert6](../.images/.tls/cert6.PNG)
  

#### How do you look at a certificate and verify if it is legit?
- who signed and issued the certificate.
- If you generate the certificate then you will have it sign it by yourself; that is known as self-signed certificate.

  ![cert7](../.images/.tls/cert7.PNG)
  
#### How do you generate legitimate certificate? How do you get your certificates singed by someone with authority?
- That's where **`Certificate Authority (CA)`** comes in for you. Some of the popular ones are Symantec, DigiCert, Comodo, GlobalSign etc.

  ![cert8](../.images/.tls/cert8.PNG)
  
  ![cert9](../.images/.tls/cert9.PNG)
  
  ![cert10](../.images/.tls/cert10.PNG)
  
## Public Key Infrastructure
   
   ![pki](../.images/.tls/pki.PNG)
   
## Certificates naming convention

  ![cert11](../.images/.tls/cert11.PNG)
  
  
Credits
- [certified-kubernetes-administrator-course](https://github.com/kodekloudhub/certified-kubernetes-administrator-course)
  
  

  
   

  
  
  

  
  
  
  
  
  

  
  
