package main

import "fmt"

type mInterface interface {
	mFunction()
}

type mStruct struct {
	mString string
}

// The following method means that mStruct implements mInterface
func (mStructObj mStruct) mFunction() {
	fmt.Println(mStructObj.mString)
}

func main() {
	var iinterface mInterface = mStruct{"hello"}
	iinterface.mFunction()
}
