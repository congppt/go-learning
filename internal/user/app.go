package user

import "github.com/gin-gonic/gin"

func Startup(port string) error {
	engine := gin.Default()
	
	return engine.Run(port)
}