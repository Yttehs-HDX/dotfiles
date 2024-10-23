.PHONY : all

PYTHON = python3

all:
	@$(PYTHON) .scripts/deploy_to_dst.py
