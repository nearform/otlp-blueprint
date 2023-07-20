## K8s Support
#### pre-requisit
- [JQ](https://pkgs.org/download/jq) installed
- GitHub PAT & autorization in the [github registry](https://github.com/acregistry)
## Local test using kind

Creating your demo using kind:

```
make
```
stpes going to be executed:
  - set permission in the files to be executed
  - Validate whether kind or not installed then will delete and create a new one
  - install the cert manager and operator manager (if you have already installed both or one of these is possible disable the installation follwing ### Otel K8s Operator)
  - build and push backend and frontend in this demo
  - create namespace
  - install jaeger (based on mainfests)
  - install collector (based on mainfests)
  - install lb-collector (based on mainfests)
  - install-postgresql (based on mainfests)
  - install-backend (based on mainfests)
  - install-frontend(based on mainfests)


**Notes**

* The **kind** target does not rely on the public docker registry. The frontend and backend apps are built on local and directly loaded into the kind control plane.
* Before creating the new cluster the target attempts to delete an existing one

**Usage**
Once the deployment is completed use the following command to forward the services ports required for the demo to work correctly.

```shell
make forward
```
This target will forward the following ports:

* Frontend -> localhost:8080
* Backend -> localhost:3000
* Jaeger Query -> localhost:16686
* Collector -> localhost:4318
* Metrics - > localhost:8888

To stop the forwarding you can use the following utility target (requires pkill)

```shell
make stop-forward
```

To completely delete demo:

```shell
make delete-all
```

## Deploy on a remote k8s cluster

Ensure your kubectl current context is correct. Then run the following target:

```shell
make k8s
```

The target will: 

* build the backend and the frontend apps
* push the new images to the public docker registry
* install the required operators 
* install the apps

When the deploy is completed use the **forward** target for testing.

## Configurations and Improvements

The following is a list of available configurations and some TODO that will make this tool more usable and safe.

### Namespace

By default the **otlp** namespace will be used. You can use your own namespace name defining the NAMESPACE_NAME var. See the following examples.

```shell
make kind NAMESPACE_NAME=...
# or
NAMESPACE_NAME=... make kind 
```

### Otel K8s Operator

Before deploying the collector we need to install the K8s Otel Operator. The Otel Operator requires that **cert manager** is present and ready on the cluster.
We do this invoking by default the **install-operator** target.

In case you have already configured the cert manager or opentelemetry-operator is possible change the values to true into [Makefile](./Makefile):
```shell
INSTALL_CERT_MANAGER ?= false
INSTALL_OTEL_OPERATOR ?= false
```


### Frontend Build

The frontend app must be aware of the backend api url and of the collector url at compile time. Both the url will need to be reachable from the FE app once loaded in the browser.
The configuration is done passing build-arg to the docker build cmd.
By default, we have the values set up on the makefile:
```
API_URL ?= http://127.0.0.1:3000
OTLP_COLLECTOR_URL ?= http://127.0.0.1:4318
```

```shell
make deployment-frontend API_URL=... OTLP_COLLECTOR_URL=...
```

### Optional Build

The **demo** target invokes the **build-and-push-all** that takes care of building and pushing a new version of the FE and BE apps. 

- **install just resources related collector (collector and collector lb)**
```
make install-collector
```

- **install just resources related frontend and backend in case changing anything in manifest**
```
make install-front-back
```

- **build-push-install frontend**
````
make deployment-frontend
````

- **build-push-install backend**
```
make deployment-backend
```
