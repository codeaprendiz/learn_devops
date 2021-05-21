package main

import (
	"fmt"
	"encoding/json"
)

// https://mholt.github.io/json-to-go/
// JSON :       [{"First":"James","Last":"Bond","Age":23},{"First":"Shinshan","Last":"Kazama","Age":5}]
type person struct {
	First string `json:"First"`
	Last string `json:"Last"`
	Age int `json:"Age"`
}

func main() {
	s := `[{"First":"James","Last":"Bond","Age":23},{"First":"Shinshan","Last":"Kazama","Age":5}]`
	bs := []byte(s)
	fmt.Println(s)
	fmt.Printf("%T\n", s)
	fmt.Println(bs)
	fmt.Printf("%T\n", bs)

	var people []person
	err := json.Unmarshal(bs, &people)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println("All of the data", people)
}