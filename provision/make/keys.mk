#
# See ./docs/source/CONTRIBUTING.rst
#
.PHONY: keys.help

keys.help:
	@echo '    keys:'
	@echo ''
	@echo '        keys                      help keys'
	@echo '        keys.make                 make key openssl by stage'
	@echo ''

keys:
	make keys.help

keys.make:
	mkdir -p ${KEYBASE_PATH}/${stage}/openssl/
	openssl genrsa -out ${PROJECT}-${stage}.pem 2048
	openssl rsa -in ${PROJECT}-${stage}.pem -pubout -out ${PROJECT}-${stage}.public.pem
	mv ${PROJECT}-${stage}.pem ${KEYBASE_PATH}/${stage}/openssl/${PROJECT}-${stage}.pem
	mv ${PROJECT}-${stage}.public.pem ${KEYBASE_PATH}/${stage}/openssl/${PROJECT}-${stage}.pem