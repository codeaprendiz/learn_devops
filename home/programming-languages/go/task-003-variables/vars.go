package main

import "fmt"

var mglobal = "global"

func main() {

	// Understanding Variables

	i := 1032049348
	fmt.Println(i)

	x := 34 + 34
	fmt.Println(x)

	s := "hello"
	fmt.Println(s)

	y := 34.34
	fmt.Println(y)

	t := 3 > 4
	fmt.Println(t)

	array := [2]string{"one", "two"}
	fmt.Println(array)

	slice := []string{"one", "two", "three"}
	fmt.Println(slice)

	mmap := map[string]string{"one": "a", "two": "b"}
	fmt.Println(mmap)

	// Declaring Variables
	var it int
	fmt.Println(it)

	// Zero Values
	var a int
	var b string
	var c float64
	var d bool
	fmt.Println(a, b, c, d)
	// To print data types and var values
	fmt.Printf("var value of a of type %T is %+v\n", a, a)
	fmt.Printf("var value of a of type %T is %+v\n", b, b)
	fmt.Printf("var value of a of type %T is %+v\n", c, c)
	fmt.Printf("var value of a of type %T is %+v\n", d, d)

	// Reassigning Variables
	i = 10
	fmt.Println(i)

	// Multiple Assignment
	g, h := 2, 3
	fmt.Println(g, h)

	fmt.Println(mglobal)

	mfunc1()

	// Constants

	const shak = "shark1"
	fmt.Println(shak)

}

func mfunc1() {
	mlocalvar := "mlocalvar"
	fmt.Println(mlocalvar)
}
