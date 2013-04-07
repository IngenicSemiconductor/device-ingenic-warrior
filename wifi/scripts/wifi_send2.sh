#!/system/bin/sh
echo "wifi send mod test start"
CONFIG=/data/wifitest.conf
export CONFIG
. $CONFIG
echo "P1="$P1
echo "P2="$P2
echo "P3="$P3
wl_jz_sz down >> /data/wifiinfo.txt 2>&1
wl_jz_sz mpc 0 >> /data/wifiinfo.txt 2>&1
wl_jz_sz scansuppress 1 >> /data/wifiinfo.txt 2>&1
wl_jz_sz frameburst 1 >> /data/wifiinfo.txt 2>&1
wl_jz_sz country ALL >> /data/wifiinfo.txt 2>&1
wl_jz_sz up >> /data/wifiinfo.txt 2>&1
wl_jz_sz channel "$P1" >> /data/wifiinfo.txt 2>&1
wl_jz_sz nrate -m  "$P2" >> /data/wifiinfo.txt 2>&1
wl_jz_sz txpwr1  -o -d "$P3" >> /data/wifiinfo.txt 2>&1
wl_jz_sz pkteng_start 00:11:22:33:44:55 tx 200 1000 0 >> /data/wifiinfo.txt 2>&1
echo "wifi send mod test  end"
