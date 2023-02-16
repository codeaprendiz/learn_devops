package main

import "fmt"

type Person struct {
	Name string
	Age  int
}

// Pointer receiver
/*
Note that the SetAge method has a pointer receiver (*Person) rather than a value receiver (Person).
This means that when we call this method, we pass in a pointer to the Person struct, rather than a copy of the struct itself. This allows the method to modify the original Person struct.
*/
func (p *Person) SetAge(age int) {
	p.Age = age
}

func (p Person) SetAge_v2(age int) {
	p.Age = age
}

func main() {
	person := Person{Name: "john", Age: 34}
	fmt.Println(person)

	person.SetAge(23)
	fmt.Println(person)

	person.SetAge_v2(34) // should not have any effect
	fmt.Println(person)
}
