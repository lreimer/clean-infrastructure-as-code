package main

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/k8s"
)

func TestKubernetesNginxDeployment(t *testing.T) {
	t.Parallel()

	// Path to the Kubernetes resource config we will test.
	kubeResourcePath := "./nginx-deployment.yaml"

	// Setup the kubectl config and context.
	options := k8s.NewKubectlOptions("", "", "default")

	// At the end of the test, run "kubectl delete" to clean up any resources that were created.
	defer k8s.KubectlDelete(t, options, kubeResourcePath)

	// Run `kubectl apply` to deploy. Fail the test if there are any errors.
	k8s.KubectlApply(t, options, kubeResourcePath)

	// Verify the service is available and get the URL for it.
	k8s.WaitUntilServiceAvailable(t, options, "nginx-service", 30, 5*time.Second)
	service := k8s.GetService(t, options, "nginx-service")
	url := fmt.Sprintf("http://%s", k8s.GetServiceEndpoint(t, options, service, 18080))

	// Make an HTTP request to the URL and make sure it returns a 200 OK with the body "Hello, World".
	http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello world!", 5, 3*time.Second)
}
