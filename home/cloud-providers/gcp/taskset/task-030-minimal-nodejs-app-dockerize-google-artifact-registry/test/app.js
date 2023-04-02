/*
This is a Node.js server that listens for HTTP requests on port 80 (the standard HTTP port)
and responds with a "Hello World" message in plain text format
*/

// imports the Node.js http module, which provides functionality for creating an HTTP server.
const http = require('http');

// defines two constants, hostname and port, which specify the address and port number that the server will listen on
const hostname = '0.0.0.0';
const port = 80;

// creates an HTTP server using the http.createServer() method, which takes a callback
// function as its argument.
// This callback function is called whenever a client makes a request to the server.
const server = http.createServer((req, res) => {
    // The callback function sets the HTTP response status code to 200 (OK),
    res.statusCode = 200;
    //sets the Content-Type header to text/plain,
    res.setHeader('Content-Type', 'text/plain');
    // and sends the "Hello World" message as the response body.
    res.end('Hello World\n');
});

// The server.listen() method is called to start the server listening on the
// specified hostname and port number. It also takes a callback function that
// is called once the server starts listening.
// This callback function just logs a message to the console to indicate that the server is running.
server.listen(port, hostname, () => {
    console.log('Server running at http://%s:%s/', hostname, port);
});

// Finally, a SIGINT event listener is added to the process object.
// This listener is triggered when the user presses Ctrl-C to stop the server.
// When the listener is triggered, it logs a message to the console and exits the process.
process.on('SIGINT', function() {
    console.log('Caught interrupt signal and will exit');
    process.exit();
});
