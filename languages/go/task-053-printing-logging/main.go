package main

import (
	"fmt"
	"log"
	"os"
)

func main() {
	_, err := os.Open("somefile")
	if err != nil {
		fmt.Println("fmt.Pritln => Error happened: ", err)
		log.Println("log.Println => Error happened: ", err)
		log.Fatal("log.Fatal => Error happened: ",err)
		log.Panic("log.Panic => Error happened: ",err)
	}
}