package main

import "fmt"

type vertex struct {
	x, y int
}

func func1() {
	fmt.Println("I am func1")
}

func (v1 vertex) abs() int {
	return v1.x * v1.y
}

func main() {
	v := vertex{2, 3}
	fmt.Println(v.abs())
}
