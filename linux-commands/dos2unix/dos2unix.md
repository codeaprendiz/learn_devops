## dos2unix


### NAME

dos2unix - DOS/MAC to UNIX text file format converter 

### SYNOPSIS

> dos2unix [options] [-c convmode] [-o file ...] [-n infile outfile ...] 

### OPTIONS

> [-hkqV] [--help] [--keepdate] [--quiet] [--version]

### DESCRIPTION

the program that converts plain text files in DOS/MAC format to UNIX format. 

### EXAMPLE

To convert all the *.sh files in the current directory to unix format (from windows format)

```bash
dos2unix *.sh
```