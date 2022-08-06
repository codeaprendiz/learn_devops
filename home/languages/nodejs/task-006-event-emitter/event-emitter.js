const EventEmitter = require('events');

class MyEmitter extends EventEmitter {}

const myEmitter = new MyEmitter();
myEmitter.on('event', () => {
    console.log('an event occurred!');
});
myEmitter.emit('event');


var listner1 = function listner1() {
    console.log('listner1 executed.');
}

// listener #2
var listner2 = function listner2() {
    console.log('listner2 executed.');
}


// Bind the connection event with the listner1 function
myEmitter.addListener('connection', listner1);

// Bind the connection event with the listner2 function
myEmitter.on('connection', listner2);

var eventListeners = myEmitter.listenerCount('connection');


console.log(eventListeners + " Listner(s) listening to connection event");

// Fire the connection event
myEmitter.emit('connection');

// Remove the binding of listner1 function
myEmitter.removeListener('connection', listner1);
console.log("Listner1 will not listen now.");

// Fire the connection event
myEmitter.emit('connection');

eventListeners = myEmitter.listenerCount('connection');
console.log(eventListeners + " Listner(s) listening to connection event");

console.log("Program Ended.");