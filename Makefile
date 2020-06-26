appName := $(shell basename $(shell pwd))
quicktype := quicktype --no-initializers --protocol equatable -l swift --swift-5-support --no-enums --multi-file-output  --type-prefix Response

.PHONY: install
install:
	brew update
	brew bundle

.PHONY: bootstrap
bootstrap:
	$(eval path = Sources/$(appName)/Models/Generated)
	rm $(path)/* || true
	$(quicktype) --src-urls quicktype-urls.json -o $(path)/Models.swift
	xcodegen
	open $(appName).xcodeproj