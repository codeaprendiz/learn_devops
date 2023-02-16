package main

import "fmt"

func do(m_interface interface{}) {
	switch m_interface.(type) {
	case int:
		fmt.Println("I am int")
	case string:
		fmt.Println("I am string")
	default:
		fmt.Println("Could not determine")
	}
}

func main() {
	do(31)
	do("hello")
	do(true)
}
