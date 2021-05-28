package main

import (
	"fmt"
	"runtime"
	"sync"
)

func main() {
	fmt.Println("CPUs ", runtime.NumCPU())
	fmt.Println("GoRoutines", runtime.NumGoroutine())

	counter := 0
	var wg sync.WaitGroup
	const gs = 10
	wg.Add(gs)
	var mu sync.Mutex
	for i := 0; i < gs; i++ {
		go func() {
			mu.Lock()
			v := counter
			// allow something else to run
			runtime.Gosched()
			v++ 
			counter++
			fmt.Println("Go routine " , runtime.NumGoroutine())
			mu.Unlock()
			wg.Done()
		}()
	}

	wg.Wait()
	fmt.Println("CPUs ", runtime.NumCPU())
	fmt.Println("GoRoutines", runtime.NumGoroutine())
	fmt.Print("Counter" , counter)
}