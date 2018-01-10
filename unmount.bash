#!/usr/bin/env bash
if [ $# -ne 1 ]
then
    echo "usage:$0 device"
    exit -1
fi
sudo umount /media/yrk16/$1
sudo test -d /media/yrk16/$1
if [ 0 -eq $? ]
 then
    sudo rm -r /media/yrk16/$1
fi
sudo umount ./$1
sudo test -d ./$1
if [ 0 -eq $? ]
 then
    sudo rm -r ./$1
fi
exit