IMAGE_NAME := otlp-blueprint
GITHUB_REPO := nearform/otlp-blueprint
NAMESPACE_NAME := otlp-test

build-all: build-backend build-frontend

build-backend:
	docker build -t $(IMAGE_NAME)-backend -f Backend.dockerfile .

build-frontend:
	docker build -t $(IMAGE_NAME)-frontend -f Frontend.dockerfile .

build-and-push-all: build-all push-backend push-frontend

push-backend:
	docker tag $(IMAGE_NAME)-backend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:latest
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:latest
	docker tag $(IMAGE_NAME)-backend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')

push-frontend:
	docker tag $(IMAGE_NAME)-frontend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:latest
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:latest
	docker tag $(IMAGE_NAME)-frontend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
	
apply-collector:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/collector.yaml | kubectl apply -f -

apply-backend:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/backend.yaml | kubectl apply -f -

apply-frontend:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/frontend.yaml | kubectl apply -f -

apply-jaeger:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/jaeger.yaml | kubectl apply -f -

apply-postgresql:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/postgresql.yaml | kubectl apply -f -

apply-prometheus:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/prometheus.yaml | kubectl apply -f -


apply-all-k8s:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/collector.yaml | kubectl apply -f -
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/backend.yaml | kubectl apply -f -
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/frontend.yaml | kubectl apply -f -
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/jaeger.yaml | kubectl apply -f -
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/postgresql.yaml | kubectl apply -f -
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/prometheus.yaml | kubectl apply -f -