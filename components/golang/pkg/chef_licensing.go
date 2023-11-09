package chefLicensing

import (
	licenseKeyFetcher "github.com/ahasunos/chef-licensing/components/golang/pkg/license_key_fetcher"
)

func FetchAndPersist() []string {
	keys := licenseKeyFetcher.FetchAndPersist()
	return keys
}
