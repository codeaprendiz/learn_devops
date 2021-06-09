package main

import "fmt"

func main() {
	c := make(chan int)
	cr := make(<-chan int) // receive from  chan int
	cs := make(chan<- int) // chan will receive int OR send to chan int

	fmt.Printf("\nc \t%T : ", c)
	fmt.Printf("\ncr \t%T : ", cr)
	fmt.Printf("\ncs \t%T", cs)


	go send(c)

	receive(c)

	fmt.Println("\nAbout to exit")
}


func send(c chan <- int) {
	fmt.Println("\ninside send()")
	c <- 43
}
func receive(c <- chan int) {
	fmt.Println("\ninside receive()")
	fmt.Println(<-c)
}