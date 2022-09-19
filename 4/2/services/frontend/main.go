package main

import (
	"encoding/json"
	"io"
	"net/http"
	"os"
	"strings"

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

  r.LoadHTMLGlob(getTemplateParentFolder() + "templates/*.tmpl")

  r.GET("/index", func(c *gin.Context) {
    users, err := fetchUsers() 
    if err != nil {
      c.JSON(http.StatusNotFound, gin.H{
        "message": "we can't find users",
      })
      return
    }

    c.HTML(http.StatusOK, "index.html.tmpl", gin.H{
      "title": "Best app ever",
      "users": users,
    })
  })

  r.Run(":" + os.Getenv("PORT"))
}

func fetchUsers() ([]User, error) {
  var users []User
  res, err := http.Get(os.Getenv("BACKEND_URL") + "/users")
  if err != nil {
    return users, err
  }
  defer res.Body.Close()

  b, err := io.ReadAll(res.Body)
  if err != nil {
    return users, err
  }

  err = json.Unmarshal(b, &users)
  if err != nil {
    return users, err
  }

  return users, nil
}

func getTemplateParentFolder() string {
  tf := os.Getenv("TEMPLATE_FOLDER")

  if !strings.HasSuffix(tf, "/") {
    tf += "/" 
  }

  return tf
}
