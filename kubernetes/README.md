# Testing Kubernetes YAML Definitions

## kubeval

```bash
# see https://www.kubeval.com

$ kubeval nginx-deployment.yaml
```

## kubeconform

```bash
# see https://github.com/yannh/kubeconform
$ brew install kubeconform
$ kubeconform nginx-deployment.yaml
```

## kube-score

```bash
# see https://github.com/zegl/kube-score

$ kubectl score nginx-deployment.yaml
$ kubectl score nginx-deployment.yaml --exit-one-on-warning
$ kubectl score nginx-deployment.yaml --output-format ci
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
