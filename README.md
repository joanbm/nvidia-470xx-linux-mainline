nvidia-470xx-linux-mainline
===========================
Patches for the officially unsupported nvidia-470xx driver to work with the latest Linux kernels.

This repository is roughly aligned with the [Arch Linux User Repository nvidia-470xx-dkms](https://aur.archlinux.org/packages/nvidia-470xx-dkms) package, but may contain newer patches.

# Scripts

* `./install`: Download the driver, apply the patches, and launch the installer.
* `./buildtest [kernel_release]`: Download the driver, apply the patches, and build the kernel driver for the given release. For development.
* `./download_and_patch`: Download the driver, apply the patches, and nothing else. For development.

# Kernel parameters

If once the driver is installed, you run into conflicts with Nouveau or NOVA, run the following command to blacklist the module:

```sh
sudo install -Dm644 /dev/stdin "/usr/lib/modprobe.d/nvidia-470xx-linux-mainline.conf" <<END
blacklist nouveau
blacklist nova_core
blacklist nova_drm
END
```

Or, you can add the following parameters to your kernel command line: `module_blacklist=nouveau,nova_core,nova_drm`
