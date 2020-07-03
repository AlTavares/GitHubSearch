appName := $(shell basename $(shell pwd))
quicktype := quicktype --no-initializers --protocol equatable -l swift --swift-5-support --no-enums --multi-file-output  --type-prefix Response
LATEST_IOS_SDK_VERSION = $(call latestVersion,iOS)

define latestVersion
$(shell  xcrun simctl list runtimes | grep $(1) | awk '{print $$3}' | tail -n 1 | cut -c 2-)
endef

.PHONY: install
install:
	brew update
	brew bundle -v

.PHONY: bootstrap
bootstrap:
	$(eval path = Sources/$(appName)/Models/Generated)
	rm $(path)/* || true
	$(quicktype) --src-urls quicktype-urls.json -o $(path)/Models.swift
	swiftgen
	xcodegen
	open $(appName).xcodeproj

.PHONY: test_iOS
test_iOS: scheme = $(appName)
test_iOS: destination = OS=$(LATEST_IOS_SDK_VERSION),name=iPhone 11
test_iOS: test

.PHONY: test
test:
	set -o pipefail && xcodebuild -scheme $(scheme) \
		-destination '$(destination)' \
		-configuration Debug ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES test | xcpretty -c