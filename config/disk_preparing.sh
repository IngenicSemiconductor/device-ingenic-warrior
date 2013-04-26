#!/system/bin/sh
#run once

/system/bin/mount -t ext4 -o noatime,nosuid,nodev,nomblk_io_submit,errors=panic /dev/block/nddata /data

if [ ! -f /data/system/packages.list ]; then
	#######################################################################
	echo "Preparing cache partation"
	/system/bin/umount /cache
	/system/bin/mke2fs -T ext4 -L cache /dev/block/ndcache
	/system/bin/e2fsck -f -y /dev/block/ndcache
	#/system/bin/mount -t ext4 -o noatime,nosuid,nodev,nomblk_io_submit,errors=panic /dev/block/ndcache /cache
	#######################################################################
	echo "Preparing data partation"
	/system/bin/umount /data
	#/system/xbin/nanderaser nddata
	/system/bin/mke2fs -T ext4 -L cache /dev/block/nddata
	/system/bin/e2fsck -f -y /dev/block/nddata
	#/system/bin/mount -t ext4 -o noatime,nosuid,nodev,nomblk_io_submit,errors=panic /dev/block/nddata /data
	#######################################################################

	/system/bin/sync
else
	/system/bin/umount /data
fi

echo "Finished disk_preparing.sh" > /dev/disk_preparing_done
