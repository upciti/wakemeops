SHELL := bash

COMPONENTS := $(shell ls ops2deb-*yml | cut -f2 -d "-" | cut -f1 -d ".")

OUTPUT_BASE_PATH := build

export OPS2DEB_REPOSITORY := http://deb.wakemeops.com/ stable

default:
	@echo -e 'Usage:'
	@echo -e '\nprerequisite                                                   '
	@echo '* install-wakemeops           add wakemeops repository              '
	@echo -e '\nops2deb                                                        '
	@echo '* generate                    generate all source packages          '
	@echo '* generate-{component}        generate source packages for component'
	@echo '* build                       build all sources packages            '
	@echo '* build-{component}           build sources packages for component  '
	@echo '* update                      check binaries updates                '
	@echo '* format                      format all configuration files        '
	@echo -e '\nchecks                                                         '
	@echo '* install-packages            install generated packages            '
	@echo '* check-packages              check generated packages              '
	@echo -e '\naptly                                                          '
	@echo '* push-{component}            push to s3 repository                 '
	@echo '* publish                     publish to s3 repository              '
	@echo -e '\ndocumentation                                                  '
	@echo '* docs                        run mkdocs build                      '
	@echo '* docs-dev                    run mkdocs serve from wakemebot image '
	@echo '* docs-generate               generate documentation with wakemebot '

install-wakemeops:
	curl https://gitlab.com/upciti/wakemeops/-/snippets/2189589/raw/main/install.sh | bash -s $(COMPONENTS)

generate: $(foreach component,$(COMPONENTS),generate-$(component))

generate-%:
	mkdir -p $(OUTPUT_BASE_PATH)/$*
	ops2deb generate -c ./ops2deb-$*.yml -o $(OUTPUT_BASE_PATH)/$*


build: $(foreach component,$(COMPONENTS),build-$(component))

build-%:
	ops2deb build -o $(OUTPUT_BASE_PATH)/$*

update:
	for component in $(COMPONENTS); do \
		ops2deb update \
		-c ops2deb-$${component}.yml \
		--output-file ops2deb-$${component}.log; \
	done


format:
	for component in $(COMPONENTS); do \
		ops2deb format \
		-c ops2deb-$${component}.yml; \
	done

install-packages:
	apt-get update -yq
	PACKAGE_PATH=$$(find ./$(OUTPUT_BASE_PATH) -name "*.deb"); \
		[[ -z "$$PACKAGE_PATH" ]] && true || apt-get install -y $$PACKAGE_PATH

check-packages:
	export PACKAGE_PATH=$$(find $(OUTPUT_BASE_PATH) -name "*.deb"); \
	for package in $$PACKAGE_PATH; do \
		n=$$(dpkg --info $$package | sed -n "s/ Package. \(.*\)/\1/p"); \
		dpkg -s $$n || exit 77; \
	done

push-%:
	if [ -d "build/$*" ]; then \
		wakemebot aptly push wakemeops-$* \
			$(OUTPUT_BASE_PATH)/$* \
			--server /host/data/aptly/aptly.sock; \
	fi

publish:
	curl -v -f -s -XPUT --unix-socket /host/data/aptly/aptly.sock \
	-H 'Content-Type: application/json' --data \
	"{\"ForceOverwrite\":true, \"Signing\" : \
	{\"GpgKey\":\"wakemebot@protonmail.com\", \"Batch\":true}}" \
	"http://_/api/publish/s3:wakemeops-eu-west-3:./stable"

docs:
	@mkdocs build -d public

docs-dev:
	@docker run -u $$(id -u) --pull=always --rm -it -p 8000:8000 -w /docs -v $$(pwd):/docs upciti/wakemebot:main mkdocs serve --dev-addr=0.0.0.0:8000

docs-update:
	@docker run --pull=always -u $$(id -u) --rm -it -w /docs -v $$(pwd):/docs upciti/wakemebot:main wakemebot docs

.PHONY: install-wakemeops install-packages check-packages publish docs docs-dev docs-update generate build format update
