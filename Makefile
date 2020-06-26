appName := $(shell basename $(shell pwd))
quicktype := quicktype --no-initializers --protocol equatable -l swift --swift-5-support

.PHONY: install
install:
	brew update
	brew bundle

.PHONY: bootstrap
bootstrap:
	# $(eval path = Sources/$(appName)/Config)
	# $(quicktype) $(path)/config.json -o $(path)/Config.swift
	xcodegen
	open $(appName).xcodeproj