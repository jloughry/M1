documentation = README.md

all:
	@echo "There is nothing in this directory to build."

vi:
	vi $(documentation)

spell:
	aspell --lang=en_GB check $(documentation)

clean:
	rm -f $(documentation).bak

include common.mk

