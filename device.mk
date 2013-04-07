#
# Copyright 2012 The Android Open Source Project
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

DEVICE_PACKAGE_OVERLAYS += device/ingenic/$(TARGET_BOARD_NAME)/overlay

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/ingenic/$(TARGET_BOARD_NAME)/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES := \
    mke2fs          \
    mke2fs_host     \
    e2fsck          \
    e2fsck_host

PRODUCT_PACKAGES += \
    hwcomposer.xb4780    \
    camera.xb4780        \
    audio.primary.xb4780 \
    audio_policy.xb4780  \
    sensors.xb4780       \
    lights.xb4780        \
    libdmmu              \
    libjzipu

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/ingenic/$(TARGET_BOARD_NAME)/$(TARGET_BOARD_NAME)-vendor.mk)

$(call inherit-product, hardware/ingenic/xb4780/libGPU/gpu.mk)

# Wifi
#BOARD_WLAN_DEVICE_REV := 
#WIFI_BAND             := 802_11_ABG
#$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf              \
    $(LOCAL_PATH)/config/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf                            \
    $(LOCAL_PATH)/config/init.rc:root/init.rc                                                 \
    $(LOCAL_PATH)/config/init.board.rc:root/init.$(TARGET_BOARD_NAME).rc                      \
    $(LOCAL_PATH)/config/init.board.usb.rc:root/init.$(TARGET_BOARD_NAME).usb.rc              \
    $(LOCAL_PATH)/config/fstab.board:root/fstab.$(TARGET_BOARD_NAME)                          \
    $(LOCAL_PATH)/config/vold.fstab:system/etc/vold.fstab                                     \
    $(LOCAL_PATH)/config/ueventd.board.rc:root/ueventd.$(TARGET_BOARD_NAME).rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/disk_preparing.sh:system/etc/disk_preparing.sh                       

# Media Codecs List
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/media_profiles.xml:system/etc/media_profiles.xml                    \
    $(LOCAL_PATH)/config/media_codecs.xml:system/etc/media_codecs.xml

# wifi drivers and firmwares
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/wifi/IW/IW8101/fw_iw8101.bin:system/lib/wifi/firmware/iw8101/fw_bcmdhd.bin \
	$(LOCAL_PATH)/wifi/IW/IW8101/nvram_iw8101.txt:system/lib/wifi/firmware/iw8101/nvram_iw8101.txt

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/excluded-input-devices.xml:system/etc/excluded-input-devices.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.faketouch.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.faketouch.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml

#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml

#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/audio_policy.conf:system/etc/audio_policy.conf

# logo
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/logo.rle:root/logo.rle                                                    \
    $(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip

# Key layout file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/gpio-keys.kl:/system/usr/keylayout/gpio-keys.kl

#############################################################################################

PRODUCT_AAPT_CONFIG := normal ldpi mdpi
PRODUCT_AAPT_PREF_CONFIG := ldpi
PRODUCT_LOCALES := zh_CN zh_TW en_US en_GB fr_FR it_IT de_DE es_ES cs_CZ ru_RU ko_KR ar_EG ja_JP

PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.sf.lcd_density=160                           \
    persist.sys.timezone=Asia/Shanghai              \
    testing.mediascanner.skiplist=/storage/host-udisk/,/storage/udisk/

ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.debuggable=1              \
    service.adb.root=1
endif

PRODUCT_PROPERTY_OVERRIDES +=    \
    wifi.interface=wlan0         \
    wifi.supplicant_scan_interval=15

#PRODUCT_PROPERTY_OVERRIDES +=    \
    rild.libpath=/system/lib/libreference-ril.so    \
    rild.libargs=-d /dev/ttyUSB2                    \
    mobiled.libpath=/system/lib/libmobiled.so

PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.board.hdmi.support=true                      \
    ro.board.hdmi.device=HDMI,LCD,SYNC              \
    ro.board.hdmi.hotplug.support=true              \

PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.board.tvout.support=false                    \
    ro.board.hasethernet=ethernet                   \
    ro.board.haspppoe=pppoe

# H/W composition disabled
#PRODUCT_PROPERTY_OVERRIDES +=    \
    debug.sf.hw=1

PRODUCT_PROPERTY_OVERRIDES +=    \
    ro.opengles.version=131072

#PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

#PRODUCT_PROPERTY_OVERRIDES := \
        net.dns1=8.8.8.8 \
        net.dns2=8.8.4.4


