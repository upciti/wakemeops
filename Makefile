SHELL := bash

COMPONENTS := $(shell find ./ -regex "./ops2deb-[a-z]+.yml" | cut -f2 -d "-" | cut -f1 -d ".")

OUTPUT_BASE_PATH := build

ARCHITECTURE := amd64

export OPS2DEB_REPOSITORY := http://deb.wakemeops.com/wakemeops stable
export OPS2DEB_ONLY_BLUEPRINTS := $(shell git log -1 --format=short | sed -n "s/.\+pdated \(.\+\) from.\+/\1/p" | tr "\n" " ")

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
	@echo

install-wakemeops:
	curl https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | bash -s $(COMPONENTS)

generate: $(foreach component,$(COMPONENTS),generate-$(component))

generate-%:
	mkdir -p $(OUTPUT_BASE_PATH)/$*
	ops2deb generate -c ./ops2deb-$*.yml -k ./ops2deb-$*.lock.yml -o $(OUTPUT_BASE_PATH)/$*

build: $(foreach component,$(COMPONENTS),build-$(component))

build-%:
	ops2deb build -o $(OUTPUT_BASE_PATH)/$*

update:
	for component in $(COMPONENTS); do \
		ops2deb update \
		-c ops2deb-$${component}.yml \
		-k ops2deb-$${component}.lock.yml \
		--output-file ops2deb-$${component}.log; \
	done

format:
	for component in $(COMPONENTS); do \
		ops2deb format -c ops2deb-$${component}.yml || exit 77; \
	done

lock:
	for component in $(COMPONENTS); do \
		ops2deb lock -c ops2deb-$${component}.yml -k ops2deb-$${component}.lock.yml || exit 77; \
	done

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

push-%:
	[[ "$*" =~ (desktop|terminal) ]] && retain=3 || retain=100; \
	if [ -d "build/$*" ]; then \
		wakemebot aptly push wakemeops-$* \
			$(OUTPUT_BASE_PATH)/$* \
			--retain $$retain; \
	fi

publish:
	curl -v -f -s -XPUT --unix-socket /host/data/aptly/aptly.sock \
	-H 'Content-Type: application/json' --data \
	"{\"ForceOverwrite\":true, \"Signing\" : \
	{\"GpgKey\":\"wakemebot@protonmail.com\", \"Batch\":true}}" \
	"http://_/api/publish/s3:wakemeops-eu-west-3:wakemeops/stable"

exec:
	@docker run --pull=always -uroot -it  --rm -w /wakemeops -v $$(pwd):/wakemeops ghcr.io/upciti/wakemebot:latest bash

.PHONY: install-wakemeops install-packages check-packages publish docs generate build format update exec
