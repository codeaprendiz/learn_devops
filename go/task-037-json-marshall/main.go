package main

import (
	"fmt"
	"encoding/json"
)

type person struct {
	First string
	Last string
	Age int
}

func main() {
	p1 := person {
		First: "James",
		Last: "Bond",
		Age: 23,
	}

	p2 := person {
		First: "Shinshan",
		Last: "Kazama",
		Age: 5,
	}

	sliceOfPeople := []person {
		p1,
		p2,
	}

	fmt.Println(sliceOfPeople)

	bs, err := json.Marshal(sliceOfPeople)

	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(string(bs))
}