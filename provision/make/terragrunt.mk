## Terragrunt
.PHONY: terragrunt.help
TERRAFORM_DIR:=$(PROVISION_DIR)/terraform
terragrunt := terragrunt

terragrunt.help:
	@echo '    terragrunt:'
	@echo ''
	@echo '        terragrunt                 show help'
	@echo '        terragrunt.setup           install dependences'
	@echo '        terragrunt.environment     install dependences or change environment'
	@echo '        terragrunt                 command=(plan|apply|refresh|destroy|) by stage'
	@echo '        terragrunt.state           command=(list|mv|pull|push|rm|show|) by stage'
	@echo '        terragrunt.init            Init download dependences terraform'
	@echo '        terragrunt.import          command by stage'
	@echo ''

terragrunt.validate:
	@if [ "${AWS_PROFILE_NAME}" != "${TEAM}" ]; then \
		echo "----> var ${AWS_PROFILE_NAME} not correspond ${TEAM}"; \
		exit 2; \
	fi

terragrunt: terragrunt.validate
	@if [ -z "${command}" ]; then \
		make terragrunt.help;\
	fi
	@if [ -z "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/ && $(terragrunt) ${command}-all --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/${stage} && $(terragrunt) ${command} --terragrunt-source-update; \
	fi

terragrunt.setup: terragrunt.validate
	@echo "=====> setup terragrunt..."
	@tfenv install ${TERRAFORM_VERSION} && tfenv use ${TERRAFORM_VERSION}
	@echo ${MESSAGE_HAPPY}
.PHONY: terragrunt.setup

terragrunt.environment:
	@echo "----> setup terragrunt..."
	@tfenv use ${TERRAFORM_VERSION} || tfenv install ${TERRAFORM_VERSION} && tfenv use ${TERRAFORM_VERSION}
	@echo ${MESSAGE_HAPPY}
.PHONY: terragrunt.environment

terragrunt.init: terragrunt.validate
	@if [ -z "${stage}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/ && $(terragrunt) init --reconfigure; \
	else \
		cd ${TERRAFORM_DIR}/us-east-1/${stage}/ && $(terragrunt) init --reconfigure; \
	fi
.PHONY: terragrunt.init

terragrunt.state: terragrunt.validate
	@if [ -z "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/prod && $(terragrunt) state ${command} --terragrunt-source-update; \
	fi
	@if [ -z "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/ && $(terragrunt) state ${command} --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/${stage} && $(terragrunt) state ${command} --terragrunt-source-update; \
	fi
.PHONY: terragrunt.state

terragrunt.import: terragrunt.validate
	@if [ -z "${stage}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/ && $(terragrunt) import ${command} ; \
	else \
		cd ${TERRAFORM_DIR}/us-east-1/${stage}/ && $(terragrunt) import ${command} ; \
	fi
.PHONY: terragrunt.import
