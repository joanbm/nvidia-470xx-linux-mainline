# EL9 Patches for 470.x NVIDIA Driver Stream

EL9 includes RHEL 9.x and its derivatives, such AlmaLinux,
Rocky Linux and others. These patches were built and tested
against Alma Linux 9.7 and 9.8.

## Why?

Ordinarily, 5.x kernels are still compatible with 470xx
drivers. HOWEVER, RedHat backports some patches from 6.x kernels
back to 5.x without bumping the major kernel version number.
As of this writing, we were at `5.14.0-687.29.1.el9_8.x86_64`.

One of the major changes is the replacement of `follow_pfn()`
by the GPL `follow_pfnmap_start/end()`. This required an
addition of a shim wrapper to allow it to continue to work,
which is also included.

## Approach

We rely as much as possible on pre-built `dnf` `rpm` packages
provided by the vendors and minimally patch after `dnf install`.

NVIDIA's official repositories for EL9 discontinued the 470.x
stream, so it's only available in EL8 repositories. We pre-install
the driver and its components from those repositories first,
then apply the patches to the installed sources `/usr/src/nvidia-470.256.02`.

We then compile the shim wrapper around the backpored API, install
it, and make its symbols available to the driver. Along with the
other DRM-related changes found in the other patches, the driver
is rebuilt and re-installed using `dkms`.

## Results

Requires `dnf install nvidia-driver-NVML` to work:

```bash
[root@host nvidia-470xx-linux-mainline]# nvidia-smi
Tue Aug 11 14:19:20 2026       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 470.256.02   Driver Version: 470.256.02   CUDA Version: 11.4     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla K20Xm         Off  | 00000000:0A:00.0 Off |                  Off |
| N/A   18C    P0    54W / 235W |      0MiB /  6083MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   1  Tesla K20Xm         Off  | 00000000:0D:00.0 Off |                  Off |
| N/A   16C    P0    50W / 235W |      0MiB /  6083MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
[root@host nvidia-470xx-linux-mainline]# uname -a
Linux host 5.14.0-687.29.1.el9_8.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 23 16:18:48 EDT 2026 x86_64 x86_64 x86_64 GNU/Linux
```

# EOF
