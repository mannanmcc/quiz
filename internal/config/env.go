package config

import (
	"bufio"
	"log"
	"os"
	"strings"
)

func LoadLocalEnv() {
	for _, filename := range []string{".env.local", ".local.env"} {
		if loadEnvFile(filename) {
			log.Printf("Loaded local environment variables from %s", filename)
			return
		}
	}
}

func loadEnvFile(filename string) bool {
	file, err := os.Open(filename)
	if err != nil {
		if !os.IsNotExist(err) {
			log.Printf("Could not read %s: %v", filename, err)
		}
		return false
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}

		key, value, ok := strings.Cut(line, "=")
		if !ok {
			continue
		}

		key = strings.TrimSpace(key)
		value = strings.TrimSpace(value)
		value = strings.Trim(value, `"'`)
		if key == "" {
			continue
		}

		if _, exists := os.LookupEnv(key); !exists {
			os.Setenv(key, value)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Printf("Could not read %s: %v", filename, err)
	}

	return true
}
