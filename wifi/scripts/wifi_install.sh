#!/system/bin/sh
echo "install data start"
busybox cp /mnt/flash/fw_iw8101.bin /system/lib/wifi/firmware/iw8101/ >> /data/wifiinfo.txt 2>&1
busybox cp /mnt/flash/wl_jz_sz /system/bin/ >> /data/wifiinfo.txt 2>&1
chmod 777 /system/bin/wl_jz_sz >> /data/wifiinfo.txt 2>&1
sync >> /data/winstallinfo.txt 2>&1
echo "install data end"
