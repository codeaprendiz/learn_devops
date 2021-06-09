## ssh

### NAME

ssh -- OpenSSH SSH client (remote login program)

### SYNOPSIS

> ssh [-1246AaCfGgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec] [-D [bind_address:]port] [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11] [-i identity_file] [-J [user@]host[:port]] [-L address] [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port] [-Q query_option] [-R address] [-S ctl_path] [-W host:port] [-w local_tun[:remote_tun]] [user@]hostname [command][-w local_tun[:remote_tun]] [user@]hostname [command]

### DESCRIPTION

ssh (SSH client) is a program for logging into a remote machine and for executing commands on a remote machine.  It is intended to provide secure encrypted communications between two untrusted hosts over an insecure network. 

ssh connects and logs into the specified hostname (with optional user name).  The user must prove his/her identity to the remote machine using one of several methods (see below).

The options are as follows:
 
* -i identity_file 
  * Selects a file from which the identity (private key) for public key authentication is read.  The default is ~/.ssh/identity for protocol version 1, and ~/.ssh/id_dsa, ~/.ssh/id_ecdsa, ~/.ssh/id_ed25519 and ~/.ssh/id_rsa for protocol version 2.  Identity files may also be specified on a per-host basis in the configuration file. It is possible to have multiple -i options (and multiple identities specified in configuration files).  If no certificates have been explicitly specified by the CertificateFile directive, ssh will also try to load certificate information from the filename obtained by appending -cert.pub to identity filenames.

* -o option
  * Can be used to give options in the format used in the configuration file.  This is useful for specifying options for which there is no separate command-line flag.  For full details of the options listed below, and their possible values, see ssh_config(5).
  * option
     * StrictHostKeyChecking:
        * (info from ‘man ssh_config’) If this flag is set to yes, ssh(1) will never automatically add host keys to the ~/.ssh/known_hosts file, and refuses to connect to hosts whose host key has changed. This provides maximum protection against trojan horse attacks, though it can be annoying when the /etc/ssh/ssh_known_hosts file is poorly maintained or when connections to new hosts are frequently made.  This option forces the user to manually add all new hosts. If this flag is set to no, ssh will automatically add new host keys to the user known hosts files. If this flag is set to ask (the default), new host keys will be added to the user known host files only after the user has confirmed that is what they really want to do, and ssh will refuse to connect to hosts whose host key has changed. The host keys of known hosts will be verified automatically in all cases.
        "StrictHostKeyChecking" is a setting at the ssh client side.
        * If set to "No" new host keys will be automatically added to the known_hosts file, and changed host keys will be silently replaced.
        * Setting it to "yes" is meant to give some protection against trojan horse attacks, but every new or changed host key must be added or replaced manually.
        * I'd recommend setting it to "ask". With this setting at least new host keys will be added automatically after user confirmation, and changed host keys will never be replaced, so security is maintained yet life becomes a bit easier in an environment where many new hosts need to be accessed.

* -o Port
    * For giving port
* -X      
    * Enables X11 forwarding.  This can also be specified on a per-host basis in a configuration file.
    
### EXAMPLES

```bash
ssh app@10.111.123.23
```

If you want to use a different key file then

```bash
ssh -i keyFileName app@10.111.123.23
```

-o

```bash
$ ssh -o StrictHostKeyChecking=no app@$newHostname
```

Port - Specifies the port number to connect on the remote host.  The default is 22.

```bash
$ ssh -v -o Port=2222 oracle@127.0.0.1
```

To login into remote host with X11 forwarding enabled use the following command. For more details see xclock

```bash
localUser@DESKTOP:~$ ssh remoteUser@35.238.65.79 -X
```

**Setting up ssh login between local and remote vm**

Local

```bash
localUser@DESKTOP:~$ uname -a
Linux DESKTOP 4.4.0-18362-Microsoft #1-Microsoft Mon Mar 18 12:02:00 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
localUser@DESKTOP~$ ssh-keygen
```

Remote

```bash
remoteUser@test-instance:~$ uname -a
Linux test-instance 4.9.0-11-amd64 #1 SMP Debian 4.9.189-3 (2019-09-02) x86_64 GNU/Linux
remoteUser@test-instance:~$ ssh-keygen
```

Copy the ~/.ssh/id_rsa.pub of localUser to ~/.ssh/authorized_keys of remoteUser with permission 600

Remote

```bash
remoteUser@test-instance:~/.ssh$ vi authorized_keys
remoteUser@test-instance:~/.ssh$ chmod 600 ~/.ssh/authorized_keys
```

Try logging in to the remote machine using ssh from the local machine

Local

```bash
localUser@DESKTOP:~$ ssh remoteUser@35.238.65.79
remoteUser@test-instance:~$
```

To login using the bastion server

```bash
$ ssh -o ProxyCommand="ssh -i private_key_to_login.pem -W %h:%p ubuntu@bastion.host.link" -i private_key_to_login.pem ubuntu@172.126.146.224 -vvvvv
```

To run a command on another machine (like node01) from local (say controlplane)

```bash
controlplane $ ssh node01 ifconfig ens3
Warning: Permanently added 'node01,172.17.0.25' (ECDSA) to the list of known hosts.
ens3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.25  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:acff:fe11:19  prefixlen 64  scopeid 0x20<link>
        ether 02:42:ac:11:00:19  txqueuelen 1000  (Ethernet)
        RX packets 136298  bytes 155301021 (155.3 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 50435  bytes 5498608 (5.4 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```