buf = new Buffer.alloc(26);
for (var i = 0 ; i < 26 ; i++) {
    buf[i] = i + 97;
}

console.log( buf.toString('ascii'));       // outputs: abcdefghijklmnopqrstuvwxyz
console.log( buf.toString('ascii',0,5));   // outputs: abcde
console.log( buf.toString('utf8',0,5));    // outputs: abcde
console.log( buf.toString(undefined,0,5)); // encoding defaults to 'utf8', outputs abcde


// Convert buffer to JSON

console.log(buf.toJSON())

// Concatenate buffers

var buffer1 = new Buffer.from('This ');
var buffer2 = new Buffer.from('is good learning');
var buffer3 = Buffer.concat([buffer1,buffer2]);

console.log("buffer3 content: " + buffer3.toString());


