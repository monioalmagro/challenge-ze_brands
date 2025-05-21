# filepath: /home/almagro/Escritorio/challenge-ze_brands/Makefile
.PHONY: help up test linters migrate init
.ONESHELL:
SHELL = /bin/bash

help: ## Print help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_.-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.DEFAULT_GOAL := help

linters: ## linters generic
	black apps/ utils/ && isort apps/ utils/ --profile black && flake8 apps/ utils

up: ## up the service
	docker compose up --build -d

down: ## stop and delete the service
	docker compose down

test: ## run tests
	docker compose run --rm web pytest

migrate: ## Create migrations
	docker compose run --rm web python manage.py migrate

init: ## Setup the project
	docker compose run -T --rm web python manage.py shell < utils/create_superuser.py
