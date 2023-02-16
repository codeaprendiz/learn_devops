package main

import "fmt"

type Person struct {
	Name string
	Age  int
}

func (person Person) String() string {
	return fmt.Sprintf("(%v %v)", person.Name, person.Age)
}

func main() {
	a := Person{"John Cena", 22}
	b := Person{"Red Glass", 23}

	fmt.Println(a, b)
}
