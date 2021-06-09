package main

// import "fmt"

func main() {
	// var card string = "Ace of Spades"
	cards := newDeck()
	cards.shuffle()
	cards.print()



}


