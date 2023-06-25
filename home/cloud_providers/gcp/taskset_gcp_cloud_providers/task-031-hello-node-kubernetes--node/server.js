/*
This is a basic Node.js code that creates an HTTP server and listens for
incoming requests on port 8080. When a request is received, it responds with a HTTP
200 status code and the message "Hello World!".
*/

// we are importing the Node.js http module and defining a function called handleRequest
// which takes in two arguments, request and response. When a request is received by the server,
// this function is called to handle the request.
var http = require('http');
// Inside the handleRequest function, the response is set to return a HTTP 200
// status code using the writeHead method of the response object, and the response
// body is set to "Hello World!" using the end method of the response object.
var handleRequest = function(request, response) {
  response.writeHead(200);
  response.end("Hello World!");
}
// The http.createServer method is used to create an HTTP server and
// assign the handleRequest function as the request handler. Finally,
// the server is started by calling the listen method of the server object
// and specifying the port to listen on.
var www = http.createServer(handleRequest);
www.listen(8080);