## vi

### NAME

vim - Vi IMproved, a programmers text editor

### SYNOPSIS

> vim [options] [file ..] 

> vim [options] - 

> vim [options] -t tag 

> vim [options] -q [errorfile] 

> ex gex view 

> gvim gview vimx evim eview 

> rvim rview rgvim rgview

### DESCRIPTION

Vim is a text editor that is upwards compatible to Vi.  It can be used to edit all kinds of plain text.  It is especially useful for editing programs.

### COMMANDS

To search and replace globally in a file

```bash
:%s/search/replace/g
```

#### How to paste yaml in vi 

- When you try to paste yaml directly

```yaml
- name: install packages
  pip:
    name: openshift==0.11.2
  tags:
    - docker-image
    - full-deploy
    - code-deploy
```

- After pasting it in vi.  0_0

```bash
- name: install packages
    pip:
                name: openshift==0.11.2
                  tags:
                              - docker-image
                                    - full-deploy
                                          - code-deploy
```

- Turn off the auto-ident when you paste code in `exec` mode [reference link](https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim)

```bash
:set paste                                                                                                                                                                                                  
```

- Now go to insert mode and paste the yaml ( you should see `-- INSERT (paste) --` at the bottom)

```yaml
- name: install packages
  pip:
    name: openshift==0.11.2
  tags:
    - docker-image
    - full-deploy
    - code-deploy
```

- You can turn it back on 