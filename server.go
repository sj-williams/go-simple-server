package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		username := r.FormValue("username")
		password := r.FormValue("password")

		if username != "admin" || password != "DummyPassword" {
			http.Error(w, "Unauthorized", http.StatusUnauthorized)
			return
		}

		fmt.Fprintf(w, "Welcome, %s!", username)
	})

	http.ListenAndServe(":8080", nil)
}
