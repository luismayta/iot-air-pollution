# Ansible
.PHONY: ansible.help
USER:=ubuntu
ANSIBLE_DIR:=$(PROVISION_DIR)/ansible

ansible:
	make ansible.help

ansible.help:
	@echo '    Ansible:'
	@echo ''
	@echo '        ansible.encrypt            encrypt by stage'
	@echo '        ansible.decrypt            decrypt by stage'
	@echo '        ansible.update             Update Roles ansible by stage'
	@echo '        ansible.tag                Deploy tags by stage'
	@echo '        > examples:'
	@echo '          make ansible.tag tags=provision,databases stage=prod'
	@echo ''

ansible.encrypt:
	@$(PIPENV_RUN) ansible-vault encrypt ${ANSIBLE_DIR}/${stage}/vars/vars.yaml \
		--vault-password-file ${KEYBASE_PROJECT_PATH}/${stage}/password/${stage}.txt && \
		echo $(MESSAGE_HAPPY)

ansible.decrypt:
	@$(PIPENV_RUN) ansible-vault decrypt ${ANSIBLE_DIR}/${stage}/vars/vars.yaml \
		--vault-password-file ${KEYBASE_PROJECT_PATH}/${stage}/password/${stage}.txt && \
		echo $(MESSAGE_HAPPY)

ansible.update:
	@$(PIPENV_RUN) ansible-galaxy install -r ${ANSIBLE_DIR}/${stage}/requirements.yml \
			   --roles-path ${ANSIBLE_DIR}/${stage}/roles/contrib --force

ansible.tag:
	@$(PIPENV_RUN) ansible-playbook -v \
			${ANSIBLE_DIR}/${stage}/deploy.yaml -i ${ANSIBLE_DIR}/${stage}/inventories/aws \
			--user=${USER} --private-key=${KEYBASE_PROJECT_PATH}/${stage}/pem/${stage}.pem \
			--tags ${tags} \
			--extra-vars @${ANSIBLE_DIR}/${stage}/vars/vars.yaml \
			--vault-password-file ${KEYBASE_PROJECT_PATH}/${stage}/password/${stage}.txt && \
			echo $(MESSAGE_HAPPY)
