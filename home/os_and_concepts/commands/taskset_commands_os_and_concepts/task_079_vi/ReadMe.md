# vi

<br>

## NAME

vim - Vi IMproved, a programmers text editor

<br>

## DESCRIPTION

Vim is a text editor that is upwards compatible to Vi.  It can be used to edit all kinds of plain text.  It is especially useful for editing programs.

<br>

## COMMANDS

<br>

## Examples

To search and replace globally in a file

```bash
:%s/search/replace/g
```

How to paste yaml in vi

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

---

- Copy single character on which cursor rests [vi.stackexchange.com](https://vi.stackexchange.com/questions/5806/how-can-i-yank-copy-the-single-character-on-which-the-cursor-rests)

```bash
# yiw = yank in current word
# yaw = yank all word (includes a trailing space)
# yy = yank the current line
# 3yy = yank three lines starting at the current one
# yap = yank all paragraph (includes trailing newline)

# To copy two characters from where the cursor is residing
2yl
# let's say it copies *a
# To paste at the begining of the line press
(capital)P
```
