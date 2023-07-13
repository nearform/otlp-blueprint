IMAGE_NAME := otlp-blueprint
GITHUB_REPOM := heidermassu/otlp-blueprint

build-all: build-backend build-frontend

build-backend:
	docker build -t $(IMAGE_NAME)-backend -f Backend.dockerfile .

build-frontend:
	docker build -t $(IMAGE_NAME)-frontend -f Frontend.dockerfile .

build-and-push-all: build-all push-backend push-frontend

push-backend:
	docker login docker.pkg.github.com -u $(shell echo $$GITHUB_ACTOR) -p ${TOKEN}
	docker tag $(IMAGE_NAME)-backend:latest docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-backend:latest
	docker push docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-backend:latest
	docker tag $(IMAGE_NAME)-backend:latest docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')
	docker push docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-backend:$(shell date +'%Y%m%d%H%M%S')

push-frontend:
	docker login docker.pkg.github.com -u $(shell echo $$GITHUB_ACTOR) -p ${TOKEN}
	docker tag $(IMAGE_NAME)-frontend:latest docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-frontend:latest
	docker push docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-frontend:latest
	docker tag $(IMAGE_NAME)-frontend:latest docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
	docker push docker.pkg.github.com/$(GITHUB_REPOM)/$(IMAGE_NAME)-frontend:$(shell date +'%Y%m%d%H%M%S')
