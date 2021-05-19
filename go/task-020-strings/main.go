package main

import "fmt"

func main() {
	s := "hello world"
	fmt.Println(s)
	fmt.Printf("%T\n",s)

	bs := []byte(s)
	fmt.Println(bs)
	fmt.Printf("\n%T",bs)
}