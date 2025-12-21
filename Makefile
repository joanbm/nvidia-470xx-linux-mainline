.PHONY: download build-% test test-% test-%-staging

CONTAINER_ENGINE := $(shell command -v podman >/dev/null 2>&1 && echo podman || echo docker)

download:
	./download

build-%: download
	$(CONTAINER_ENGINE) build -f Dockerfile_$*_kernel -t nvidia-470xx-$* .

test-%: build-%
	$(CONTAINER_ENGINE) run --network none --rm nvidia-470xx-$*

test-%-staging: build-%
	$(CONTAINER_ENGINE) run --network none --rm --env NVIDIA_470XX_APPLY_STAGING_PATCHES=1 nvidia-470xx-$*

test: test-legacy test-mainline test-stable test-legacy-staging test-mainline-staging test-stable-staging
