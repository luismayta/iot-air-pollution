#
# See ./CONTRIBUTING.rst
#
.PHONY: keybase.help

keybase.help:
	@echo '    keybase:'
	@echo ''
	@echo '        keybase                      help keybase'
	@echo '        keybase.setup                Setup dependences for keybase'
	@echo ''

keybase: clean
	make keybase.help

keybase.setup: clean
	@echo "=====> make dependences for ${TEAM}..."
	mkdir -p ${KEYS_PEM_DIR}
	mkdir -p ${KEYS_PUB_DIR}
	mkdir -p ${KEYS_KEY_DIR}
	mkdir -p ${KEYS_CSR_DIR}
	mkdir -p ${KEYS_PRIVATE_DIR}
	mkdir -p ${PASSWORD_DIR}
	touch ${PASSWORD_DIR}/${PROJECT}-staging.txt
	touch ${PASSWORD_DIR}/${PROJECT}-prod.txt
	@echo ${MESSAGE_HAPPY}
