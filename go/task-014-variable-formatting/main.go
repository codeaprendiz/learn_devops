package main

import "fmt"

var a=10

var i int = 34
var j string = "I am str"
var k bool = true

func main() {
	for i := 60; i < 70; i++ {
		fmt.Printf("%d \t %b \t %x \t %q \n", i, i, i, i)
	}

	fmt.Println("Type of a is ", a)
	fmt.Printf("Type of a is %T ", a)
	fmt.Printf("\nBinary value a is %b ", a)

	// Use Sprint
	s := fmt.Sprintf("\n%v\t%v\t%v",i,j,k)
	fmt.Println(s)
}
