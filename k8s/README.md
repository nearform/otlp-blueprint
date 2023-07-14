## Kind Support

TBC

```shell

cd ./kind

```

```shell

make
# OR
# make NAMESPACE=bar

```
```shell
make forward
```

* localhost:8080
* localhost:3000
* localhost:16686

### Kind Todo

* [] Some cors issues to be fixed 



### Notes

The operator must be installed before creating the blueprint resources.

```shell
$ kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
$ kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
```
