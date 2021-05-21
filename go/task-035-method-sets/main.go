package main

import (
	"fmt"
	"math"
)

type circle struct {
	radius float64
}

type shape interface {
	area() float64
}

// its a non pointer receiver and it will work with both pointer and non pointer
func (c circle) area() float64 {
	return math.Pi * c.radius * c.radius
}


func info(s shape) {
	fmt.Println("area " , s.area())
}

func main() {
	c := circle{5}
	// working with non pointer
	info(c)
	// working with pointer 
	info(&c)
}