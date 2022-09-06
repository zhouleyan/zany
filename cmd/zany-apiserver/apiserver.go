package main

import (
	"log"
	_ "time/tzdata"
	"zly.io/zany/cmd/zany-apiserver/app"
)

func main() {
	command := app.NewAPIServerCommand()

	if err := command.Execute(); err != nil {
		log.Fatalln(err)
	}
	//os.Exit(1)
}
