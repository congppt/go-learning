package main

import "congppt/sample-api/internal/post"

func Main(){
	err := post.Startup(":8080")
	if err != nil {
		panic(err)
	}
}