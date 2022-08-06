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


func send(c chan int) {
	fmt.Println("\ninside send()")
	for i := 0; i<10; i++ {
		c <- i
	}
	close(c)
}
func receive(c chan int) {
	fmt.Println("\ninside receive()")
	for v := range c {
		fmt.Println(v)
	}
}