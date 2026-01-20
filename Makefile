# Makefile
# Place this file in your project ROOT (next to .Docker/ folder)
#
# Usage:
#   make up       → start services in background
#   make down     → stop and remove containers
#   make build    → (re)build images
#   make logs     → follow logs
#   make ps       → list running containers
#   make shell    → open shell in the main app container (edit SERVICE if needed)
COMPOSE_FILE   := .Server/docker-compose.yaml
COMPOSE        := docker compose -f $(COMPOSE_FILE)
PROJECT_NAME   ?= $(notdir $(CURDIR))           # optional: auto-detect project name from folder
# SERVICE        ?= api                         # optional: default service for shell/exec

# If your project name should be fixed / different:
# PROJECT_NAME   ?= my-symfony-app

# Add --project-name if you want consistent container names regardless of folder
COMPOSE        += --project-name $(PROJECT_NAME)

# ──────────────────────────────────────────────
# Targets
# ──────────────────────────────────────────────

.PHONY: up down build rebuild logs ps restart shell prune help

up:                  ## Start services in detached mode
	$(COMPOSE) up -d

down:                ## Stop and remove containers, networks
	$(COMPOSE) down

build:               ## Build or rebuild services
	$(COMPOSE) build

rebuild:             ## Force rebuild without cache + up
	$(COMPOSE) build --no-cache
	$(COMPOSE) up -d --force-recreate

logs:                ## Follow logs of all services (or make logs SERVICE=api)
	$(COMPOSE) logs -f

ps:                  ## List containers
	$(COMPOSE) ps

restart:             ## Restart all services
	$(COMPOSE) restart

shell:               ## Open interactive shell in the main service (default: first or edit SERVICE)
	$(COMPOSE) exec $(SERVICE) bash   # or sh / ash / zsh depending on image

prune:               ## Clean up unused images, containers, volumes, networks
	docker system prune -a --volumes --force

help:                ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Bonus: common aliases / shortcuts
start: up
stop:  down