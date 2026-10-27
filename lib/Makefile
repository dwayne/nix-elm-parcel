.PHONY: build preview deploy

# Build the site for production (result by default)
build: elm.lock
	nix build -L

# Preview the production build locally
preview: elm.lock
	nix run

# Deploy the production build into the deployBranch branch (site by default)
deploy: elm.lock
	nix run .#deploy

# The elm.json files to lock
PROJECT_ELM_JSON_FILES ?= elm.json

# Regenerate elm.lock whenever elm.json changes
elm.lock: $(PROJECT_ELM_JSON_FILES)
	elm2nix lock $(PROJECT_ELM_JSON_FILES)
