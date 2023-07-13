###############################################################################
# ENVIRONMENT CONFIGURATION
###############################################################################
MAKEFLAGS += --no-print-directory
SHELL=/bin/bash

.PHONY: default kind clean

###############################################################################
# GOALS ( safe defaults )
###############################################################################

default:
	echo "This will deploy to a real K8s cluster"

kind: kind-up open-telemetry-operator install-apps

clean: kind-down kill-forward


###############################################################################
# GOALS
###############################################################################

kind-up: build
	@./scripts/kind-cluster-up.sh

kind-down:
	@./scripts/kind-down.sh

port-forward:
	@./scripts/port-forward.sh

kill-forward:
	@./scripts/kill-forward.sh

build: build-frontend build-backend

build-frontend:
	@./scripts/build-frontend.sh

build-backend:
	@./scripts/build-backend.sh

open-telemetry-operator:
	@./scripts/otel-operator.sh

install-apps:
	@./scripts/install-apps.sh


