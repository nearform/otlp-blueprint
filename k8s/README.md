## Kind Support

**TBC**

Ensure you have kind and docker installed.

* kind https://kind.sigs.k8s.io/docs/user/quick-start/#installation
  
Move to the kind dir
```shell
cd ./kind
```

Create a kind cluster and deploy the OLTP demo
```shell
make
# OR
# make NAMESPACE=bar
```

Forward the required services ports
```shell
make forward
```

Access the services as following 
* Frontend -> localhost:8080
* Backend -> localhost:3000
* Jaeger Query -> localhost:16686

Cleanup

```shell
make clean
```


### Kind Todo

*[] Some cors issues to be fixed 



### Notes

The operator must be installed before creating the blueprint resources.

```shell
$ kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
$ kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
```
