package main

import (
	"fmt"
	"math"
)

// In Go, a name is exported if it begins with a capital letter

func main() {
	// will give error
	// fmt.Println(math.pi)
	// is correct
	fmt.Println(math.Pi)
}
