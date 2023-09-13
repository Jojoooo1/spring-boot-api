SHELL := /bin/bash
.PHONY: test install run help

DB_CONTAINER="api-database"
DB_NAME="api"
DB_SUPERUSER="postgres"
DB_USER="user"
DB_PASS="password"

DB_CONTAINER_KC="keycloak-database"
DB_NAME_KC="keycloak"
DB_USER_KC="user"
DB_PASS_KC="password"

help: ## Show this help message.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

test: ## Execute all test
	@mvn clean verify

run-api: ## Run API with maven
	@mvn clean spring-boot:run -Dspring.profiles.active=dev

start-api: ## Run API with docker compose
	@docker compose up -d
	@docker compose logs -f api

start-infra: ## Run required infrastructure with docker compose
	$(MAKE) kill start-database start-keycloak start-rabbitmq

restart-infra: ## Reset and start required infrastructure with docker compose
	$(MAKE) start-database start-keycloak start-rabbitmq

start-all: ## Run all containers with docker compose
	$(MAKE) kill start-infra start-api

restart-all: ## Reset and start all containers with docker compose
	$(MAKE) start-infra start-api

start-database: ## Run api database
	@docker compose up -d ${DB_CONTAINER} --wait
	# Set db_user as superuser to allow replication slot creation within migration
	@docker exec -i ${DB_CONTAINER} psql "host=localhost dbname=${DB_NAME} user=${DB_SUPERUSER} password=${DB_PASS}" --command "ALTER USER \"${DB_USER}\" WITH SUPERUSER;"

kill-database: ## Kill api database
	@docker compose rm -sf ${DB_CONTAINER}
	@docker volume rm -f api_database

start-keycloak : ## Run keycloak
	@docker compose up -d ${DB_CONTAINER_KC} --wait
	@cat ./scripts/dumps/keycloak.sql | docker exec -i ${DB_CONTAINER_KC} psql "host=localhost dbname=${DB_NAME_KC} user=${DB_USER_KC} password=${DB_PASS_KC}"
	@docker compose up -d keycloak

kill-keycloak : ## Kill keycloak
	@docker compose rm -sf keycloak ${DB_CONTAINER_KC}
	@docker volume rm -f api_database_kc

start-rabbitmq : ## Run rabbitmq
	@docker compose up -d rabbitmq

kill-rabbitmq : ## Kill rabbitmq
	@docker compose rm -sf rabbitmq
	@docker volume rm -f api_rabbitmq

restart: ## restart project
	@docker compose stop api # used to rebuild API after modification
	@docker compose up -d
	@docker compose logs -f api

kill: ## Kill and reset project
	@docker compose down
	$(MAKE) kill-database kill-keycloak kill-rabbitmq

release: ## Create release
	./scripts/create_release.sh

hotfix: ## Create hotfix
	./scripts/create_hotfix.sh

create-merge-failed: ## Create failed merge PR
	./scripts/create_merge_failed.sh
