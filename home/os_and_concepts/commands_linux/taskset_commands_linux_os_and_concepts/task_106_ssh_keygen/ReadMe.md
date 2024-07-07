# ssh-keygen

- [ssh-keygen](https://www.man7.org/linux/man-pages/man1/ssh-keygen.1.html)

## Examples

These following commands are related to creating an SSH key pair, which consists of a private key and a corresponding public key. Here is what each part of the command does:

- `ssh-keygen`: This is the basic command to create SSH keys. SSH keys are used for secure communication between machines. They are a pair of keys (one public, one private) that are used to authenticate users to each other and encrypt the communication between them.

- `-q`: This flag stands for "quiet mode". When used, it suppresses the output of the command, making the command run silently without showing any messages.

- `-t rsa`: This option specifies the type of key to be created. RSA is one of the algorithms used to create SSH keys. It's widely used and considered secure.

- `-f key.pem`: This specifies the filename of the key. In this case, the private key will be saved in a file named `key.pem`.

- `-C key`: This is a comment that will be added to the public key file. It's useful for identifying the key. In this case, "key" will be added as a comment.

- `-N ''`: This specifies the passphrase for the key. In this case, an empty string is used, which means no passphrase will be used.

After the key is created, the `ls` command is used to list the files in the current directory. The output shows the private key file (`key.pem`) and the public key file (`key.pem.pub`).

Remember: The private key should always be kept secure and confidential, while the public key can be freely shared.

```bash
$ ssh-keygen -q -t rsa -f key.pem -C key -N ''
$ ls
key.pem     key.pem.pub
```