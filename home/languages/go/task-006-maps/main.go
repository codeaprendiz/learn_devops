package main

import "fmt"

func main() {
	colors := map[string]string{
		"red":   "#ff0000",
		"green": "#4bf745",
		"white": "#ffffff",
	}

	colors["yellow"] = "laksjdf"
	delete(colors, "yellow")

	printMap(colors)

	m := map[string]int {
		"James" : 1,
		"Falcon" : 2,
	}

	v, ok := m["fakeKey"]
	fmt.Println(v)
	fmt.Println(ok)

	if _, ok := m["James"]; ok {
		fmt.Println("James key is present")
	}

	m["Todd"]=3

	for k,v := range m {
		fmt.Println(k,v)
	}

	delete(m,"Todd")

	fmt.Println("Map after deleting Todd" , m)
}

func printMap(c map[string]string) {
	for color, hex := range c {
		fmt.Println("Hex code for", color, "is", hex)
	}
}