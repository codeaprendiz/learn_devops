package main

import (
	"fmt"
	"os"
	"io"
)
func main() {
	fmt.Println("Hello World")
	fmt.Fprintln(os.Stdout, "Hello World")
	io.WriteString(os.Stdout, "Hello World")

}