SHELL := bash

COMPONENTS := $(shell ls ops2deb-*yml | cut -f2 -d "-" | cut -f1 -d ".")

OUTPUT_BASE_PATH := build

export OPS2DEB_REPOSITORY := http://deb.wakemeops.com/ stable

default:
	@echo -e 'Usage:'
	@echo -e '\nprerequisite                                                   '
	@echo '* install-wakemeops           add wakemeops repository              '
	@echo -e '\nops2deb                                                        '
	@echo '* generate                    generate deb from yaml                '
	@echo '* build                       build generated sources               '
	@echo '* update                      check binaries updates                '
	@echo -e '\nchecks                                                         '
	@echo '* install-packages            install generated packages            '
	@echo '* check-packages              check generated packages              '
	@echo -e '\naptly                                                          '
	@echo '* aptly-push                  push to s3 repository                 '
	@echo '* aptly-publish               publish to s3 repository              '
	@echo -e '\ndocumentation                                                  '
	@echo '* docs                        run mkdocs build                      '
	@echo '* docs-dev                    run mkdocs serve from wakemebot image '

install-wakemeops:
	curl https://gitlab.com/upciti/wakemeops/-/snippets/2189589/raw/main/install.sh | bash -s $(COMPONENTS)

install-packages: install-wakemeops
	PACKAGE_PATH=$$(find $(OUTPUT_BASE_PATH) -name "*.deb"); \
		dpkg -i $$PACKAGE_PATH || true
	apt-get update -yq
	apt-get install -fy

generate:
	for component in $(COMPONENTS); do \
		$(MAKE) ops2deb-generate COMPONENT=$${component}; \
	done

build:
	for component in $(COMPONENTS); do \
		$(MAKE) ops2deb-build COMPONENT=$${component}; \
	done

update:
	for component in $(COMPONENTS); do \
		ops2deb update -c ops2deb-$${component}.yml --output-file ops2deb-$${component}.log; \
	done

ops2deb-generate:
	mkdir -p $(OUTPUT_BASE_PATH)/$${COMPONENT}
	ops2deb generate -c ./ops2deb-$${COMPONENT}.yml -w $(OUTPUT_BASE_PATH)/$${COMPONENT}

ops2deb-build:
	mkdir -p $(OUTPUT_BASE_PATH)/$${COMPONENT}
	ops2deb build -w $(OUTPUT_BASE_PATH)/$${COMPONENT}

check-packages:
	export PACKAGE_PATH=$$(find $(OUTPUT_BASE_PATH) -name "*.deb"); \
	for package in $$PACKAGE_PATH; do \
		n=$$(dpkg --info $$package | sed -n "s/ Package. \(.*\)/\1/p"); \
		dpkg -s $$n || exit 77; \
	done

aptly-push:
	for component in $(COMPONENTS); do \
		wakemebot aptly push wakemeops-$${component} \
		$(OUTPUT_BASE_PATH)/$${component}/*.deb \
		--server /host/data/aptly/aptly.sock; \
	done

aptly-publish:
	curl -v -f -s -XPUT --unix-socket /host/data/aptly/aptly.sock \
	-H 'Content-Type: application/json' --data \
	"{\"ForceOverwrite\":true, \"Signing\" : \
	{\"GpgKey\":\"wakemebot-dev@upciti.com\", \"Batch\":true}}" \
	"http://_/api/publish/s3:wakemeops-eu-west-3:./stable"

docs:
	@mkdocs build -d public

docs-dev:
	@docker run --rm -it -p 8000:8000 -w /docs -v $$(pwd):/docs upciti/wakemebot:main mkdocs serve --dev-addr=0.0.0.0:8000

.PHONY: install-wakemeops install-packages generate build update ops2deb-generate ops2deb-build check-packages aptly-push aptly-publish docs docs-dev
