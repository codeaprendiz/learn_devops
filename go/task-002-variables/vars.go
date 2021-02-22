package main

import "fmt"

func main() {
// Static Declaration - You tell the compiler
   var var_x float64
   var_x = 20.0
   fmt.Println(var_x)
   fmt.Printf("var_x is of type %T\n", var_x)

// Dynamic Declaration - Let the compiler do the thinking
   var_y := 42
   fmt.Println(var_y)
   fmt.Printf("var_y is of type %T\n", var_y)

// Mivxed
   var d, e, f = 3, 4, "foo"
   fmt.Println(d)
   fmt.Println(e)
   fmt.Println(f)
   fmt.Printf("d is of type %T\n", d)
   fmt.Printf("e is of type %T\n", e)
   fmt.Printf("f is of type %T\n", f)
}