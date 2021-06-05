- Run the following

```bash
$ go run main.go --race
No match
Even channel  0
No match
Odd channel  1
Even channel  2
No match
No match
No match
No match
No match
No match
Odd channel  3
Even channel  4
No match
No match
No match
No match
No match
No match
No match
No match
Odd channel  5
Even channel  6
No match
No match
No match
Odd channel  7
No match
Even channel  8
No match
No match
No match
No match
No match
No match
No match
Odd channel  9
Odd channel  0
Quit channel  1

$ go run main.go --race
No match
Even channel  0
No match
No match
No match
No match
No match
No match
No match
No match
No match
No match
No match
No match
Odd channel  1
Even channel  2
No match
No match
No match
No match
No match
Odd channel  3
Even channel  4
No match
Odd channel  5
No match
No match
No match
No match
Even channel  6
No match
Odd channel  7
No match
No match
No match
No match
No match
No match
No match
No match
No match
No match
Even channel  8
No match
No match
Odd channel  9
Quit channel  1

```