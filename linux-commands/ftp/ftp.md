## ftp

### NAME

ftp -- Internet file transfer program

### SYNOPSIS

> ftp [-46AadefginpRtvV] [-N netrc] [-o output] [-P port] [-q quittime] [-s srcaddr] [-r retry] [-T dir,max[,inc]] [[user@]host [port]] [[user@]host:[path][/]] [file:///path][ftp://[user[:password]@]host[:port]/path[/][;type=X]]        [http://[user[:password]@]host[:port]/path] [...]

>ftp -u URL file [...]

### DESCRIPTION

ftp is the user interface to the Internet standard File Transfer Protocol.  

The program allows a user to transfer files to and from a remote network site.

The last five arguments will fetch a file using the FTP or HTTP protocols, or by direct copying, into the current directory.  This is ideal for scripts. 

### OPTIONS

* ls [remote-path [local-file]]
  * A synonym for dir.
* cd remote-directory
  * Change the working directory on the remote machine to remote-directory.
* get remote-file [local-file]
  * Retrieve the remote-file and store it on the local machine.  If the local file name is not specified, it is given the same name it has on the remote machine, subject to alteration by the current case, ntrans, and nmap settings.  The current settings for type, form, mode, and structure are used while transferring the file.
* lcd [directory]
  * Change the working directory on the local machine.  If no directory is specified, the user's home directory is used.
* lpwd        
  * Print the working directory on the local machine.
* pwd         
  * Print the name of the current working directory on the remote machine.
* delete remote-file
  * Delete the file remote-file on the remote machine.
* put local-file [remote-file]
  * Store a local file on the remote machine.  If remote-file is left unspecified, the local file name is used after processing according to any ntrans or nmap settings  in naming the remote file. File transfer uses the current settings for type, format, mode, and structure.
* bye         
  * Terminate the FTP session with the remote server and exit ftp.  An end of file will also terminate the session and exit.


### EXAMPLES

Logging in

```bash
$ ftp username@hostname
Trying 2.16.1336.33...
Connected to some_domain_name.
220 Akamai Content Storage FTP Server
331 Password required for hostname.
Password: 
230 User username logged in.
Remote system type is UNIX.
Using binary mode to transfer files.
```

To see the dir contents and to move into a directory

```bash
ftp> ls
ftp> cd dirName
```

To download a file

```bash
ftp> get resume.pdf
local: resume.pdf remote: resume.pdf
229 Entering Extended Passive Mode (|||55093|)
150 Opening BINARY mode data connection for 'resume.pdf' (53077 bytes).
100% |*********************************************************************| 53077       12.58 KiB/s 00:00 ETA
226 Transfer complete.
53077 bytes received in 00:04 (12.57 KiB/s)
```

To change to a local directory and print its path

```bash
ftp> lcd /tmp
Local directory now: /tmp
ftp> lpwd
/tmp
```

To print the current directory on remote ftp server

```bash
ftp> pwd
Remote directory: /pub/FreeBSD
```

To delete a file in current remote directory

```bash
ftp> delete fileName
```

To copy one file at a time from the local systems to the remote ftp server, enter:

```bash
ftp> put fileNameOnLocal
```

