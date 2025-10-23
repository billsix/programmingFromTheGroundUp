.DEFAULT_GOAL := help

CONTAINER_CMD = podman
CONTAINER_NAME = programmingfromthegroundup
FILES_TO_MOUNT = -v ./docs:/pgu/docs:Z \
                 -v ./src:/pgu/src:Z
OUTPUT_DIR_TO_MOUNT = -v ./output/:/output/:Z

USE_X = -e DISPLAY=$(DISPLAY) \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--security-opt label=type:container_runtime_t


.PHONY: all
all: shell ## Build the image and get a shell in it

.PHONY: image
image: ## Build a $(CONTAINER_CMD)
	$(CONTAINER_CMD) build -t $(CONTAINER_NAME) .

.PHONY: shell
shell:  ## Get Shell into a ephermeral container made from the image
	$(CONTAINER_CMD) run -it --rm \
		--entrypoint /bin/bash \
		$(FILES_TO_MOUNT) \
		$(OUTPUT_DIR_TO_MOUNT) \
		$(USE_X) \
		-v ./entrypoint/shell.sh:/shell.sh:Z \
		-v ./entrypoint/format.sh:/format.sh:Z \
		$(CONTAINER_NAME) \
		/shell.sh

.PHONY: html
html:  ## Build the book in HTML form
	$(CONTAINER_CMD) run -it --rm \
		--entrypoint /bin/bash \
		$(FILES_TO_MOUNT) \
		$(OUTPUT_DIR_TO_MOUNT) \
		-v ./entrypoint/html.sh:/html.sh:Z \
		$(CONTAINER_NAME) \
		/html.sh


.PHONY: pdf
pdf:  ## Build the book in PDF form
	$(CONTAINER_CMD) run -it --rm \
		--entrypoint /bin/bash \
		$(FILES_TO_MOUNT) \
		$(OUTPUT_DIR_TO_MOUNT) \
		-v ./entrypoint/pdf.sh:/pdf.sh:Z \
		$(CONTAINER_NAME) \
		/pdf.sh




.PHONY: help
help:
	@grep --extended-regexp '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
