#
# See ./docs/contributing.md
#

KEYBASE_VOLUME_PATH ?= /Keybase
KEYBASE_TEAM_PATH ?=${KEYBASE_VOLUME_PATH}/${KEYBASE_PATH_TEAM_NAME}/${KEYBASE_OWNER}
KEYBASE_PROJECT_PATH ?= ${KEYBASE_TEAM_PATH}/${REPOSITORY_DOMAIN}/${REPOSITORY_OWNER}/${PROJECT}

.PHONY: keybase.help
keybase.help:
	@echo '    keybase:'
	@echo ''
	@echo '        keybase                      help keybase'
	@echo '        keybase.env                  Environment path for keybase'
	@echo '        keybase.setup                Setup dependences for keybase'
	@echo ''

keybase:
	make keybase.help

keybase.env:
	@echo "==> make environment for ${TEAM}..."
	@mkdir -p ${KEYBASE_PROJECT_PATH}/gpg
	@mkdir -p ${KEYBASE_PROJECT_PATH}/{staging,prod,dev,core}/{pem,private,password,pub,openssl}
	@echo ${MESSAGE_HAPPY}

keybase.setup:
	@echo "==> make dependences for ${TEAM}..."
	@mkdir -p ${KEYBASE_PROJECT_PATH}/gpg
	@mkdir -p ${KEYBASE_PROJECT_PATH}/{staging,prod,dev,core}/{pem,private,password,pub,openssl}
	@echo ${MESSAGE_HAPPY}
