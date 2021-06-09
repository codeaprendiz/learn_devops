package main

import "fmt"

func main() {
	s := "hello world"
	fmt.Println(s)
	fmt.Printf("%T\n",s)

	bs := []byte(s)
	fmt.Println(bs)
	fmt.Printf("\n%T",bs)

	// UTF-8 values
	for i := 0; i<len(s); i++ {
		fmt.Printf("%#U", s[i])
	}

	fmt.Println()


}