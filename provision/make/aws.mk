#
# See ./CONTRIBUTING.rst
#
AWS_SERVICE:=app
AWS=$(PIPENV_RUN) aws

aws.help:
	@echo '    Aws:'
	@echo ''
	@echo '        aws                            Run all help aws'
	@echo '        aws.iot.createkeys             deploy files to bucket'
	@echo ''

aws: clean
	make aws.help

aws.iot.createkeys: clean
	@if [[ -z "${stage}" ]]; then \
		make aws.help;\
	else \
		$(AWS) iot create-keys-and-certificate \
		--set-as-active \
		--certificate-pem-outfile ${KEYS_CSR_DIR}/${PROJECT}-${stage}.cert.pem \
		--public-key-outfile ${KEYS_CSR_DIR}/${PROJECT}-${stage}.public.key \
		--private-key-outfile ${KEYS_CSR_DIR}/${PROJECT}-${stage}.private.key; \
	fi
