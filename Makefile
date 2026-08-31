.PHONY: help setup install dev portless build start lint lint-fix format format-check clean clean-deps
.SECONDEXPANSION:

.DEFAULT_GOAL := help

ROOT_DIR := .

##@ General
help: ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Setup
setup: clean-deps install ## Clean install (wipe node_modules, reinstall)
install: ## Install dependencies
	bun install

##@ Development
dev: ## Run dev server
	bun run dev

portless: ## Run dev server via portless (https://landing.localhost)
	bunx portless

build: ## Build for production
	bun run build

start: ## Preview production build (requires build first)
	bun run preview

##@ Code Quality
lint: ## Prettier check (read-only)
	bun run lint

lint-fix: ## Prettier format + write
	bun run lint:fix

format: ## Format code (prettier --write)
	bun run format

format-check: ## Check formatting without writing
	bun run format:check

##@ Clean
clean: ## Remove build outputs
	rm -rf dist .astro node_modules/.cache

clean-deps: ## Remove node_modules
	rm -rf node_modules
