IMAGE_NAME := otlp-blueprint
GITHUB_REPO := llprojects/otlp-blueprint
#GITHUB_REPO := heidermassu/otlp-blueprint
NAMESPACE_NAME := otlp

demo: build-and-push-all apply-all-k8s

build-all: build-backend build-frontend

build-and-push-all: build-all push-backend push-frontend

apply-all-k8s: apply-collector  apply-jaeger apply-prometheus apply-postgresql apply-frontend apply-backend

delete-all-k8s: delete-collector  delete-jaeger delete-prometheus delete-postgresql delete-frontend delete-backend


build-backend:
	docker build -t $(IMAGE_NAME)-backend -f Backend.dockerfile .

build-frontend:
	docker build -t $(IMAGE_NAME)-frontend -f Frontend.dockerfile .

push-backend:
	docker tag $(IMAGE_NAME)-backend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:latest
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:latest
# docker tag $(IMAGE_NAME)-backend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')
# docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')

push-frontend:
	docker tag $(IMAGE_NAME)-frontend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:latest
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:latest
	docker tag $(IMAGE_NAME)-frontend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
	
apply-collector:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/collector.yaml | kubectl apply -f -
#sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/collector-lb.yml | kubectl apply -f -

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

apply-nginx:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

apply-ingress:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/ingress.yaml | kubectl apply -f -

delete-backend:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/backend.yaml | kubectl delete -f -

delete-postgresql:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/postgresql.yaml | kubectl delete -f -

delete-collector:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/collector.yaml | kubectl delete -f -

delete-frontend:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/frontend.yaml | kubectl delete -f -

delete-jaeger:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/jaeger.yaml | kubectl delete -f -

delete-prometheus:
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/prometheus.yaml | kubectl delete -f -

delete-ingress:
	kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
	sed 's/$${NAMESPACE_NAME}/$(NAMESPACE_NAME)/g' k8s/manifest/ingress.yaml | kubectl delete -f -