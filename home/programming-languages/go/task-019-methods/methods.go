package main

import "fmt"

type vertex struct {
	x, y int
}

func func1() {
	fmt.Println("I am func1")
}

// A method is a function with a special receiver argument.
// The receiver appears in its own argument list between the func keyword and the method name.
// In this example, the Abs method has a receiver of type Vertex named v.
func (v1 vertex) abs() int {
	return v1.x * v1.y
}

// Remember: a method is just a function with a receiver argument.
// Here's Abs written as a regular function with no change in functionality.
func abs(v2 vertex) int {
	return v2.x * v2.y
}

// Pointer receivers
func (v *vertex) mPointerReceiver(i int) {
	v.x = v.x * i
	v.y = v.y * i
}

func main() {
	v := vertex{2, 3}
	fmt.Println(v.abs())
	fmt.Println(abs(v))

	fmt.Println(v)
	v.mPointerReceiver(2)
	fmt.Println(v)
}
