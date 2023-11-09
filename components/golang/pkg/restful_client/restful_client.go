package restfulClient

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"

	"github.com/ahasunos/chef-licensing/components/golang/pkg/config"
)

var endpointNames = map[string]string{
	"validate": "/v1/validate",
}

var currentEndpointVersion string = "2"

func Validate(key string) bool {

	url, err := url.Parse(config.LicenseServerURL() + endpointNames["validate"])
	if err != nil {
		fmt.Println("Error parsing URL:", err)
		return false
	}

	// Query params
	params := map[string]string{
		"version":   currentEndpointVersion,
		"licenseId": key,
	}

	q := url.Query()
	for key, value := range params {
		q.Add(key, value)
	}

	// The q.Encode() method converts the key-value pairs in q into a URL-encoded string.
	// For example, if q contains {"version": "1.0", "licenseId": "your_key_here"}, q.Encode()
	// would produce "version=1.0&licenseId=your_key_here".

	url.RawQuery = q.Encode()

	response := get(url.String())
	return response["status_code"].(float64) == 200
}

func get(url string) map[string]interface{} {
	response, err := http.Get(url)
	if err != nil {
		fmt.Println("Error making GET request:", err)
		return map[string]interface{}{}
	}
	defer response.Body.Close()

	// Read the response body
	body := readBodyFromResponse(response)

	// Unmarshal the body
	resultMap := unmarshallBody(body)
	return resultMap
}

func readBodyFromResponse(response *http.Response) []byte {
	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		fmt.Println("Error reading response body:", err)
		return []byte{}
	}
	return body
}

func unmarshallBody(body []byte) map[string]interface{} {
	// The type map[string]interface{} in Go represents a map where the keys are strings, and the values can be of any type (interface{}).
	var resultMap map[string]interface{}
	err := json.Unmarshal(body, &resultMap)
	if err != nil {
		fmt.Println("Error unmarshalling JSON:", err)
	}
	return resultMap
}
