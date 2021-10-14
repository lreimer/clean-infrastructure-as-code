# Terraform Pull Request Automation

```bash
$ echo -n "yourtoken" > token
$ echo -n "yoursecret" > webhook-secret
$ kubectl create secret generic atlantis-vcs --from-file=token --from-file=webhook-secret --dry-run=client -o yaml > secrets.yaml
$ kustomize build
$ kubectl apply -k .
```