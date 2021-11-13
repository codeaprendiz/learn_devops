var fs = require("fs");


var callback = function () {
console.log("10 seconds later...");
};

console.log("Calling setTimeout")
setTimeout(callback, 10000);  
console.log("Control after setTimeout called")



// Another example

var callback = function (err, data) {
    if (err) return console.error(err);
    console.log(data);
  };

console.log("Control before reading the file")
fs.readFile('test.txt', callback);
console.log("Control after reading the file")
