IMAGE_NAME := otlp-blueprint
REGISTRY := ghcr.io/heidermassu/otlp-blueprint
NAMESPACE_NAME := otlp

demo: build-and-push-all install-operator install-apps

kind: kind-down kind-up install-operator create-namespace install-jaeger install-collector install-postgresql kind-install-local-apps

build-all: build-backend build-frontend

build-and-push-all: build-all push-backend push-frontend

install-apps: create-namespace install-jaeger install-collector install-postgresql install-frontend install-backend

collector: install-collector install-lb-collector

delete-all: delete-namespace

forward: port-forward

stop-forward: kill-forward

###############
# BUILD AND PUSH
###############
build-backend:
	@./scripts/build-backend.sh $(IMAGE_NAME)

build-frontend:
	@./scripts/build-frontend.sh $(IMAGE_NAME)

push-backend:
	@./scripts/push-backend.sh $(REGISTRY) $(IMAGE_NAME)

push-frontend:
	@./scripts/push-backend.sh $(REGISTRY) $(IMAGE_NAME)

############
# Kind
############
kind-up:
	@./scripts/kind-cluster-up.sh

kind-down: kill-forward
	@./scripts/kind-down.sh

kind-install-local-apps: build-all
	@./scripts/kind-install-local-apps.sh $(NAMESPACE_NAME) $(IMAGE_NAME)


############
# K8S
###########
install-operator:
	@./scripts/otel-operator.sh

create-namespace:
	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' ./manifest/namespace.yaml | kubectl apply -f - || true

delete-namespace:
	@sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' ./manifest/namespace.yaml | kubectl delete -f -

install-collector:
	@./scripts/install-app.sh $(NAMESPACE_NAME) collector


install-collector2:
	@./scripts/install-app.sh $(NAMESPACE_NAME) collector2

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

delete-collector2:
	@./scripts/delete-app.sh $(NAMESPACE_NAME) collector2

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
