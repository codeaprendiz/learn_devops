package main

import "fmt"

func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	c <- sum // send sum to channel
}

func main() {
	s := []int{1, 2, 3}
	t := []int{3, 2, 1}
	c := make(chan int)
	go sum(s, c)
	go sum(t, c)
	x, y := <-c, <-c
	fmt.Println(x, y)

}
