- [Output Redirection](#output-redirection)
- [Input Redirection](#input-redirection)
- [EOF / Here Document](#eof-here-document)
- [3>&1 1>&2 2>&3, >/dev/null 2>&1, ](#dev-null-and-others-usually-used-in-redirection)
- [Sepcial Variables](#special-variables)
- [Special Files](#special-files)
- [CORE DNS](#core-dns)

## output-redirection 

The output from a command normally intended for standard output can be easily diverted to a file instead. This capability is known as output redirection.

If the notation > file is appended to any command that normally writes its output to standard output, the output of that command will be written to file instead of your terminal.

Check the following who command which redirects the complete output of the command in the users file.

```bash
$ who > users
$ cat users
oko         tty01 Sep 12 07:30
ai          tty15 Sep 12 13:32
ruth        tty21 Sep 12 10:10
pat         tty24 Sep 12 13:07
steve       tty25 Sep 12 13:03
$
```

If a command has its output redirected to a file and the file already contains some data, that data will be lost.

You can use >> operator to append the output in an existing file

## input-redirection

The commands that normally take their input from the standard input can have their input redirected from a file in this manner. For example, to count the number of lines in the file users generated above, you can execute the command as follows −

```bash
$ wc -l users
2 users
$
```

Upon execution, you will receive the following output. You can count the number of lines in the file by redirecting the standard input of the wc command from the file users −

```bash
$ wc -l < users
2
$
```

In the first case, wc knows that it is reading its input from the file users. In the second case, it only knows that it is reading its input from standard input so it does not display file name.


## eof-here-document

A here document is used to redirect input into an interactive shell script or program.

We can run an interactive program within a shell script without user action by supplying the required input for the interactive program, or interactive shell script.

The general form for a here document is −

```bash
command << delimiter
document
delimiter
```

Here the shell interprets the << operator as an instruction to read input until it finds a line containing the specified delimiter. All the input lines up to the line containing the delimiter are then fed into the standard input of the command.

The delimiter tells the shell that the here document has completed. Without it, the shell continues to read the input forever. The delimiter must be a single word that does not contain spaces or tabs.

Following is the input to the command wc -l to count the total number of lines −

```bash
$wc -l << EOF
   This is a simple lookup program 
for good (and bad) restaurants
in Cape Town.
EOF
3
$
```

## dev-null-and-others-usually-used-in-redirection

**>/dev/null 2>&1 meaning**

```bash
x * * * * /path/to/my/script > /dev/null 2>&1
```

- \> is for redirect
- /dev/null is a black hole where any data sent, will be discarded
- 2 is the file descriptor for Standard Error
- \> is for redirect
- & is the symbol for file descriptor (without it, the following 1 would be considered a filename)
- 1 is the file descriptor for Standard Out
- Therefore >/dev/null 2>&1 is redirect the output of your program to /dev/null. Include both the Standard Error and Standard Out.


**>, 1>, 2> meaning**

The > operator redirects the output usually to a file but it can be to a device. You can also use >> to append.

If you don't specify a number then the standard output stream is assumed but you can also redirect errors
- \> file redirects stdout to file
- 1> file redirects stdout to file
- 2> file redirects stderr to file
- &> file redirects stdout and stderr to file

/dev/null is the null device it takes any input you want and throws it away. It can be used to suppress any output.


**3>&1 1>&2 2>&3 meaning**

\>name means redirect output to file name.

\>&number means redirect output to file descriptor number.

The numbers are file descriptors and only the first three (starting with zero) have a standardized meaning:

- 0 - stdin
- 1 - stdout
- 2 - stderr

So each of these numbers in your command refer to a file descriptor. You can either redirect a file descriptor to a file with > or redirect it to another file descriptor with >&

The 3>&1 in your command line will create a new file descriptor and redirect it to 1 which is STDOUT. Now 1>&2 will redirect the file descriptor 1 to STDERR and 2>&3 will redirect file descriptor 2 to 3 which is STDOUT.

So basically you switched STDOUT and STDERR, these are the steps:
- Create a new fd 3 and point it to the fd 1
- Redirect file descriptor 1 to file descriptor 2. If we wouldn't have saved the file descriptor in 3 we would lose the target.
- Redirect file descriptor 2 to file descriptor 3. Now file descriptors one and two are switched.

Now if the program prints something to the file descriptor 1, it will be printed to the file descriptor 2 and vice versa.

**Difference between < and << in shell command**

\> is used to write to a file and >> is used to append to a file.

Thus, when you use ps aux > file, the output of ps aux will be written to file and if a file named file was already present, its contents will be overwritten.

And if you use ps aux >> file, the output of ps aux will be written to file and if the file named file was already present, the file will now contain its previous contents and also the contents of ps aux, written after its older contents of file.

**Difference between single and double quotes in Bash ( "" and '')**

Single quotes won't interpolate anything, but double quotes will. For example: variables, backticks, certain \ escapes, etc

The Bash manual has this to say:

SINGLE QUOTES

- Enclosing characters in single quotes (') preserves the literal value of each character within the quotes. A single quote may not occur between single quotes, even when preceded by a backslash.

DOUBLE QUOTES

- Enclosing characters in double quotes (") preserves the literal value of all characters within the quotes, with the exception of $, `, \, and, when history expansion is enabled, !. The characters $ and ` retain their special meaning within double quotes (see Shell Expansions). The backslash retains its special meaning only when followed by one of the following characters: $, `, ", \, or newline. Within double quotes, backslashes that are followed by one of these characters are removed. Backslashes preceding characters without a special meaning are left unmodified. A double quote may be quoted within double quotes by preceding it with a backslash. If enabled, history expansion will be performed unless an ! appearing in double quotes is escaped using a backslash. The backslash preceding the ! is not removed. The special parameters * and @ have special meaning when in double quotes


## special-variables

### #! /Shebang character

In computing, a shebang is the character sequence consisting of the characters number sign and exclamation mark (#!) at the beginning of a script.

In Unix-like operating systems, when a text file with a shebang is used as if it is an executable, the program loader parses the rest of the file's initial line as an interpreter directive; the specified interpreter program is executed, passing to it as an argument the path that was initially used when attempting to run the script,[8] so that the program may use the file as input data. For example, if a script is named with the path path/to/script, and it starts with the following line, #!/bin/sh, then the program loader is instructed to run the program /bin/sh, passing path/to/script as the first argument

SYNTAX

The form of a shebang interpreter directive is as follows:

> \#!interpreter [optional-arg]

- in which interpreter is an absolute path to an executable program. The optional argument is a string representing a single argument. White space after #! is optional. In Linux, the file specified by interpreter can be executed if it has the execute right and contains code which the kernel can execute directly, if it has a wrapper defined for it via sysctl (such as for executing Microsoft EXE binaries using wine), or if it contains a shebang.
- Some other example shebangs are:

```bash
#!/bin/sh — Execute the file using sh, the Bourne shell, or a compatible shell 
#!/bin/csh — Execute the file using csh, the C shell, or a compatible shell 
#!/usr/bin/perl -T — Execute using Perl with the option for taint checks 
#!/usr/bin/php — Execute the file using the PHP command line interpreter 
#!/usr/bin/python -O — Execute using Python with optimizations to code 
#!/usr/bin/ruby — Execute using Ruby 
```


### Variables

The following shows a number of special variables that you can use in your shell scripts −

$0
- The filename of the current script 

$n
- These variables correspond to the arguments with which a script was invoked. Here n is a positive decimal number corresponding to the position of an argument (the first argument is $1, the second argument is $2, and so on). 

$# 

-The number of arguments supplied to a script 

$* 

- All the arguments are double quoted. If a script receives two arguments, $* is equivalent to $1 $2 

$@ 

- All the arguments are individually double quoted. If a script receives two arguments, $@ is equivalent to $1 $2 

$? 

- The exit status of the last command executed. Exit status is a numerical value returned by every command upon its completion. As a rule, most commands return an exit status of 0 if they were successful, and 1 if they were unsuccessful. 

$$

- The process number of the current shell. For shell scripts, this is the process ID under which they are executing. 

$! 

- The process number of the last background command. 

### Command line Arguments

The command-line arguments $1, $2, $3, ...$9 are positional parameters, with $0 pointing to the actual command, program, shell script, or function and $1, $2, $3, ...$9 as the arguments to the command.

Following script uses various special variables related to the command line −

```bash
#!/bin/sh
echo "File Name: $0"
echo "First Parameter : $1"
echo "Second Parameter : $2"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "Total Number of Parameters : $#"
```

Here is the output of the following script

```bash
$./test.sh Zara Ali
File Name : ./test.sh
First Parameter : Zara
Second Parameter : Ali
Quoted Values: Zara Ali
Quoted Values: Zara Ali
Total Number of Parameters : 2
```


## special-files

### /etc/fstab

[http://www.linfo.org/etc_fstab.html](http://www.linfo.org/etc_fstab.html)

fstab is a system configuration file on Linux and other Unix-like operating systems that contains information about major filesystems on the system. It takes its name from file systems table, and it is located in the /etc directory.

/etc/fstab can be safely viewed by using the cat command (which is used to read text files) as follows:

```bash
#
# /etc/fstab
# Created by anaconda on Mon Aug 14 20:57:26 2017
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=784a2acb-e8a7-4485-a6f6-6c2333d013b1 /                       xfs defaults 0 0
/dev/vdb /mnt auto defaults,nofail,comment=cloudconfig 0 2
dfw-nfs3-vs10.prod.ankit.com:/stg_ankit_geo_01 /geo_camel_nfsshared/  nfs defaults 0 0
```

### /etc/hosts

The computer file hosts is an operating system file that maps hostnames to IP addresses. It is a plain text file. Originally a file named HOSTS.TXT was manually maintained and made available via file sharing by Stanford Research Institute for the ARPANET membership, containing the hostnames and address of hosts as contributed for inclusion by member organizations. The Domain Name System, first described in 1983 and implemented in 1984, automated the publication process and provided instantaneous and dynamic hostname resolution in the rapidly growing network. In modern operating systems, the hosts file remains an alternative name resolution mechanism, configurable often as part of facilities such as the Name Service Switch as either the primary method or as a fallback method.

PURPOSE

The hosts file is one of several system facilities that assists in addressing network nodes in a computer network. It is a common part of an operating system's Internet Protocol (IP) implementation, and serves the function of translating human-friendly hostnames into numeric protocol addresses, called IP addresses, that identify and locate a host in an IP network.

In some operating systems, the contents of the hosts file is used preferentially to other name resolution methods, such as the Domain Name System (DNS), but many systems implement name service switches, e.g., nsswitch.conf for Linux and Unix, to provide customization. Unlike remote DNS resolvers, the hosts file is under the direct control of the local computer's administrator.

FILE CONTENT

The hosts file contains lines of text consisting of an IP address in the first text field followed by one or more host names. Each field is separated by white space – tabs are often preferred for historical reasons, but spaces are also used. Comment lines may be included; they are indicated by an octothorpe (#) in the first position of such lines. Entirely blank lines in the file are ignored. For example, a typical hosts file may contain the following:

```bash
127.0.0.1  localhost loopback
::1        localhost
```

This example only contains entries for the loopback addresses of the system and their host names, a typical default content of the hosts file. The example illustrates that an IP address may have multiple host names (localhost and loopback), and that a host name may be mapped to both IPv4 and IPv6 IP addresses, as shown on the first and second lines respectively.
Your browser you go to this 172.16.104.21  IP address first to get the response.
```bash
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1 localhost
255.255.255.255 broadcasthost
::1             localhost
172.16.104.21   test.oms.qa.domain.com
```

### /etc/reslov.conf

Path on mac : /etc/reslov.conf

Each entry can be called as additional search domain.

resolv.conf is the name of a computer file used in various operating systems to configure the system's Domain Name System (DNS) resolver. The file is a plain-text file usually created by the network administrator or by applications that manage the configuration tasks of the system. The resolvconf program is one such program on FreeBSD or other Unix machines which manages the resolv.conf file.

PURPOSE

In most Unix-like operating systems and others that implement the BIND Domain Name System (DNS) resolver library, the resolv.conf configuration file contains information that determines the operational parameters of the DNS resolver. The DNS resolver allows applications running in the operating system to translate human-friendly domain names into the numeric IP addresses that are required for access to resources on the local area network or the Internet. The process of determining IP addresses from domain names is called resolving.

CONTENTS AND LOCATION

The file resolv.conf typically contains directives that specify the default search domains; used for completing a given query name to a fully qualified domain name when no domain suffix is supplied. It also contains a list of IP addresses of nameservers available for resolution. An example file is:

```bash
search example.com local.lan
nameserver 127.0.0.1
nameserver 172.16.1.254
nameserver 172.16.2.254
```

Here `search` says if I try to run the following command

```bash
ping web
```

- Then it would try to looks for `web.example.com` first and then `web.local.lan` and so forth

resolv.conf is usually located in the /etc directory of the file system. The file is either maintained manually, or when DHCP is used, it is usually updated with the utility resolvconf.

### /proc/sys/fs/file-max vs ulimit

file-max is the maximum File Descriptors (FD) enforced on a kernel level, which cannot be surpassed by all processes without increasing. 

The ulimit is enforced on a process level, which can be less than the file-max. If some user has launched 4 processes and the ulimit configuration for FDs is 1024, each process may open 1024 FDs. The user is not going to be limited to 1024 FDs but the processes which are launched by that user.

```bash
me@superme:~$ ulimit -n 
1024 
me@superme:~$ lsof | grep $USER | wc -l 
8145
```

How do I know if I’m getting close to hitting this limit on my server? Run the command: cat /proc/sys/fs/file-nr. This will return three values, denote the number of allocated file handles, the number of allocated but unused file handles, and the maximum number of file handles. Note that file-nr IS NOT a tunable parameter. It is informational only. On my server, this returns: 3488 0 793759. This means that currently, my server has only allocated 3488 of the 793,759 allocation limit and is in no danger of hitting this limit at this time.


###  /proc/sys/net/ipv4/ip_forward

- if IP forwarding is enabled on a host
  - 1 indicates Yes
  - 0 indicates No

```bash
$ cat /proc/sys/net/ipv4/ip_forward
0

$ echo 1 > /proc/sys/net/ipv4/ip_forward
```


### /etc/sysctl.conf

[sysctl.conf](https://man7.org/linux/man-pages/man5/sysctl.conf.5.html)

Enable packet forwarding for IPv4.



```bash
$ cat /etc/sysctl.conf

# Uncomment the line
net.ipv4.ip_forward=1
```


### core-dns

We are given a server dedicated as the DNS server, and a set of Ips to configure as entries in the server. There are many DNS server solutions out there.
We will focus on a particular one – CoreDNS.

So how do you get core dns? CoreDNS binaries can be downloaded from their Github releases page or as a docker image. Let’s go the traditional route. Download the binary using curl or wget. And extract it. You get the coredns executable.

```bash
$ wget LINK

$ tar -xzvf coredns_version_amd64.tgz

$ ./coredns
```

Run the executable to start a DNS server. It by default listens on port 53, which is the default port for a DNS server.

Now we haven’t specified the IP to hostname mappings. For that you need to provide some configurations. There are multiple ways to do that. We will look at one. First we put all of the entries into the DNS servers /etc/hosts file.

And then we configure CoreDNS to use that file. CoreDNS loads it’s configuration from a file named Corefile. Here is a simple configuration that instructs CoreDNS to fetch the IP to hostname mappings from the file /etc/hosts. When the DNS server is run, it now picks the Ips and names from the /etc/hosts file on the server.

```bash
$ cat /etc/hosts
192.168.1.9 web
192.168.1.10 db

$ cat Corefile
{
  hosts /etc/hosts
}

./coredns
```