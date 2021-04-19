## Sops
.PHONY: sops.help

sops.help:
	@echo '    sops:'
	@echo ''
	@echo '        sops                 show help'
	@echo '        sops.env             settings environment for sops'
	@echo '        sops.setup           install dependences'
	@echo '        sops.import          import key gpg'
	@echo '        sops.export          export key gpg'
	@echo ''

sops:
	make sops.help

sops.validate:
	@echo "==> make environment for ${TEAM}..."
	@if [ -z "${GPG_KEY}" ]; then \
		echo "==> var ${GPG_KEY} is required"; \
		exit 2; \
	fi

sops.export: sops.validate
	@echo "==> export gpg key ..."
	@gpg --armor --export-secret-keys ${GPG_KEY} > ${KEYBASE_PROJECT_PATH}/gpg/key.asc
	@echo ${MESSAGE_HAPPY}
.PHONY: sops.export

sops.import:
	@echo "==> import gpg key ..."
	@gpg --import <(keybase fs read /keybase/team/${TEAM}/${REPOSITORY_DOMAIN}/${REPOSITORY_OWNER}/${PROJECT}/gpg/key.asc)
	@echo ${MESSAGE_HAPPY}
.PHONY: sops.import

sops.setup: sops.validate
	@echo "==> setup sops..."
	@echo ${MESSAGE_HAPPY}
.PHONY: sops.setup

sops.env:
	@echo "==> setup sops..."
	mkdir -p ${KEYBASE_PROJECT_PATH}/gpg
	@echo ${MESSAGE_HAPPY}
.PHONY: sops.env
