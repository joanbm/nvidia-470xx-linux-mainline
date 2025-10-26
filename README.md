nvidia-470xx-linux-mainline
===========================
Patches for the officially unsupported nvidia-470xx driver to work with the latest Linux kernels.

This repository is roughly aligned with the [Arch Linux User Repository nvidia-470xx-dkms](https://aur.archlinux.org/packages/nvidia-470xx-dkms) package, but may contain newer patches.

# Quickstart (Debian, Ubuntu and derivatives)

```sh
sudo apt install git wget build-essential linux-headers-generic libglvnd-dev
git clone https://github.com/joanbm/nvidia-470xx-linux-mainline
cd nvidia-470xx-linux-mainline
./install
```

# Scripts

* `./install`: Download the driver, apply the patches, and launch the installer.
* `./buildtest`: Download the driver, apply the patches, and build the kernel driver. For development.
* `./download`: Download the driver from the NVIDIA website.
* `./extract_and_patch`: Extract the driver and apply the patches, and nothing else. For development.

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

# Disclaimer

THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL ANY PARTY BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
