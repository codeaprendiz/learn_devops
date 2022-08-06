package main

import (
	"fmt"
	"github.com/codeaprendiz/hello/morestrings"
	"github.com/google/go-cmp/cmp"
)

func main() {
	fmt.Println("Hello, world.")
	fmt.Println(morestrings.ReverseRunes("dlrow, olleh"))
	fmt.Println(cmp.Diff("Hello World", "Hello Go"))
}