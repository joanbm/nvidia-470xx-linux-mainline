obj-m += nvidia-pfn-shim.o

# Running on an actual host:
KDIR_HOST := /lib/modules/$(shell uname -r)/build

# Running in a CI/CI container:
KDIR_CONTAINER := $(firstword $(wildcard /usr/src/kernels/*))

# Pick one of the two, whichever exists first
KDIR ?= $(if $(wildcard $(KDIR_HOST)),$(KDIR_HOST),$(KDIR_CONTAINER))

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
