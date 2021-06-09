## hostname

### NAME

hostname -- set or print name of current host system

### SYNOPSIS

> hostname [-fs] [name-of-host]

### DESCRIPTION

The hostname utility prints the name of the current host.  The super-user can set the hostname by supplying an argument.  To keep the hostname between reboots, run `scutil --set HostName name-of-host'.


### OPTIONS

* -f    
  * Include domain information in the printed name.  This is the default behavior.
* -i 
   * Include the IP of the host
-s
  * Trim off any domain information from the printed name.

### EXAMPLE

```bash
hostname -f
m-C02SN6PVG8WN
```
