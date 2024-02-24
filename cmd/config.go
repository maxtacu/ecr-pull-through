package main

import (
	"fmt"
	"os"

	"gopkg.in/yaml.v3"
)

type Config struct {
	Registries   []string `yaml:"registries"`
	AwsAccountID string   `yaml:"awsAccountId"`
	AwsRegion    string   `yaml:"awsRegion,omitempty"`
}

func ReadConf(filename string) (*Config, error) {
	buf, err := os.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	content := &Config{}
	err = yaml.Unmarshal(buf, content)
	if err != nil {
		return nil, fmt.Errorf("in file %q: %w", filename, err)
	}

	return content, err
}

func (c *Config) RegistryList() []string {
	if len(c.Registries) == 0 {
		return []string{"docker.io"}
	}
	return c.Registries
}
