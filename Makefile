SHELL := bash

COMPONENTS ?= $(shell ls ./blueprints)

OUTPUT_BASE_PATH := build

ARCHITECTURE := amd64

export OPS2DEB_REPOSITORY := http://deb.wakemeops.com/wakemeops stable

default:
	@echo -e 'Usage:'
	@echo -e '\nprerequisite                                                   '
	@echo '* install                     add wakemeops and install ops2deb     '
	@echo -e '\nops2deb                                                        '
	@echo '* build                       generate and build source packages    '
	@echo '* build-{component}           same but for one component only'
	@echo '* build                       build all sources packages            '
	@echo '* build-{component}           build sources packages for component  '
	@echo '* update                      update blueprints with latest releases'
	@echo '* format                      format all configuration files        '
	@echo '* lock                        update ops2deb lock files             '
	@echo -e '\nchecks                                                         '
	@echo '* install-packages            install generated packages            '
	@echo '* check-packages              check generated packages              '
	@echo -e '\ndocumentation                                                  '
	@echo '* docs                        run mkdocs serve with wakemedoc plugin'

install:
	curl https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | bash -s $(COMPONENTS)
	apt update && apt install ops2deb

build: $(foreach component,$(COMPONENTS),build-$(component))

build-%:
	ops2deb -c "./blueprints/$*/*/ops2deb.yml" -o $(OUTPUT_BASE_PATH)/$*

update:
	ops2deb update --output-file ops2deb-summary.log -v --max-versions 50
	ops2deb format --exit-code 0

format:
	ops2deb format

lock:
	ops2deb lock

install-packages:
	apt-get update -yq
	PACKAGE_PATH=$$(find ./$(OUTPUT_BASE_PATH) -name "*_$(ARCHITECTURE).deb"); \
		[[ -z "$$PACKAGE_PATH" ]] && true || apt-get install -y $$PACKAGE_PATH

check-packages:
	export PACKAGE_PATH=$$(find $(OUTPUT_BASE_PATH) -name "*_$(ARCHITECTURE).deb"); \
	for package in $$PACKAGE_PATH; do \
		n=$$(dpkg --info $$package | sed -n "s/ Package: \(.*\)/\1/p"); \
		dpkg -s $$n || exit 77; \
	done

docs:
	@docker run --pull=always -u$$UID  --rm -w /wakemeops -v $$(pwd):/wakemeops -p 8000:8000 ghcr.io/upciti/wakemebot:latest mkdocs serve -a 0.0.0.0:8000

.PHONY: install install-packages check-packages build format update docs lock
