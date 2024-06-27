# ln

- [ln](https://man7.org/linux/man-pages/man1/ln.1.html)
  
<br>

## NAME

link, ln -- make links

<br>

## DESCRIPTION

The ln utility creates a new directory entry (linked file) which has the same modes as the original file.  It is useful for maintaining multiple copies of a file in many places at once without using up storage for the ``copies''; instead, a link ``points'' to the original copy.  There are two types of links; hard links and symbolic links. How a link ``points'' to a file is one of the differences between a hard and symbolic link.

If you want to create a new symbolic link then you can use the following command. If you want to change the existing symbolic link then you can delete the existing symbolic link using rm command and then create a new one.

You can check where a symbolic link points to using the ls -l fileName command

<br>

## OPTIONS

- -s
  - Create a symbolic link.

<br>

## EXAMPLES

```bash
<br>

## let's say you created a new binary at /Users/username/aws-cli/bin/aws. So /Users/username/aws-cli/bin/aws --version works. 
<br>

## Now you want to add this to /usr/local/bin/ i.e. aws --version should work assuming /usr/local/bin is in $PATH
# ln -s /path/to/existing/file /path/to/new/that/should/be/created
$ ln -s /Users/username/aws-cli/bin/aws /usr/local/bin/aws 
.
```
