## tee

### NAME

tee - read from standard input and write to standard output and files

### SYNOPSIS

> tee [OPTION]... [FILE]..

### DESCRIPTION

Copy standard input to each FILE, and also to standard output.

* -a, --append
  * append to the given FILEs, do not overwrite
* -i, --ignore-interrupts
  * ignore interrupt signals
* --help display this help and exit
* --version
  * output version information and exit
  
```bash
ansible-playbook job-jenkins.yml -e "app_name"="test-app" -e "base64_encoded_adhoc_cmd"="justtesting==" -v | tee -a output-test-app.log
```