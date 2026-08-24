.PHONY: download build-% test test-% test-%-staging

CONTAINER_ENGINE := $(shell command -v podman >/dev/null 2>&1 && echo podman || echo docker)

download:
	./download

# No need to depend on downloaded driver for EL9, we use a repo version
# that needs patching
build-el9: Dockerfile_el9_kernel
	$(CONTAINER_ENGINE) build -f Dockerfile_el9_kernel -t nvidia-470xx-el9 .

build-%: download
	$(CONTAINER_ENGINE) build -f Dockerfile_$*_kernel -t nvidia-470xx-$* .

test-%: build-%
	$(CONTAINER_ENGINE) run --network none --rm nvidia-470xx-$*

test-el9-staging: build-el9
	echo "No staging patches applicable for EL9 containers. Skipping..."

test-%-staging: build-%
	$(CONTAINER_ENGINE) run --network none --rm --env NVIDIA_470XX_APPLY_STAGING_PATCHES=1 nvidia-470xx-$*

test: test-legacy test-mainline test-stable test-ubuntu-devel test-legacy-staging test-mainline-staging test-stable-staging test-ubuntu-devel-staging test-el9
