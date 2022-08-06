package main

import "fmt"

type person struct {
	first string
	last string
}

type secretAgent struct {
	person
	ltk bool
}

// func (r receiver) identifier(parameters) (return(s)) { code }

func (s secretAgent) speak() {
	fmt.Println("I am ", s.first, s.last, " and ldk is " , s.ltk)
}

func main() {
	sa1 := secretAgent{
		person: person {
			"James",
			"Bond",
		},
		ltk: true,
	}

	fmt.Println(sa1)
	sa1.speak()
	
}

