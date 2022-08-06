package main

import "fmt"

func main() {
	even := make(chan int)
	odd := make(chan int)
	quit := make(chan int)

	// send
	go send(even, odd, quit)

	// receive
	receive(even, odd, quit)
}

func receive(e, o, q <- chan int) {
	for {
		select {
		case v := <- e:
			fmt.Println("Even channel ", v)
		case v := <- o:
			fmt.Println("Odd channel ", v)
		case v := <- q:
			fmt.Println("Quit channel ", v)
			return
		default:
			fmt.Println("No match")
		}
	}
}

func send(e, o, q chan <- int) {
	for  i:=0; i<10; i++ {
		if i % 2 == 0 {
			e <- i
		} else {
			o <- i
		}
	}
	//close(e)
	//close(o)
	q <- 1
	//close(q)
}