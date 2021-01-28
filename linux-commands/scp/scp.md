## scp

### NAME

scp -- secure copy (remote file copy program)

### SYNOPSIS

> scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file] [-l limit] [-o ssh_option] [-P port] [-S program] [[user@]host1:]file1 ... [[user@]host2:]file2


### DESCRIPTION

scp copies files between hosts on a network.  It uses ssh(1) for data transfer, and uses the same authentication and provides the same security as ssh(1).  scp will ask for passwords or passphrases if they are needed for authentication.

File names may contain a user and host specification to indicate that the file is to be copied to/from that host.  Local file names can be made explicit using absolute or relative pathnames to avoid scp treating file names containing `:' as host specifiers.  Copies between two remote hosts are also permitted.

### OPTIONS

* -r      
  * Recursively copy entire directories.  Note that scp follows symbolic links encountered in the tree traversal.
  
```bash
scp -r app@10.117.157.66:/app/jboss-eap-6.4.0/jboss-as/standalone/configuration/fileName .
scp -r fileName app@10.117.140.110:/app/jboss-eap-6.4.0/jboss-as/standalone/configuration/
```