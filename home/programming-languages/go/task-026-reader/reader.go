package main

import (
	"fmt"
	"io"
	"strings"
)

func main() {
	//  a string "Hello, Reader!" is created using the strings.NewReader function, which returns a new Reader that reads from the provided string.
	r := strings.NewReader("Hello World.")
	// a byte slice b of length 8 is created using the make function.
	b := make([]byte, 8)
	/*
		A for loop is used to repeatedly call the Read method on the Reader and read up to 8
		bytes of data into the byte slice b. The Read method returns the number of bytes
		read and an error value. The code then prints the number of bytes read,
		the error value, and the contents of the byte slice b.
		The loop continues until the Read method returns an io.EOF error, which indicates that there is no more data to be read from the Reader.
	*/
	for {
		n, err := r.Read(b)
		// When %v is used to print a slice or an array, it will print the values of all elements in the slice or array. In the case of the b variable, which is a byte slice, %v will print a comma-separated list of the byte values in the slice.
		// Overall, %v is a versatile format verb in Go, as it can be used to print values of many different types in a readable way.
		fmt.Printf("n = %v, err = %v, b = %v\n", n, err, b)

		// The %q format verb is used to print a single-quoted string literal safely escaped with Go syntax. It replaces any non-printable or non-ASCII bytes with escape sequences, such as \t for tab and \n for newline
		// The b[:n] expression is a slice expression that creates a new slice that includes only the first n elements of the b slice. In other words, it extracts the portion of the slice that was actually read in the most recent call to the Read method.
		fmt.Printf("b[:n] = %q\n", b[:n])

		if err == io.EOF {
			break
		}
	}

}
