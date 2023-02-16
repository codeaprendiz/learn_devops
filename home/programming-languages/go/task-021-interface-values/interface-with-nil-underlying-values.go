package main

import "fmt"

type Shape interface {
	Area()
}

type Square struct {
	side int
}

func (sq *Square) Area() {
	if sq == nil {
		fmt.Println("Nil")
		return
	}
	fmt.Println("Area : ", sq.side*sq.side)
}

func describe(i Shape) {
	fmt.Printf("(%v, %T)\n", i, i)
}

func main() {
	sq := Square{side: 2}
	sq.Area()

	var shape Shape
	var sq_pointer *Square
	shape = sq_pointer
	describe(shape)
	shape.Area()

	shape = &Square{2}
	describe(shape)
	shape.Area()
}
