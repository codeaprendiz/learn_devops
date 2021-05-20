package main
 
import "fmt"

func main() {
	defer foo()
	bar()
}

func foo() {
	fmt.Println("I am foo")
}

func bar() {
	fmt.Println("I am bar")
}