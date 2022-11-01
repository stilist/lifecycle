.DEFAULT_GOAL := lint
.PHONY: all \
	lint \
	lint-data \
	format-schema \
	test

DATA_FILES := $(wildcard data/**/*.json)
CUE_SCHEMA := data/schema.cue

all: lint-data

test: lint

lint: format-schema lint-data

lint-data:
	@cue vet \
	  --all-errors \
	  --concrete \
	  --strict \
	  "${CUE_SCHEMA}" \
	  ${DATA_FILES}
	@echo "[OK] Linted data"

format-schema:
	@cue fmt \
	  --all-errors \
	  --simplify \
	  --strict \
	  "${CUE_SCHEMA}"
	@echo "[OK] Formatted ${CUE_SCHEMA}"
