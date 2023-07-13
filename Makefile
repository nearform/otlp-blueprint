IMAGE_NAME := otlp-blueprint
GITHUB_REPO := nearform/otlp-blueprint

build-all: build-backend build-frontend

build-backend:
	docker build -t $(IMAGE_NAME)-backend -f Backend.dockerfile .

build-frontend:
	docker build -t $(IMAGE_NAME)-frontend -f Frontend.dockerfile .

build-and-push-all: build-all push-backend push-frontend

push-backend:
	docker login ghcr.io -u $(shell echo $$GITHUB_ACTOR) -p ${TOKEN}
	docker tag $(IMAGE_NAME)-backend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:latest
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:latest
	docker tag $(IMAGE_NAME)-backend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')

push-frontend:
	docker login ghcr.io -u $(shell echo $$GITHUB_ACTOR) -p ${TOKEN}
	docker tag $(IMAGE_NAME)-frontend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:latest
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:latest
	docker tag $(IMAGE_NAME)-frontend:latest ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
	docker push ghcr.io/$(GITHUB_REPO)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
