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


/*
Pointer receivers
methods with pointer receivers take either a value or a pointer as the receiver when they are called
        var v Vertex
        v.Scale(5)  // OK
        p := &v
        p.Scale(10) // OK
*/

func (v *vertex) mPointerReceiver(i int) {
	v.x = v.x * i
	v.y = v.y * i
}

/*
you might notice that functions with a pointer argument must take a pointer:
        var v Vertex
        ScaleFunc(v, 5)  // Compile error!
        ScaleFunc(&v, 5) // OK
*/
func mPointerArgument(v *vertex, i int) {
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

	v1 := vertex{23,34}
	fmt.Println(v1)
	v1.mPointerReceiver(2)
	fmt.Println(v1)
	mPointerArgument(&v1,2)
	fmt.Println(v1)
	// mPointerArgument(v1,2) // Compile time error : cannot use v1 (variable of type vertex) as type *vertex in argument to mPointerArgument

	p := &vertex{6,7}
	fmt.Println(*p)
	p.mPointerReceiver(2)
	fmt.Println(*p)
	mPointerArgument(p,2)
	fmt.Println(*p)

}
