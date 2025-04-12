CYAN := \033[0;36m
GRAY := \033[0;37m
NC := \033[0m


PYTHON := poetry run python3
POETRY := poetry
PRE_COMMIT := pre-commit

# List all targets when running `make` without arguments or `make help`
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make $(CYAN)<target>$(NC) $(GRAY)[ -- [options] [args] ]$(NC)"
	@awk 'BEGIN {FS = ":.*##"; printf "\nTargets:"} /^[a-zA-Z_-]+:.*?##/ { printf "    $(CYAN)%-30s$(NC) %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: test
test: ## Run all tests
	@echo "$(CYAN)Running tests...$(NC)"
	$(POETRY) run pytest tests/ --cov=fastapi_asyncapi --cov-report=term-missing:skip-covered --cov-report=xml

.PHONY: docs
docs: ## Build the documentation
	@echo "$(CYAN)Building documentation...$(NC)"
	$(POETRY) run mkdocs gh-deploy --force

