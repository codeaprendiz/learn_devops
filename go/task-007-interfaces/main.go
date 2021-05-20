package main

import "fmt"

type bot interface {
	getGreeting() string
}

type englishBot struct{}
type spanishBot struct{}


func printGreeting(b bot) {
	fmt.Println(b.getGreeting())
}

func (englishBot) getGreeting() string {
	// VERY custom logic for generating an english greeting
	return "Hi there!"
}

func (spanishBot) getGreeting() string {
	return "Hola!"
}

type human interface {
	speak()
}

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
	fmt.Println("I am ", s.first, s.last, " and ldk is " , s.ltk, " ----------> func(s secretAgent) speak() called")
}

func (p person) speak() {
	fmt.Println("I am ", p.first, p.last, " ----------> func(p person) speak() called")
}


func bar(h human) {
	fmt.Println("I was passed into bar", h)
}



func main() {
	eb := englishBot{}
	sb := spanishBot{}

	printGreeting(eb)
	printGreeting(sb)

	sa1 := secretAgent{
		person: person {
			"James",
			"Bond",
		},
		ltk: true,
	}

	p1 := person {
		"Dr",
		"Who",
	}

	bar(sa1)
	bar(p1)

	checkType(p1)
	checkType(sa1)

}

func checkType(h human) {
	switch h.(type) {
	case person:
		fmt.Println("I am person")
	case secretAgent:
		fmt.Println("I am secret agent")
	default: 
		fmt.Println("I am default")	
	}
}

