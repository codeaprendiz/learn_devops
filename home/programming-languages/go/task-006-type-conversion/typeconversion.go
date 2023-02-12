package main

import "fmt"

func main() {
	// Converting Between Integer Types
	var small int16
	var big int64
	big = 34

	small = int16(big)
	fmt.Printf("the type of small is %T\n", small)

	// Converting Integers to Floats
	var a int64
	a = 32
	var b float64 = float64(a)
	fmt.Printf("The type of b is %T\n and it's value is %.2f\n", b, b)
}
