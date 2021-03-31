var fs = require("fs");

fs.readFile('callback.js', function (err, data) {
    if (err) {
        console.log(err.stack);
        return;
    }
    console.log(data.toString());
});
console.log("Program Ended");
