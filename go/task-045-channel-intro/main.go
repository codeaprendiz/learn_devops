package main

import "fmt"

func main() {
    c := make (chan int, 1)

    go func() {
        c <- 42
    }()

    fmt.Println(<-c)


    c <- 43

    fmt.Println(<-c)
}