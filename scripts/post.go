package main

import (
	"fmt"
    "net/http"
    "io/ioutil"

)

func main() {
    client := &http.Client{}
    req, err := http.NewRequest("POST", "https://api2.greypanel.com/api/v1/site/list/all", nil)
    if err != nil {
        fmt.Println(err)
    }
    req.Header.Add("Content-Type", "application/json")
    req.Header.Add("greycdn-token", "a3fd4647-fe54-4500-a559-793fc833401d")

    resp, err := client.Do(req)

    defer resp.Body.Close()

    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        // handle error
    }

    fmt.Println(string(body))

}
