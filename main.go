package main

import (
	"fmt"
	"log"
	"os"

	"time"

	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/plumbing/object"
	"github.com/go-git/go-git/v5/plumbing/transport/http"
)

func check_error(e error) {
	if e != nil {
		log.Println(e)
	}
}

func main() {

	// Get the current repo directory
	git_dir, err := os.Getwd()
	check_error(err)

	// Opens an already existing repository
	r, err := git.PlainOpen(git_dir)
	check_error(err)

	w, err := r.Worktree()
	check_error(err)

	// Adds the new file to the staging area
	_, err = w.Add(".")
	check_error(err)

	// We can verify the current status of the worktree using the method Status
	status, err := w.Status()
	check_error(err)
	fmt.Println(status)

	// Commits the current staging area to the repository
	commit, err := w.Commit("example go-git commit", &git.CommitOptions{
		Author: &object.Signature{
			Name:  "John Doe",
			Email: "john@doe.org",
			When:  time.Now(),
		},
	})
	check_error(err)

	// Prints the current HEAD to verify that all worked well
	obj, err := r.CommitObject(commit)
	check_error(err)

	fmt.Println(obj)

	// Push using default options
	err = r.Push(&git.PushOptions{
		Auth: &http.BasicAuth{Username: "artemkupryuhin", Password: "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"},
	})
	check_error(err)
}
