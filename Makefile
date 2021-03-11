#
# See ./docs/contributing.md
#

OS := $(shell uname)

.PHONY: help
.DEFAULT_GOAL := help

HAS_PIP := $(shell command -v pip;)
HAS_PIPENV := $(shell command -v pipenv;)

ifdef HAS_PIPENV
	PIPENV_RUN:=pipenv run
	PIPENV_INSTALL:=pipenv install
else
	PIPENV_RUN:=
	PIPENV_INSTALL:=
endif

TEAM := luismayta
REPOSITORY_DOMAIN:=github.com
REPOSITORY_OWNER:=${TEAM}
AWS_VAULT ?= ${TEAM}
PROJECT := iot-air-pollution

PYTHON_VERSION=3.8.0
NODE_VERSION=14.15.5
PYENV_NAME="${PROJECT}"
GIT_IGNORES:=python,node,go,zsh
GI:=gi

# Configuration.
SHELL ?=/bin/bash
ROOT_DIR=$(shell pwd)
MESSAGE:=🍺️
MESSAGE_HAPPY?:="Done! ${MESSAGE}, Now Happy Hacking"
SOURCE_DIR=$(ROOT_DIR)
PROVISION_DIR:=$(ROOT_DIR)/provision
FILE_README:=$(ROOT_DIR)/README.rst
KEYBASE_VOLUME_PATH ?= /Keybase
KEYBASE_PATH ?= ${KEYBASE_VOLUME_PATH}/team/${TEAM}
KEYS_PEM_DIR:=${KEYBASE_PATH}/pem
KEYS_KEY_DIR:=${KEYBASE_PATH}/key
KEYS_CSR_DIR:=${KEYBASE_PATH}/csr
KEYS_PUB_DIR:=${KEYBASE_PATH}/pub
KEYS_PRIVATE_DIR:=${KEYBASE_PATH}/private/key_file/${PROJECT}
PASSWORD_DIR:=${KEYBASE_PATH}/password

PATH_DOCKER_COMPOSE:=docker-compose.yml -f provision/docker-compose

DOCKER_SERVICE_DEV:=app
DOCKER_SERVICE_TEST:=app

docker-compose:=$(PIPENV_RUN) docker-compose

docker-test:=$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/test.yml
docker-dev:=$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/dev.yml

docker-test-run:=$(docker-test) run --rm ${DOCKER_SERVICE_TEST}
docker-dev-run:=$(docker-dev) run --rm --service-ports ${DOCKER_SERVICE_DEV}
docker-yarn-run:=$(docker-dev) run --rm --service-ports ${DOCKER_SERVICE_YARN}

terragrunt:=terragrunt

include provision/make/*.mk

help:
	@echo '${MESSAGE} Makefile for ${PROJECT}'
	@echo ''
	@echo 'Usage:'
	@echo '    environment               create environment with pyenv'
	@echo '    readme                    build README'
	@echo '    execute                   execute examples'
	@echo '    setup                     install requirements'
	@echo ''
	@make ansible.help
	@make aws.help
	@make alias.help
	@make docker.help
	@make test.help
	@make keybase.help
	@make terragrunt.help
	@make git.help
	@make utils.help
	@make python.help
	@make yarn.help
	@make zappa.help

## Create README.md by building it from README.yaml
readme:
	@gomplate --file $(README_TEMPLATE) \
		--out $(README_FILE)

setup:
	@echo "=====> install packages..."
	make python.setup
	make python.precommit
	@cp -rf provision/git/hooks/prepare-commit-msg .git/hooks/
	@[ -e ".env" ] || cp -rf .env.example .env
	make yarn.setup
	make git.setup
	@echo ${MESSAGE_HAPPY}

execute:
	@echo "=====> execute examples..."
	$(PIPENV_RUN) python air_pollution/publisher.py
	@echo ${MESSAGE_HAPPY}

environment:
	@echo "=====> loading virtualenv ${PYENV_NAME}..."
	make python.environment
	@echo ${MESSAGE_HAPPY}
