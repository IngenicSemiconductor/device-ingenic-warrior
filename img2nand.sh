#! /bin/bash

out_dir=`echo $ANDROID_PRODUCT_OUT`
top_dir=`echo $ANDROID_BUILD_TOP`

if [ "$out_dir" = "" ] ; then
	echo "error: ANDROID_PRODUCT_OUT is empty, can't find out dir"
	exit 4
fi

if [ ! -f $out_dir/system.img ] ; then
	echo "error: $out_dir/system.img is not exist"
	exit 4
fi

mknandimg=$top_dir/device/ingenic/warrior/mknandimg/mkimg
mknandimg_config=$top_dir/device/ingenic/warrior/mknandimg/config.ini

echo $mknandimg -f $mknandimg_config -i $out_dir/system.img -o $out_dir/system.img
$mknandimg -f $mknandimg_config -i $out_dir/system.img -o $out_dir/system.img

if [ $? -ne 0 ]; then
  exit 4
fi

echo "$out_dir/system.img.bin generated"
