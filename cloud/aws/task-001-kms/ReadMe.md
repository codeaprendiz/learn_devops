### Objective

To use the AWS KMS to encrypt and decrypt data using the aws kms

Inputs : 
1) You have already created a CUSTOMER MANAGER KEY using the AWS console with the alias
name as `master`
2) You have also created an IAM user with policy `AWSKeyManagementServicePowerUser`


Docs and Links referred

[aws kms generate-data-key](https://docs.aws.amazon.com/cli/latest/reference/kms/generate-data-key.html)

[youtube](https://www.youtube.com/watch?v=f3APF1dP8w0&t=604s&ab_channel=EnlearAcademy)

#### Step 1

Configure the AWS account using the right region and correct access keys

```bash
$ aws configure                                                            
AWS Access Key ID [****************]: 
AWS Secret Access Key [****************]: 
Default region name [ap-south-1]: 
Default output format [None]: 
```

#### Step 2

Let's list the aliases first to validate

```bash
$ aws kms list-aliases | grep master | grep -v "arn"
            "AliasName": "alias/master",
```

#### Step 3

Generate the symmetric keys using  `generate-data-key` method. Note that these
keys are base64 encoded.

```bash
$ aws kms generate-data-key --key-id alias/master --key-spec AES_256 --region ap-south-1
{
    "CiphertextBlob": "your_key_in_cipher_text",
    "Plaintext": "your_key_in_plain_text",
    "KeyId": "your_key_aws_arn"
}
```

#### Step 4

Decode you keys and save them in files

```bash
$ echo "your_key_in_cipher_text" | base64 --decode > ciphertextblob

$ echo "your_key_in_plain_text" | base64 --decode > plaintext
```

#### Step 5

Let's create a sensitive datafile

```bash
$ cat sensitivedatafile.txt          
This is very sensitive data
please do not copy
copying the data is strictly prohibited
okay you can copy the data.
```

#### Step 6

Encrypt the sensitive data file

```bash
$ openssl enc -in ./sensitivedatafile.txt -out ./sensitivedatafile_encrypted.txt -e -aes256 -k ./plaintext
```

> NOTE: Delete your plaintext symmetric key now. We will only store the encrypted version of the plaintext key

```bash
$ mv plaintext ~/tmp/
$ mv sensitivedatafile.txt /tmp/                                                            
```

Okay, I moved it to `/tmp` just in case. But we need to remove! Very Important!

#### Step 7

Now the task is to decrypt the `sensitivedatafile_encrypted.txt` using the `ciphertextblob`.
Both of them are encrypted files.

So first we will get the plaintext version of our datakey using the aws cli

```bash
$ aws kms decrypt --ciphertext-blob fileb://ciphertextblob --region ap-south-1
{
    "KeyId": "aws_arn",
    "Plaintext": "your_plaintext_key",
    "EncryptionAlgorithm": "SYMMETRIC_DEFAULT"
}
```

Decode the key

```bash
$ echo "your_plaintext_key" | base64 --decode > plaintext
```

#### Step 8
 
Finally decrypt the `sensitivedatafile_encrypted.txt` using the `plaintext` key you just obtained.
We will use the openssl library for the same

```bash
$ openssl enc -in ./sensitivedatafile_encrypted.txt -out ./sensitivedatafile_final.txt -d  -aes256 -k ./plaintext 

$ cat sensitivedatafile_final.txt
This is very sensitive data
please do not copy
copying the data is strictly prohibited
okay you can copy the data.
```