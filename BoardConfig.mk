# Copyright 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true
TARGET_PROVIDES_INIT_RC := true

TARGET_ARCH := mips
TARGET_ARCH_VARIANT := mips32r2-fp-xburst
#TARGET_ARCH_VARIANT := mips32r2-xb-fp
# TARGET_CPU_VARIANT := mips32r2-fp-xburst
ARCH_MIPS_PAGE_SHIFT := 12
TARGET_CPU_ABI := mips
TARGET_CPU_ABI2 := mips
TARGET_CPU_SMP := true
TARGET_FOR_CTS := false
TARGET_BOARD_PLATFORM := xb4780
TARGET_BOARD_PLATFORM_GPU := SGX540
TARGET_BOOTLOADER_BOARD_NAME := warrior
TARGET_AAPT_CHARACTERISTICS := tablet
PRODUCT_VENDOR_KERNEL_HEADERS := hardware/ingenic/xb4780/kernel-headers
TARGET_USERIMAGES_USE_EXT4 := true
# system size is 640M
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 671088640
# data size is 960M
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1006632960
# cache size is 30M
BOARD_CACHEIMAGE_PARTITION_SIZE := 31457280
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

BOARD_HAVE_BLUETOOTH := false;
BOARD_HAVE_BLUETOOTH_BCM := false;
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/ingenic/warrior/bluetooth

BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := mem=256M@0x0 mem=752M@0x30000000 console=ttyS3,57600n8 ip=off root=/dev/ram0 rw rdinit=/init pmem_camera=16M@0x5f000000


#camera configure
BOARD_HAS_CAMERA := true
CAMERA_SUPPORT_VIDEOSNAPSHORT := false
COVERT_WITH_SOFT := true
CAMERA_VERSION := 1

# Wi-Fi hardware selection
BOARD_WIFI_HARDWARE := IW8101
PRODUCT_DEFAULT_WIFI_CHANNELS := 13

ifeq ($(strip $(BOARD_WIFI_HARDWARE)), IW8101)
BOARD_WLAN_DEVICE := bcmdhd
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
# WIFI_DRIVER_MODULE_PATH     := "/system/lib/wifi/modules/iw/dhd.ko"
# WIFI_DRIVER_MODULE_NAME     := "dhd"
endif


TARGET_RECOVERY_UI_LIB := librecovery_ui_warrior
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

WITH_JIT := true
WITH_DEXPREOPT := true
