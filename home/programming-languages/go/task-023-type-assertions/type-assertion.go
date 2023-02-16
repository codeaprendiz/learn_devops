package main

// https://go.dev/tour/methods/15

import "fmt"

var m_interface interface{} = "hello"

func main() {
	s, ok := m_interface.(string)
	fmt.Println(s, ok)

	s2, ok := m_interface.(float64)
	fmt.Println(s2, ok)
}
