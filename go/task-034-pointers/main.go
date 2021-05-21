package main

import "fmt"

func main() {
	x := 45
	fmt.Println("The value of x is ", x)
	fmt.Println("The address of x is ", &x)

	changeValue(&x)

	fmt.Println("The new value of x is ", x)


}

func changeValue(y *int) {
	fmt.Println("The address of y is " , y)
	fmt.Println("The value stored at that address is " , *y)
	*y = 49

	fmt.Println("The new value at y is " , *y)
}