[Doc](https://www.tutorialspoint.com/nodejs/nodejs_event_loop.htm)

- Event

```bash
$ node -v      
v15.11.0

$ node event.js            
connection succesful.
data received succesfully.
Program Ended.
```

- Callback

```bash
$ node callback.js
Program Ended
var fs = require("fs");

fs.readFile('callback.js', function (err, data) {
    if (err) {
        console.log(err.stack);
        return;
    }
    console.log(data.toString());
});
console.log("Program Ended");
```