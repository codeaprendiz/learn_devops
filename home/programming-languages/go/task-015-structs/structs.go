package main

import "fmt"

type vertex struct {
	x int
	y int
}

func main() {
	fmt.Println(vertex{1, 2})

	v := vertex{2, 3}

	// accessing fields
	fmt.Println("v.x = ", v.x)
	fmt.Println("v.y =", v.y)

	// To access the field X of a struct when we
	// have the struct pointer p we could write (*p).X.
	// However, that notation is cumbersome, so the language permits us instead to write just p.X, without the explicit dereference.
	p := &v
	fmt.Println("p.x = ", p.x)
	fmt.Println("p.y = ", p.y)

	var (
		v1 = vertex{x: 11, y: 12}
		v2 = vertex{x: 11}   // y:0 is implicit
		v3 = vertex{}        // x:0 and y:0 is implicit
		p1 = &vertex{21, 23} // has the type of *vertex
	)

	fmt.Println(v1, v2, v3, *p1, p1)
}
