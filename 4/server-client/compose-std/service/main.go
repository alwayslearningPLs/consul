package main

import (
  "log"
  "net/http"
  "os"
)

var port = "5000"

func main() {
  http.HandleFunc("/ping", func(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "text/plain")
    w.WriteHeader(http.StatusOK)
    w.Write([]byte("pong"))
  })

  if p := os.Getenv("PORT"); p != "" {
    port = p
  }

  log.Fatal(http.ListenAndServe(":" + port, nil))
}
