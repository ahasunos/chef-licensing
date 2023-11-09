package licenseKeyFetcher

import (
	"fmt"
	"os"

	"github.com/ahasunos/chef-licensing/components/golang/pkg/fetcher"
	restfulClient "github.com/ahasunos/chef-licensing/components/golang/pkg/restful_client"
)

func FetchAndPersist() []string {
	var licenseKeys []string

	licenseKeyFromEnv := os.Getenv("CHEF_LICENSE_KEY")
	validateAndAppend(&licenseKeys, licenseKeyFromEnv)

	licenseKeyFromArg := fetcher.FetchValueFromArgs("chef-license-key")
	validateAndAppend(&licenseKeys, licenseKeyFromArg)

	return licenseKeys
}

func validateAndAppend(licenseKeys *[]string, licenseKey string) {
	isLicenseValid := restfulClient.Validate(licenseKey)

	if isLicenseValid {
		fmt.Println("license key ", licenseKey, " is valid!")
		*licenseKeys = append(*licenseKeys, licenseKey)
	}
}
