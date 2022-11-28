SHELL := /bin/bash

export HELP_FILTER ?= help|lint|terraform|tflint|tfmodule
export README_TEMPLATE_FILE ?= build-harness-extensions/templates/README.md.gotmpl

# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md docs/terraform.md

-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)

## Lint Terraform code
lint:
	$(SELF) terraform/install terraform/get-modules terraform/lint terraform/validate tflint
