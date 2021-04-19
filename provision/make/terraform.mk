## Terraform show help commands
.PHONY: terraform.help

TF_DOCS := $(shell which terraform-docs 2> /dev/null)

define terraform-docs
	$(if $(TF_DOCS),,$(error "terraform-docs revision >= a8b59f8 is required (https://github.com/segmentio/terraform-docs)"))
	@terraform-docs markdown table . --output-file ${1} --output-mode replace --sort-by-type
endef

terraform.help:
	@echo '    terraform:'
	@echo ''
	@echo '        terraform                show help'
	@echo '        terraform.docs           generate documentation variables'
	@echo ''

## Terraform show help commands
.PHONY: terraform
terraform:
	make terraform.help

## Terraform generate docs
.PHONY: terraform.docs
terraform.docs:
	$(call terraform-docs, ${TERRAFORM_README_FILE})
