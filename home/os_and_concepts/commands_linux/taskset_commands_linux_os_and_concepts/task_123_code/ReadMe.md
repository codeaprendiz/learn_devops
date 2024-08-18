# code

Visual Studio Code -- cli

## Examples

### Install Extensions

```bash
code --install-extension github.github-vscode-theme --profile personal
```

Install from one PC to another. You can take the output on first PC and run it on the second PC.

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

### List Installed Extensions

Personal Profile

```bash
code --list-extensions --profile personal
```

Default Profile

```bash
code --list-extensions --show-versions
```

### Open project with specific profile

```bash
code ~/workspace/codeaprendiz/learn_devops --profile Default
```

### Uninstall Extensions

```bash
code --uninstall-extension github.github-vscode-theme --profile personal
```