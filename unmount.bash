#!/usr/bin/env bash
if [ $# -ne 1 ]
then
    echo "usage:$0 device"
    exit -1
fi
sudo umount /media/yrk16/$1
sudo rm -r /media/yrk16/$1
sudo umount ./$1
sudo rm -r ./$1
exit