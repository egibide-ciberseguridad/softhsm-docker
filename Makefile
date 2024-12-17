#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------
	@echo build
	@echo start / stop / restart
	@echo workspace
	@echo test
	@echo logs / stats
	@echo clean
	@echo ----------------------

_header:
	@echo -------
	@echo SoftHSM
	@echo -------

build:
	@docker compose build --pull

_start-command:
	@docker compose up -d --remove-orphans softhsm-server

start: _header _start-command

stop:
	@docker compose stop

restart: stop start

workspace:
	@docker compose run --rm softhsm-client /bin/bash

test:
	@docker compose run --rm softhsm-client /bin/bash -c 'pkcs11-tool --module /usr/local/lib/libpkcs11-proxy.so --list-slots'

logs:
	@docker compose logs softhsm-server

stats:
	@docker stats

clean:
	@docker compose down -t 0 -v --remove-orphans
