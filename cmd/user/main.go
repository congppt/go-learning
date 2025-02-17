package main

import "congppt/sample-api/internal/user"

func Main(){
	err := user.Startup(":8080")
	if err != nil {
		panic(err)
	}
}