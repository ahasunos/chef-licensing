package fetcher

import (
	"flag"
	"os"
)

func FetchValueFromArgs(key string) string {
	licensePtr := flag.String(key, "", "Specify the value for "+key)

	// Parse the command-line arguments
	flag.Parse()

	// Access the value of the give key
	licenseValue := *licensePtr

	return licenseValue
}

func FetchValueFromEnv(key string) string {
	return os.Getenv(key)
}
