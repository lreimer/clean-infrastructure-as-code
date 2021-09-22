# Testing Docker Images

## dockerfile_lint

```bash
# Installation and usage instructions
# https://github.com/projectatomic/dockerfile_lint

$ dockerfile_lint -f Dockerfile -r basic_rules.yaml
$ dockerfile_lint -f Dockerfile -r recommended_label_rules.yaml
$ dockerfile_lint -f Dockerfile -r security_rules.yaml
```

## Snyk

```bash
# Installation and usage instructions
# https://docs.snyk.io/snyk-cli/install-the-snyk-cli

$ docker build -t lreimer/snyk-test:1.0 .
$ snyk container test --file=Dockerfile lreimer/snyk-test:1.0
```

## Container Structure Tests

```bash
# see https://github.com/GoogleContainerTools/container-structure-test
$ docker build -t lreimer/structure-test:1.0 .
$ container-structure-test test --image lreimer/structure-test:1.0 --config structure_test.yaml
```

## Terratest

```bash
# see https://terratest.gruntwork.io/docs/getting-started/quick-start/#example-3-docker
$ go test
```
