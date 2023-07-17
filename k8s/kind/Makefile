###############################################################################
# ENVIRONMENT CONFIGURATION
###############################################################################
MAKEFLAGS += --no-print-directory
SHELL=/bin/bash
NAMESPACE?=otlp

.PHONY: default kind clean forward

###############################################################################
# GOALS ( safe defaults )
###############################################################################

default: clean kind

kind: kind-up open-telemetry-operator install-apps

clean: kind-down kill-forward

forward: port-forward

###############################################################################
# GOALS
###############################################################################

kind-up: build
	@./scripts/kind-cluster-up.sh

kind-down:
	@./scripts/kind-down.sh

port-forward:
	@./scripts/port-forward.sh $(NAMESPACE)

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
	@./scripts/install-apps.sh $(NAMESPACE)