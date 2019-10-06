# Zappa
.PHONY: zappa.help
SERVICE:=app

zappa:
	@if [[ -z "${command}" ]]; then \
		make zappa.help;\
	fi
	@if [ -n "${stage}" ] && [ -n "${command}" ]; then \
		$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/dev.yml run --rm $(SERVICE) \
			bash -c "$(PIPENV_RUN) zappa ${command} ${stage}"; \
	fi

zappa.help:
	@echo '    Zappa:'
	@echo ''
	@echo '        zappa                 command=(certify|deploy|update|undeploy), stage=(prod, staging)'
	@echo '        zappa.run 	         run by stage'
	@echo '        zappa.encrypt         encrypt'
	@echo '        zappa.decrypt         decrypt'
	@echo ''


zappa.run: clean
	@if [ -z "${stage}" ]; then \
		$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/dev.yml run --rm ${SERVICE} bash; \
	else \
		$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/${stage}.yml run --rm ${SERVICE} bash; \
	fi

zappa.encrypt: clean
	@$(PIPENV_RUN) ansible-vault encrypt ${SOURCE_DIR}/zappa_settings.json \
		--vault-password-file ${PASSWORD_DIR}/${PROJECT}-${stage}.txt && echo $(MESSAGE_HAPPY)

zappa.decrypt: clean
	@$(PIPENV_RUN) ansible-vault decrypt ${SOURCE_DIR}/zappa_settings.json \
		--vault-password-file ${PASSWORD_DIR}/${PROJECT}-${stage}.txt && echo $(MESSAGE_HAPPY)