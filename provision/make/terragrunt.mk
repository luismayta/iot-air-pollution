## Terragrunt
.PHONY: terragrunt.help
TERRAFORM_VERSION := 0.12.6
TERRAFORM_DIR:=$(PROVISION_DIR)/terraform

terragrunt.help:
	@echo '    terragrunt:'
	@echo ''
	@echo '        terragrunt                 Apply all'
	@echo '        terragrunt.init            Init download dependences terraform'
	@echo '        terragrunt.encrypt         encrypt by stage'
	@echo '        terragrunt.decrypt         decrypt by stage'
	@echo '        terragrunt                 command=(plan|apply|refresh|destroy|) by stage'
	@echo '        terragrunt.state           command=(list|mv|pull|push|rm|show|) by stage'
	@echo ''

terragrunt: clean
	@if [[ -z "${command}" ]]; then \
		make terragrunt.help;\
	fi
	@if [ -z "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/ && $(terragrunt) ${command}-all --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/${stage} && $(terragrunt) ${command} --terragrunt-source-update; \
	fi

terragrunt.encrypt: clean
	@$(PIPENV_RUN) ansible-vault encrypt ${TERRAFORM_DIR}/us-east-1/${stage}/variables.tf \
		--vault-password-file ${PASSWORD_DIR}/${PROJECT}-${stage}.txt && echo $(MESSAGE_HAPPY)

terragrunt.decrypt: clean
	@if [ -n "${stage}" ] && [ -z "${region}" ]; then \
		$(PIPENV_RUN) ansible-vault decrypt ${TERRAFORM_DIR}/us-east-1/${stage}/variables.tf \
		--vault-password-file ${PASSWORD_DIR}/${PROJECT}-${stage}.txt && echo $(MESSAGE_HAPPY); \
	elif [ -n "${stage}" ] && [ -n "${region}" ]; then \
		$(PIPENV_RUN) ansible-vault decrypt ${TERRAFORM_DIR}/${region}/${stage}/variables.tf \
		--vault-password-file ${PASSWORD_DIR}/${PROJECT}-${stage}.txt && echo $(MESSAGE_HAPPY); \
	fi

terragrunt.init: clean
	if [ -z "${stage}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/ && $(terragrunt) init --reconfigure; \
	else \
		cd ${TERRAFORM_DIR}/us-east-1/${stage}/ && $(terragrunt) init --reconfigure; \
	fi

terragrunt.state: clean
	@if [[ -z "${command}" ]]; then \
		cd ${TERRAFORM_DIR}/us-east-1/prod && $(terragrunt) state ${command} --terragrunt-source-update; \
	fi
	@if [ -z "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/ && $(terragrunt) state ${command} --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -n "${command}" ]; then \
		cd ${TERRAFORM_DIR}/us-east-1/${stage} && $(terragrunt) state ${command} --terragrunt-source-update; \
	fi
