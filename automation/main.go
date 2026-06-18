package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"time"
)

type ImageTag struct {
	Tag       string    `json:"tag"`
	CreatedAt time.Time `json:"created_at"`
}

func main() {
	fmt.Println("Starting custom Docker registry cleanup utility...")
	
	registryURL := os.Getenv("REGISTRY_URL")
	if registryURL == "" {
		registryURL = "https://cr.yandex/api/v1/repositories/enterprise-service/tags"
	}

	client := &http.Client{Timeout: 10 * time.Second}
	req, _ := http.NewRequest("GET", registryURL, nil)
	req.Header.Set("Authorization", "Bearer "+os.Getenv("YANDEX_OAUTH_TOKEN"))

	resp, err := client.Do(req)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error connecting to registry API: %v\n", err)
		os.Exit(1)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		fmt.Fprintf(os.Stderr, "Registry API returned non-200 status: %d\n", resp.StatusCode)
		os.Exit(1)
	}

	var tags []ImageTag
	if err := json.NewDecoder(resp.Body).Decode(&tags); err != nil {
		fmt.Fprintf(os.Stderr, "Failed to decode response: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Successfully fetched %d tags. Analyzing retention policy...\n", len(tags))
	for _, t := range tags {
		if time.Since(t.CreatedAt).Hours() > 24*30 {
			fmt.Printf("Tag %s is older than 30 days (Created: %v). Simulating deletion...\n", t.Tag, t.CreatedAt)
		}
	}
	fmt.Println("Cleanup simulation finished successfully.")
}
