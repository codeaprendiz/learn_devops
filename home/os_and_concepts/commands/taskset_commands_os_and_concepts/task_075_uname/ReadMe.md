# uname

<br>

## NAME

uname - print system information

<br>

## SYNOPSIS

> uname [OPTION]...

<br>

## DESCRIPTION

Print certain system information.  With no OPTION, same as -s.

- -a, --all
  - print all information, in the following order, except omit -p and -i if unknown:
- -s, --kernel-name
  - This option stands for "system name" and returns the name of the operating system kernel. This option is commonly used to determine which operating system is currently running on the machine. For example, on a Linux machine, the uname -s command will return "Linux".
- -n, --nodename
  - print the network node hostname
- -r, --kernel-release
  - print the kernel release
- -v, --kernel-version
  - print the kernel version
- -m, --machine
  - This option stands for "machine architecture" and returns the machine hardware name. This option is commonly used to determine the CPU architecture of the machine. For example, on an x86-based machine, the uname -m command will return "x86_64".
- -p, --processor
  - print the processor type or "unknown"
- -i, --hardware-platform
  - print the hardware platform or "unknown"
- -o, --operating-system
  - print the operating system
- --help display this help and exit
  - --version
- output version information and exit

<br>

## Examples

```bash
$ uname -a
Linux test.hq.test.com 2.6.18-419.el5 #1 SMP Wed Feb 22 22:40:57 EST 2017 x86_64 x86_64 x86_64 GNU/Linux

$ uname -s
Linux

# x86_64: If you see this, your computer has a 64-bit Intel or AMD processor, which is not ARM-based.
# arm64, aarch64: These indicate that your processor is 64-bit ARM architecture. The M1 Macs, released by Apple in 2020, use Apple's own M1 chips, which are based on ARM architecture.
$ uname -m   # linux machine
x86_64

$ uname -m    # m1 mac 
arm64
```
