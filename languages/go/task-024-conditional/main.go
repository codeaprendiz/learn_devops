package main

import "fmt"

func main() {
	if true {
		fmt.Println("This is always true")
	}

	if 2==2 {
		fmt.Println("is 2==2")
	} 

	x := 2
	
	if x==1 {
		fmt.Println("x==1 is true", x)
	} else if x == 3 {
		fmt.Println("x==3 is true", x)
	} else {
		fmt.Println("None was true")
	}


	switch {
	case false: 
		fmt.Println("Not print")
	case 2==2:
		fmt.Println("2==2")
		// fallthrough implies that the control should follow with the next case
		fallthrough
	case 3==3:
		fmt.Println("3==3")
	default:
		fmt.Println("This is default")
	}


	switch "TEST" {
		case "one": 
			fmt.Println("one")
		case "two":
			fmt.Println("two")
		case "TEST":
			fmt.Println("TEST")
		default:
			fmt.Println("This should default")
		}
}