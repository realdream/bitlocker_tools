#!/usr/bin/env bash
if [ $# -ne 1 ]
then
    echo "usage:$0 device"
    exit -1
fi
device=$1
# check if it is mounted 
sudo test -e ./$device/dislocker-file
if [ 0 -eq $? ]
 then
  echo "device:$device already mounted"
  exit -1
fi
# check if the mount point of decrypted device exist
sudo test -d ./$device
if [ 0 -eq $? ]
 then
    sudo rm -r ./$device
fi
# do decrypt
username=`users`
mkdir ./$device
sudo dislocker-fuse -V /dev/$device -u ./$device
if [ $? -ne 0 ]
then
    echo "create decrypted device failed!"
    echo "please check you password and the disk device!"
    exit -1
fi
# check if the mount point of decrypted filesystem exist
sudo test -d /media/$username/$device
if [ 0 -eq $? ]
 then
    sudo rm -r /media/$username/$device
fi
sudo mkdir /media/$username/$device
sudo chown $username:$username /media/$username/$device
sudo mount -t auto -o uid=$username,gid=$username,dmask=022,fmask=133 ./$device/dislocker-file /media/$username/$device