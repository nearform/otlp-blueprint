
### In construction...
### OTEL k8s Operator

The operator must be installed before creating the blueprint resources:

```shell
$ kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
$ kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
```

### Build and push

pre-requisit:
- docker
- Personal access tokens (classic)

Here goes commands could be executed using make:

```bash
make build-all
```

```bash
make build-backend
```

```bash
make build-frontend
```

```bash
make build-and-push-all
```

```bash
push-backend
```

```bash
push-frontend
```

Via Github Actions

In case running via workflow will be execute ```bash make build-and-push-all```