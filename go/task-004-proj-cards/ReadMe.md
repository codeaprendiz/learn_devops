
Run the following command

```bash
$ go run main.go deck.go
0 Ace of Diamonds
1 Four of Clubs
2 Four of Diamonds
3 Two of Hearts
4 Four of Hearts
5 Ace of Spades
6 Two of Clubs
7 Three of Clubs
8 Two of Diamonds
9 Three of Hearts
10 Three of Spades
11 Ace of Clubs
12 Three of Diamonds
13 Four of Spades
14 Two of Spades
15 Ace of Hearts
```

Running the tests

```bash
$ go mod init deck_test.go
go: creating new go.mod: module deck_test.go
go: to add module requirements and sums:
        go mod tidy

$ go test               
PASS
ok      deck_test.go    0.398s
```