# Testing Kubernetes YAML Definitions

## kubeval

```bash
# see https://www.kubeval.com

$ kubeval nginx-deployment.yaml
```

## kube-score

```bash
# see https://www.kubeval.com

$ kubectl score nginx-deployment.yaml
$ kubectl score nginx-deployment.yaml --exit-one-on-warning
$ kubectl score nginx-deployment.yaml --output-format ci
```

## Polaris

```bash
# see https://polaris.docs.fairwinds.com/infrastructure-as-code/#install-the-cli

$ polaris audit --audit-path . --format=pretty
$ polaris audit --audit-path .
$ polaris audit --audit-path . --set-exit-code-on-danger --set-exit-code-below-score 90
```

## Snyk

```bash
# see https://docs.snyk.io/snyk-cli/install-the-snyk-cli
$ snyk iac test nginx-deployment.yaml
```

## Terratest 

```bash
# see https://terratest.gruntwork.io/docs/getting-started/quick-start/#example-4-kubernetes
$ make cluster
$ go test
```
