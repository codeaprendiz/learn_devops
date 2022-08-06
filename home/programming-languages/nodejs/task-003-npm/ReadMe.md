[Doc](https://www.tutorialspoint.com/nodejs/nodejs_npm.htm

- Check the npm version

```bash
$ npm --version
7.6.0
```

- Install a module using npm

```bash
$ npm install express
added 50 packages, and audited 51 packages in 5s

$ ls
ReadMe.md         node_modules      package-lock.json package.json

$ ls -ltrh node_modules | wc -l                     
      50
```

- Once installed, we can use this module in our js file using

```npm
var express = require('express');
```

- Installing a package globally

```bash
$ npm install express -g
```

- Listing packages locally and globally

```bash
$ npm ls
/Users/ankitsinghrathi/Ankit/workspace/devops-essentials/nodejs/task-003-npm
└── (empty)

$ npm ls -g
/usr/local/lib
└── npm@7.6.0
```

- Uninstalling a package 

```bash
$ npm uninstall express
```

