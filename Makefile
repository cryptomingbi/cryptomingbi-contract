all: build

O := build
SOURCES := $(shell find contracts -name '*.sol')
SHELL = bash

$(O)/debug: $(SOURCES)
	solc --bin --overwrite -o $(O)/debug contracts/MingbiCore.sol

$(O)/release: $(SOURCES)
	solc --bin --overwrite --optimize -o $(O)/release contracts/MingbiCore.sol

$(O)/abi: $(SOURCES)
	solc --abi --overwrite -o $(O)/abi contracts/MingbiCore.sol

debug: $(O)/debug $(O)/abi

build: $(O)/release $(O)/abi

clean:
	rm -rf $(O)/

.PHONY: build debug clean
