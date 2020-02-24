package main

import (
	"fmt"
    "net/http"
    "io/ioutil"

)

func main() {
    client := &http.Client{}
    req, err := http.NewRequest("GET", "https://api2.greypanel.com/api/v1/account/view", nil)

    if err != nil {
        fmt.Println(err)
    }

    req.Header.Add("greycdn-token", "a3fd4647-fe54-4500-a559-793fc833401d")
    
    resp, err := client.Do(req)
    defer resp.Body.Close()

    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        // handle error
    }

    fmt.Println(string(body))

}
