.ONESHELL:

.PHONY: week1 week2 download delete index

export FLASK_DEBUG := true
export WEEK1 := week1
export WEEK2 := week2

SHELL:=/bin/bash
VENV_DIR=`pwd`/.venv
PYTHON=${VENV_DIR}/bin/python

week1: 
	@eval "$$(pyenv init -)" && \
	FLASK_DEBUG=$(FLASK_DEBUG) FLASK_APP=$(WEEK1) $(PYTHON) -m flask run --port 3000 

week2: 
	@eval "$$(pyenv init -)" && \
	FLASK_DEBUG=$(FLASK_DEBUG) FLASK_APP=$(WEEK2) $(PYTHON) -m flask run --port 3000 

index: 
	./index-data.sh

delete:
	./delete-indexes.sh
	
download: 
	./download-data.sh

.PHONY: start
start:
	docker-compose -f docker/docker-compose.yml up

.PHONY: track_index_products
track_index_products:
	tail -f logs/index_products.log

.PHONY: track_index_queries
track_index_queries:
	tail -f logs/index_queries.log

.PHONY: stop
stop:
	docker-compose -f docker/docker-compose.yml down
