package main

import "fmt"

func main() {
	foo()
	bar("Test")

	s := woo("woo's argument")

	fmt.Println(s)

	str, bl := multiReturnFunc()
	fmt.Println(str,bl)

	anyNumberOfArgs(1,2,3,4,45)

	// Unfurling a slice

	x := []int{1,2,3,4,5,6,76,8}
	
	anyNumberOfArgs(x...)

	// Anonymous functions
	func(x int) {
		fmt.Println("I am anonymous function and called with argument " , x )
	}(23)

}

func foo() {
	fmt.Println("I am foo")
}

func bar(s string) {
	fmt.Println("I am bar taking argument " , s)
}

func woo(s string) string {
	return fmt.Sprint("I am in woo ", s)
}

func multiReturnFunc() (string,bool) {
	return "i am string", true
}

func anyNumberOfArgs(x ...int) {
	fmt.Println(x)
	fmt.Printf("\n%T\n",x)
}