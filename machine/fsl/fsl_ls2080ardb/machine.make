# Makefile fragment for Freescale LS2080ARDB

# Copyright 2016 Freescale Semiconductor, Inc.
#
# SPDX-License-Identifier:     GPL-2.0

ONIE_ARCH ?= armv8a
SWITCH_ASIC_VENDOR = qemu

VENDOR_REV ?= ONIE

# Translate hardware revision to ONIE hardware revision
ifeq ($(VENDOR_REV),ONIE)
  MACHINE_REV = 0
else
  $(warning Unknown VENDOR_REV '$(VENDOR_REV)' for MACHINE '$(MACHINE)')
  $(error Unknown VENDOR_REV)
endif

XTOOLS_ENABLE = yes

ifeq ($(XTOOLS_ENABLE),no)
  TARGET = aarch64-linux-gnu
  CROSSBIN = $(HOME)/gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu/bin
  GCC_VERSION = 5.3.1
  XTOOLS_LIBC = glibc
  XTOOLS_LIBC_VERSION = 2.21
  LINUX_VERSION = 4.1.23
  STRACE_ENABLE = no
  XTOOLS_BUILD_STAMP = $(CROSSBIN)/$(TARGET)-gcc
endif

UBOOT_ENABLE = no
# Set the desired U-Boot version
UBOOT_VERSION = 2015.10

UBOOT_MACHINE = ls2080ardb_ONIE_$(MACHINE_REV)
KERNEL_DTB = freescale/fsl-ls2080a-rdb.dtb
KERNEL_DTB_PATH = dts/$(KERNEL_DTB)

# Enable UEFI support
UEFI_ENABLE = yes

# Enable GRUB support
GRUB_ENABLE = yes

# Enable building firmware updates
FIRMWARE_UPDATE_ENABLE = no

# Specify any extra parameters that you'd want to pass to the onie linux
# kernel command line in EXTRA_CMDLINE_LINUX env variable. Eg:
#
#EXTRA_CMDLINE_LINUX ?= install_url=http://server/path/to/installer debug earlyprintk=serial
#
# NOTE: You can give multiple space separated parameters

EXTRA_CMDLINE_LINUX = console=ttyS1,115200 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256

# Specify the default menu option when booting a recovery image.  Valid
# values are "rescue" or "embed" (without double-quotes). This
# parameter defaults to "rescue" mode if not specified here.

RECOVERY_DEFAULT_ENTRY = embed

PXE_EFI64_ENABLE = yes

# The VENDOR_VERSION string is appended to the overal ONIE version
# string.  HW vendors can use this to appended their own versioning
# information to the base ONIE version string.
# VENDOR_VERSION = .12.34

# Vendor ID -- IANA Private Enterprise Number:
# http://www.iana.org/assignments/enterprise-numbers
VENDOR_ID = 33118

#-------------------------------------------------------------------------------
#
# Local Variables:
# mode: makefile-gmake
# End: