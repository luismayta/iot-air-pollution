## Packer
.PHONY: packer.help
PACKER_VERSION := 1.3.1
PACKER_DIR:=$(PROVISION_DIR)/packer
packer := packer

packer.help:
	@echo '    packer:'
	@echo ''
	@echo '        packer.validate        validate by ami=python'
	@echo '        packer.build           build by ami=python'
	@echo ''

packer:
	make packer.help

packer.update:
	@ansible-galaxy install -r "${PACKER_DIR}/${ami}/provisioners/ansible/"requirements.yml \
			   --roles-path "${PACKER_DIR}/${ami}/provisioners/ansible/"roles/contrib --force

packer.validate:
	cd "${PACKER_DIR}/${ami}/" && $(packer) validate packer.json

packer.build:
	cd "${PACKER_DIR}/${ami}/" && $(packer) build packer.json
