# Testing Kubernetes YAML Definitions

## kubeval

```bash
# see https://www.kubeval.com

$ kubeval nginx-deployment.yaml
```

## kube-score

```bash
# see https://github.com/zegl/kube-score

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

## Checkov

```bash
# see https://github.com/bridgecrewio/checkov
$ checkov -f nginx-deployment.yaml
```

## Kustomize

Keep our YAML redundancy free (DRY) using Kustomize.

```bash
$ kustomize build kustomize/overlays/prod/
$ kubectl apply -k kustomize/overlays/prod/
```

## Terratest 

```bash
# see https://terratest.gruntwork.io/docs/getting-started/quick-start/#example-4-kubernetes
$ make cluster
$ go test
```
