## K8s Support

## Local test using kind

#### Requirements

* Install kind https://kind.sigs.k8s.io/docs/user/quick-start/#installation

Use the following command to create the cluster, configure it and deploy the demo on a kind cluster:

```shell
make kind
```
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

To stop the forwarding you can use the following utility target (requires pkill)

```shell
make stop-forward
```

To completely delete the cluster:

```shell
make kind-down
```

## Deploy on a remote k8s cluster

Ensure your kubectl current context is correct and refers to the desired target. Then run the following target:

```shell
make demo
```

The target will: 

* build the backend and the frontend apps
* push the new images to the public docker registry
* install the required operators 
* install the apps

When the deploy id completed you can use the **forward** target for testing.



## Configurations and Improvements

### Namespace

By default a the **otlp** namespace will be used. You can use your own namespace name defining the NAMESPACE_NAME var. See the following examples.

```shell
make kind NAMESPACE_NAME=...
# or
NAMESPACE_NAME=... make kind 
```

### Otel K8s Operator

Before deploying the collector we need to install the K8s Otel Operator. The Otel Operator requires that **cert manager** is present and ready on the cluster.
We do this invoking by default the **install-operator** target.
This specific target requires some extra work:

```shell
et -e

# Remove the sleeps checking that the resources are ready before proceeding
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
sleep 30
kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
sleep 30
```

**TODO:**
* remove the sleep from the script. This was a fast and convenient way to workaround but is not safe at all. Replace this with some logic that check that the resources are ready and we can go on
* installing the cert-manager and the opentelemetry-operator **should be optional** (probably default to true only for the kind use case)

For example:

```shell
make demo INSTALL_CERT_MANAGER={} INSTALL_OTEL_OPERATOR={}
```

### Frontend Build

The frontend app must be aware of the backend api url and of the collector url at compile time. Both the url will need to be reachable from the FE app once loaded in the browser.
The configuration is done passing build-arg to the docker build cmd.

```shell
# ./scripts/build-frontend.sh

et -e

image_suffix="${1:-"otlp-blueprint"}"

pushd ../
  docker build --build-arg="API_URL=http://127.0.0.1:3000"  --build-arg="OTLP_COLLECTOR_URL=http://127.0.0.1:4318" -t "$image_suffix"-frontend -f Frontend.dockerfile .
popd

```
**TODO**

* the hardcoded values should be passed as arguments to the above scripts and defined as env vars in the makefile. Ideally we should be able to override them invoking the target. Using 127.0.0.1 as default 
seem a reasonable choice.

```shell
make demo API_URL=... OTLP_COLLECTOR_URL=...
```

### Optional Build

The **demo** target invokes the **build-and-push-all** that takes care of building and pushing a new version of the FE and BE apps. 

**TODO**

* The use case should be evaluated a bit more. Building and pushing every time we configure the demo could not be required. An option could be to conditionally execute the **build-and-push-all** target or part of it.
