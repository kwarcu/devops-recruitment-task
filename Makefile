# Default make ENV is development. use make [target] ENV=prod for production
.DEFAULT_GOAL:=help

DEV_COMPOSE_FILES_PATH := -f docker-compose.yml
PROD_COMPOSE_FILES_PATH := -f docker-compose.prod.yml

ENV ?= dev

ifeq ($(filter $(ENV),dev prod),)
$(error The ENV variable is invalid. must be one of <prod|dev> )
endif

ifeq ($(ENV), prod)
COMPOSE_FILES_PATH := $(PROD_COMPOSE_FILES_PATH)
else
COMPOSE_FILES_PATH := $(DEV_COMPOSE_FILES_PATH)
endif

# --------------------------

.PHONY: build start stop logs images restart up down rm help

up:				## Start service, rebuild if necessary
	docker-compose $(COMPOSE_FILES_PATH) up --build -d

build:			## Build The Image
	docker-compose $(COMPOSE_FILES_PATH) build

down:			## Down service and do clean up
	docker-compose $(COMPOSE_FILES_PATH) down

start:			## Start Container
	docker-compose $(COMPOSE_FILES_PATH) start

stop:			## Stop Container
	docker-compose $(COMPOSE_FILES_PATH) stop

logs:			## Tail container logs with -n 1000
	docker-compose $(COMPOSE_FILES_PATH) logs --follow --tail=1000

images:			## Show Image created by this Makefile (or Docker-compose in docker)
	docker-compose $(COMPOSE_FILES_PATH) images

restart:		## Restart container
	docker-compose $(COMPOSE_FILES_PATH) restart

rm:				## Remove current container
	docker-compose $(COMPOSE_FILES_PATH) rm -f
help:       	## Show this help.
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m ENV=<prod|dev> (default: dev)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
