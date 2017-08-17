package main

import (
	"net/http"

	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {
	println("start main()")
	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Route => handler
	e.GET("/test", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!\n")
	})

	// Start server
	e.Logger.Fatal(e.Start(":80"))
	//e.Logger.Fatal(e.Start(":" + os.Getenv("HTTP_PLATFORM_PORT")))
	//e.Logger.Fatal(e.Start(":8080"))
	//e.Logger.Fatal(e.Start(":" + os.Getenv("HTTP_PLATFORM_PORT")))

}
