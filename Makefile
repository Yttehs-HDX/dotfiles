.PHONY : all deploy install

PYTHON = python3

all: install deploy

install:
	@echo "Installing packages..."
	@$(PYTHON) .scripts/install_pkgs.py

deploy:
	@echo "Deploying files..."
	@$(PYTHON) .scripts/deploy_to_dst.py
