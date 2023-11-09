package licenseKeyFetcher

import (
	"os"

	"github.com/ahasunos/chef-licensing/components/golang/pkg/fetcher"
)

func FetchAndPersist() []string {
	var licenseKeys []string

	licenseKeyFromEnv := os.Getenv("CHEF_LICENSE_KEY")

	// validate and append
	licenseKeys = append(licenseKeys, licenseKeyFromEnv)

	licenseKeyFromArg := fetcher.FetchValueFromArgs("chef-license-key")

	// validate and append
	licenseKeys = append(licenseKeys, licenseKeyFromArg)

	return licenseKeys
}
