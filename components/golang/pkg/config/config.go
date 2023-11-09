package config

import (
	"github.com/ahasunos/chef-licensing/components/golang/pkg/fetcher"
)

func LicenseServerURL() string {
	return retrieveValue("CHEF_LICENSE_SERVER", "chef-license-server")
}

func retrieveValue(env string, flag string) string {
	value := fetcher.FetchValueFromEnv(env)

	if value != "" {
		return value
	}

	value = fetcher.FetchValueFromArgs(flag)

	if value != "" {
		return value
	}

	return ""
}
