## umask

### DESCRIPTION 

Its a shell built-in

Shell builtin command

Return, or set, the value of the system's file mode creation mask.

On Linux and other Unix-like operating systems, new files are created with a default set of permissions. Specifically, a new file's permissions may be restricted in a specific way by applying a permissions "mask" called the umask. The umask command is used to set this mask, or to show you its current value.

In octal representations of file permissions, there are actually four digits.The first digit is a special file permission indicator, and for the purposes of this discussion can be considered always to be zero. So from here on out, when we discuss file permission 777, it may also be referred to as 0777.

The umask masks permissions by restricting them by a certain value.Essentially, each digit of the umask is "subtracted" from the OS's default value to arrive at the default value that you define. It's not really subtraction; technically, the mask is negated (its bitwise compliment is taken) and this value is then applied to the default permissions using a logical AND operation. The result is that the umask tells the operating system which permission bits to "turn off" when it creates a file. So it's not really subtraction, but it's a similar concept, and thinking of it as subtraction can help to understand it.

In Linux, the default permissions value is 666 for a regular file, and 777 for a directory. When creating a new file or directory, the kernel takes this default value, "subtracts" the umask value, and gives the new files the resulting permissions.

So if our umask value is 022, then any new files will, by default, have the permissions 644 (666 - 022). Likewise, any new directories will, by default, be created with the permissions 755 (777 - 022).

### EXAMPLES

Following  will return your system's umask as a four-digit octal number, for example:

```bash
m-C02SN6PVG8WN:~ asr000p$ umask
0022
m-C02SN6PVG8WN:~ asr000p$ 
```

Now let's change the umask. To set a umask of 022, use the command:

```bash
umask 022
```

This is the same as running umask 0022; if you specify only three digits, the first digit will be assumed to be zero. Let's verify that the change took place:

And now let's create a new file:

```bash
$ touch testfile
ls -l testfile
-rw-r--r-- 1 myusername myusername 0 Jan  7 14:39 testfile
```

