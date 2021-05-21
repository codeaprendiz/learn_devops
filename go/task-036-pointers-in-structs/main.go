package main

import "fmt"

type person struct {
	first string
	last string
}

func (p *person) changeName() {
	(*p).first = "new name"
}

func main() {
	p1 := person {
		first: "firstname",
		last: "lastname",
	}
	fmt.Println("Before changing name ", p1)
	p1.changeName()

	fmt.Println("After changing name", p1)

}