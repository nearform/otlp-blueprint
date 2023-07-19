IMAGE_NAME := otlp-blueprint
REGISTRY := ghcr.io/acregistry/otlp-blueprint
NAMESPACE_NAME := otlp
INSTALL_CERT_MANAGER ?= false
INSTALL_OTEL_OPERATOR ?= true

########################################################################################################################
# Starting DEMO
# In case you want to start in your own enviroment and do not need cert-manager and opentelemetry-operator 
#  change the flag INSTALL_OPERATOR to false otherwise use as true
# In case you do not have any cluster first use make kind before make demo
########################################################################################################################
demo: build-and-push-all install-operator install-apps
install-apps: create-namespace install-jaeger install-collector install-lb-collector install-postgresql install-frontend install-backend

test: install-operator install-apps
########################################################################################################################
# Starting Creating kind
# In case you do not have any cluster first use make kind before make demo
########################################################################################################################
kind: kind-down kind-up install-operator create-namespace install-jaeger install-collector install-lb-collector install-postgresql kind-install-local-apps

########################################################################################################################
# Installing foundation related collector
########################################################################################################################
install-collector: install-collector install-lb-collector 

forward: port-forward

stop-forward: kill-forward

########################################################################################################################
# deleting environment
########################################################################################################################
delete-all: delete-namespace
delete-collector: delete-collector delete-lb-collector 

#################
# BUILD AND PUSH
#################
build-all: build-backend build-frontend

build-and-push-all: build-all push-backend push-frontend

install-front-back: install-backend install-frontend

deployment-frontend: build-frontend push-frontend install-frontend

deployment-backend: build-backend push-backend install-backend

#########################
# BUILD AND PUSH Scripts
#########################
build-backend:
	@./scripts/build-backend.sh $(IMAGE_NAME)

build-frontend:
	@./scripts/build-frontend.sh $(IMAGE_NAME)

push-backend:
	@./scripts/push-backend.sh $(REGISTRY) $(IMAGE_NAME)

push-frontend:
	@./scripts/push-backend.sh $(REGISTRY) $(IMAGE_NAME)

############
# Kind Scripts
############
kind-up:
	@./scripts/kind-cluster-up.sh

kind-down: kill-forward
	@./scripts/kind-down.sh

kind-install-local-apps: build-all
	@./scripts/kind-install-local-apps.sh $(NAMESPACE_NAME) $(IMAGE_NAME)


############
# K8S Scripts
###########
install-operator:
	@./scripts/otel-operator.sh $(INSTALL_CERT_MANAGER) $(INSTALL_OTEL_OPERATOR) $(NAMESPACE_NAME)

create-namespace:
	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' ./manifest/namespace.yaml | kubectl apply -f - || true

delete-namespace:
	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' ./manifest/namespace.yaml | kubectl delete -f -

install-collector:
	@./scripts/install-app.sh $(NAMESPACE_NAME) collector

install-lb-collector:
	@./scripts/install-app.sh $(NAMESPACE_NAME) lb-collector

install-backend:
	@./scripts/install-app.sh $(NAMESPACE_NAME) backend

install-frontend:
	@./scripts/install-app.sh $(NAMESPACE_NAME) frontend

install-jaeger:
	@./scripts/install-app.sh $(NAMESPACE_NAME) jaeger

install-postgresql:
	@./scripts/install-app.sh $(NAMESPACE_NAME) postgresql

delete-collector:
	@./scripts/delete-app.sh $(NAMESPACE_NAME) collector

delete-lb-collector:
	@./scripts/delete-app.sh $(NAMESPACE_NAME) lb-collector

delete-backend:
	@./scripts/delete-app.sh $(NAMESPACE_NAME) backend

delete-frontend:
	@./scripts/delete-app.sh $(NAMESPACE_NAME) frontend

delete-jaeger:
	@./scripts/delete-app.sh $(NAMESPACE_NAME) jaeger

delete-postgresql:
	@./scripts/delete-app.sh $(NAMESPACE_NAME) postgresql

port-forward:
	@./scripts/port-forward.sh $(NAMESPACE_NAME)

kill-forward:
	@./scripts/kill-forward.sh

#apply-prometheus:
#	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/prometheus.yaml | kubectl apply -f -

#apply-nginx:
#	@kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
#
#apply-ingress:
#	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/ingress.yaml | kubectl apply -f -

#delete-prometheus:
#	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/prometheus.yaml | kubectl delete -f -
#
#delete-ingress:
#	@kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
#	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/ingress.yaml | kubectl delete -f -
