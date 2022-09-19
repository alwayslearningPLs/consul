package main

import (
	"net/http"
	"os"
	"strconv"

	"github.com/gin-gonic/gin"
)

type User struct {
  Name       string `json:"name"`
  Surname    string `json:"surname"`
  Profession string `json:"profession"`
  Telephone  string `json:"telephone"`
}

func main() {
  r := gin.Default()

  r.GET("/users", func(c *gin.Context) {
    c.Negotiate(http.StatusOK, gin.Negotiate{
      Offered: []string{gin.MIMEJSON},
      Data: fetchData(),
    })
  })

  r.Run(":" + os.Getenv("PORT"))
}

func fetchData() []User {
  var arr = make([]User, 10)

  for i := 0; i < 10; i++ {
    iS := strconv.Itoa(i)
    arr[i] = User{
      Name: "User"+iS,
      Surname: "surname"+iS,
      Profession: "profession"+iS, 
      Telephone: "tf"+iS,
    }
  }

  return arr
}

