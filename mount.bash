#!/usr/bin/env bash
if [ $# -ne 1 ]
then
    echo "usage:$0 device"
    exit -1
fi
mkdir ./$1
sudo dislocker-fuse -V /dev/$1 -u ./$1
sudo mkdir /media/yrk16/$1
sudo mount -t auto ./$1/dislocker-file /media/yrk16/$1
exit