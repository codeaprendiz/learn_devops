# Default Select

[https://go.dev/tour/concurrency/6](https://go.dev/tour/concurrency/6)

## Explanation

```bash
This is a Go program that uses the time package to print "tick." every 100 milliseconds, and then print "BOOM!" after 500 milliseconds. The program uses a select statement to read from two channels: a channel created using the time.Tick function, which returns a channel that sends a value after a specified interval, and a channel created using the time.After function, which returns a channel that sends a value after a specified duration has elapsed.

The default case in the select statement is executed when none of the other cases are ready to be executed. In this case, it prints a dot and waits for 50 milliseconds before trying to execute the other cases again.

When the tick channel sends a value, the case <-tick is executed, and the program prints "tick." to the console.

When the boom channel sends a value, the case <-boom is executed, and the program prints "BOOM!" to the console before returning from the main function.

The program runs indefinitely until the boom channel sends a value or the program is interrupted manually. When the program is interrupted, it exits immediately, even if the tick channel has not sent a value recently.
```


```bash
go run default-selection.go
    .
    .
tick.
    .
    .
tick.
    .
    .
tick.
    .
    .
tick.
    .
    .
BOOM!
```