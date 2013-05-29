#! /bin/sh
#warning: if you use this script, you will lose all document in you sd card
if [ $# -eq 1 ]; then
	#1.get the /dev/sdb and \/dev\/sdb string
	dev_name=$1
	echo ${dev_name} > dev_string1.txt
	sed 's/\//\\\//g' dev_string1.txt > dev_string.txt
	dev_path=`cat dev_string.txt`
	rm dev_string1.txt
	rm dev_string.txt

	#2.get the mount informatin of the sd card
	mount > mount.tmp
	mount_tmp_size=`du -b mount.tmp | awk '{print $1}'`
	if [ ${mount_tmp_size} -ne 0 ]; then
		sed -rn "/${dev_path}/p" mount.tmp | awk '{print $3}' > umount.tmp
		umount_tmp_size=`du -b umount.tmp | awk '{print $1}'`
		if [ ${umount_tmp_size} -ne 0 ]; then
			umount_total=`awk '/.+/{x=x+1;} END {print x;}' umount.tmp`
			umount_count=0
			while [ ${umount_count} -lt ${umount_total} ]; do
				umount_count=$((${umount_count}+1))
				umount_path=`awk "NR==${umount_count} {print;}" umount.tmp`
				umount ${umount_path}
				echo "${umount_path} has been umounted"
			done
		fi
		rm umount.tmp
	fi
	rm mount.tmp

	#3.delete the orignal sd cand node like /dev/sdb1 and so on
	ls ${dev_name}* > dev_tmp1.txt
	dev_tmp1_size=`du -b dev_tmp1.txt | awk '{print $1}'`
	if [ ${dev_tmp1_size} -eq 0 ]; then
		echo "can't find ${dev_name}, please input the right sd card device node"
		rm dev_tmp1.txt
		exit 1
	fi
	sed -rn "/[0-9]+/s/${dev_path}//p" dev_tmp1.txt > dev_tmp.txt
	dev_tmp_size=`du -b dev_tmp.txt | awk '{print $1}'`
	if [ ${dev_tmp_size} -ne 0 ]; then
		dev_total=`awk '/[0-9]+/ {y=y+1;} END {print y;}' dev_tmp.txt`
		echo "the orgin ${dev_name} has ${dev_total} nodes"
		dev_count=0
		while [ ${dev_count} -lt ${dev_total} ]; do
			dev_count=$((${dev_count}+1))
			dev_num=`awk "NR==${dev_count} {print;}" dev_tmp.txt`
			echo "rm the ${dev_name}${dev_count} partition"
			parted ${dev_name} rm ${dev_num}
		done
		partprobe
	fi
	rm dev_tmp1.txt
	rm dev_tmp.txt

	#4.get the burner.fw and burn to sd card
	Gsize=$((1024 * 1024 * 1024))
	dev_size_tmp=`fdisk -l ${dev_name} | awk 'NR==2 {print $5;}'`
	echo "your sd card has ${dev_size_tmp} bytes"
	ls *.fw > fw.tmp
	if [ $? != 0 ]; then
		rm fw.tmp
		echo "error: cann't find the adjust burner.fw"
		exit 1
	fi
	if [ ${dev_size_tmp} -gt $((16 * ${Gsize})) ]; then
		dev_size=32G
		echo "so your sd card size is ${dev_size}"
		burnfw=`sed -n /^32G/p fw.tmp`
		if [ -z ${burnfw} ]; then
			dev_size=16G
			burnfw=`sed -n /^16G/p fw.tmp`
			if [ -z ${burnfw} ]; then
				dev_size=8G
				burnfw=`sed -n /^8G/p fw.tmp`
				if [ -z ${burnfw} ]; then
					dev_size=4G
					burnfw=`sed -n /^4G/p fw.tmp`
				elif [ -z ${burnfw} ]; then
					dev_size=2G
					burnfw=`sed -n /^2G/p fw.tmp`
					if [ -z ${burnfw} ]; then
						echo "error: cann't find the adjust burner.fw"
						exit 1
					fi
				fi
			fi
		fi
	elif [ ${dev_size_tmp} -gt $((8 * ${Gsize})) ]; then
		dev_size=16G
		echo "so your sd card size is ${dev_size}"
		burnfw=`sed -n /^16G/p fw.tmp`
		if [ -z ${burnfw} ]; then
			dev_size=8G
			burnfw=`sed -n /^8G/p fw.tmp`
			if [ -z ${burnfw} ]; then
				dev_size=4G
				burnfw=`sed -n /^4G/p fw.tmp`
			elif [ -z ${burnfw} ]; then
				dev_size=2G
				burnfw=`sed -n /^2G/p fw.tmp`
				if [ -z ${burnfw} ]; then
					echo "error: cann't find the adjust burner.fw"
					exit 1
				fi
			fi
		fi
	elif [ ${dev_size_tmp} -gt $((4 * ${Gsize})) ]; then
		dev_size=8G
		echo "so your sd card size is ${dev_size}"
		burnfw=`sed -n /^8G/p fw.tmp`
		if [ -z ${burnfw} ]; then
			dev_size=4G
			burnfw=`sed -n /^4G/p fw.tmp`
		elif [ -z ${burnfw} ]; then
			dev_size=2G
			burnfw=`sed -n /^2G/p fw.tmp`
			if [ -z ${burnfw} ]; then
				echo "error: cann't find the adjust burner.fw"
				exit 1
			fi
		fi
	elif [ ${dev_size_tmp} -gt $((2 * ${Gsize})) ]; then
		dev_size=4G
		echo "so your sd card size is ${dev_size}"
		burnfw=`sed -n /^4G/p fw.tmp`
		if [ -z ${burnfw} ]; then
			dev_size=2G
			burnfw=`sed -n /^2G/p fw.tmp`
			if [ -z ${burnfw} ]; then
				echo "error: cann't find the adjust burner.fw"
				exit 1
			fi
		fi
	else
		dev_size=2G
		echo "so your sd card size is ${dev_size}"
		burnfw=`sed -n /^2G/p fw.tmp`
		if [ -z ${burnfw} ]; then
			echo "error: cann't find the adjust burner.fw"
			exit 1
		fi
	fi
	echo "the burner.fw is ${burnfw}"
	rm fw.tmp
	dd if=${burnfw} of=${dev_name}
	partprobe

	#5.format the last sd card partition to fat32
	ls ${dev_name}* > format_tmp1.txt
	format_tmp1_size=`du -b format_tmp1.txt | awk '{print $1}'`
	if [ ${format_tmp1_size} -eq 0 ]; then
		echo "error:the burner process may have some unknow error"
		echo "please do this process again"
		rm format_tmp1.txt
		exit 1
	fi
	sed -rn "/[0-9]+/s/${dev_path}//p" format_tmp1.txt > format_tmp.txt
	format_tmp_size=`du -b format_tmp.txt | awk '{print $1}'`
	if [ ${format_tmp_size} -eq 0 ]; then
		echo "error: no format partition, you should check your fw is right or not"
		rm format_tmp.txt
		exit 1
	fi
	format_num=`awk '/[0-9]+/ {z=z+1;} END {print z;}' format_tmp.txt`
	echo "the new ${dev_name} has ${format_num} nodes"
	mkfs.vfat ${dev_name}${format_num}
	if [ $? != 0 ]; then
		echo "sorry:cann't format the ${dev_name}${format_num}, please manuall format it"
		rm format_tmp1.txt
		rm format_tmp.txt
		exit 1
	fi
	echo "format the ${dev_name}${format_num} to fat32"
	rm format_tmp1.txt
	rm format_tmp.txt

	#6.prompt the user to remove the sd card
	echo "congratulations, your burning-sd has been make OK"
	echo "your should remove and reinsert your sd card to copy you document"
else
	echo "error: the right format: [usage0 [device node]]"
	echo "such as [sudo ./burn.sh /dev/sdb]"
fi
