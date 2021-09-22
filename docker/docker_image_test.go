package main

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/docker"
	"github.com/stretchr/testify/assert"
)

func TestDockerImage(t *testing.T) {
	// Configure the tag to use on the Docker image.
	tag := "lreimer/terratest-docker"
	buildOptions := &docker.BuildOptions{
		Tags: []string{tag},
	}

	// Build the Docker image.
	docker.Build(t, ".", buildOptions)

	// Run the Docker image, read the text file from it, and make sure it contains the expected output.
	opts := &docker.RunOptions{Command: []string{"cat", "/usr/share/nginx/html/index.html"}}
	output := docker.Run(t, tag, opts)
	assert.Equal(t, "Hello, World!", output)
}
