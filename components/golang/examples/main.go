package main

import (
	"fmt"

	chef_licensing "github.com/ahasunos/chef-licensing/components/golang/pkg"
)

func main() {
	fmt.Println(chef_licensing.FetchAndPersist())
}
