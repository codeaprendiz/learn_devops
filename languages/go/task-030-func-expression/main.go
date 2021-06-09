package main

import "fmt"

func main() {
	f := func(x int) {
		fmt.Println("I am anonymous function that was passed with argument", x)
	}

	f(4)

	newfunction := bar()

	fmt.Println("The function call of the function which was returned is " , newfunction())
	fmt.Printf("The type of the variable newfunction is %T", newfunction )
}

func bar() func() int{
	return func() int {
		return 45
	}
}