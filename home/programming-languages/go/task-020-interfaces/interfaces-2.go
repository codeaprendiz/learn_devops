package main

import "fmt"

type Shape interface {
	Area() int64
}

type Rectangle struct {
	len int64
	br  int64
}

// Define a method named Area for the Rectangle struct
func (rectangle Rectangle) Area() int64 {
	return rectangle.len * rectangle.br
}

func main() {
	// Create a rectable object
	rectangle := Rectangle{2, 4}

	// Declate a variable of type shape and assign rectangle object to it
	var shape Shape = rectangle
	area := shape.Area()

	fmt.Println("The area of rectangle is : ", area)
}
