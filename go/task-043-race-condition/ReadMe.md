- Run the following

```bash
$ go run main.go
CPUs  16
GoRoutines 1
Go routine  11
Go routine  10
Go routine  9
Go routine  8
Go routine  7
Go routine  6
Go routine  5
Go routine  4
Go routine  3
Go routine  11
CPUs  16
GoRoutines 1
Counter10

$ go run main.go
CPUs  16
GoRoutines 1
Go routine  9
Go routine  8
Go routine  7
Go routine  8
Go routine  7
Go routine  6
Go routine  5
Go routine  4
Go routine  7
Go routine  5
CPUs  16
GoRoutines 1
Counter10

$ go run -race main.go 
CPUs  16
GoRoutines 1
Go routine  3
Go routine  4
==================
WARNING: DATA RACE
Read at 0x00c00001e0c8 by goroutine 8:
  main.main.func1()
      /Users/ankitsinghrathi/Ankit/workspace/devops-essentials/go/task-043-race-condition/main.go:19 +0x3c

Previous write at 0x00c00001e0c8 by goroutine 7:
  main.main.func1()
      /Users/ankitsinghrathi/Ankit/workspace/devops-essentials/go/task-043-race-condition/main.go:23 +0x68

Goroutine 8 (running) created at:
  main.main()
      /Users/ankitsinghrathi/Ankit/workspace/devops-essentials/go/task-043-race-condition/main.go:18 +0x244

Goroutine 7 (finished) created at:
  main.main()
      /Users/ankitsinghrathi/Ankit/workspace/devops-essentials/go/task-043-race-condition/main.go:18 +0x244
==================
Go routine  4
Go routine  4
Go routine  5
Go routine  4
Go routine  5
Go routine  2
Go routine  3
Go routine  2
CPUs  16
GoRoutines 1
Counter10Found 1 data race(s)
exit status 66
```