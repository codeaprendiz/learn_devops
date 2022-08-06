package main

import "fmt"

func main() {
	x := 1
	for x < 10 {
		fmt.Println(" x is " , x)
		x++
	}

	y := 1
	for {
		if y > 5 {
			break
		}
		fmt.Println("y is " , y)
		y++
	}

	for i:=0; i<10; i++ {
		fmt.Println("i is " , i)
	}
}