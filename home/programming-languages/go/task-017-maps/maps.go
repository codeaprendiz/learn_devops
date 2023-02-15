package main

import "fmt"

type vertex struct {
	lat, long int
}

var mmap map[string]vertex

func main() {
	mmap = make(map[string]vertex)
	mmap["Bell Labs"] = vertex{12, 34}

	fmt.Println(mmap["Bell Labs"])

	var mmap2 = map[string]vertex{
		"key1": {
			34, 45,
		},
		"key2": {
			45, 56,
		},
	}

	fmt.Println(mmap2)

	// mutating maps
	mmap3 := make(map[string]int)

	mmap3["key1"] = 23
	fmt.Println("The value is ", mmap3["key1"])

	mmap3["key2"] = 25
	fmt.Println("The value is ", mmap3["key2"])

	mmap3["key3"] = 254
	fmt.Println("The value is ", mmap3["key3"])

	fmt.Println("Map : ", mmap3)

	// delete element with key2
	delete(mmap3, "key2")
	fmt.Println("Map : ", mmap3)

}
