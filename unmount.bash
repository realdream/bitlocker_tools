#!/usr/bin/env bash
if [ $# -ne 1 ]
then
    echo "usage:$0 device"
    exit -1
fi
username=`users`
sudo umount /media/$username/$1
sudo test -d /media/$username/$1
if [ 0 -eq $? ]
 then
    sudo rm -r /media/$username/$1
fi
sudo umount ./$1
# sudo test -d ./$1
# if [ 0 -eq $? ]
#  then
#     sudo rm -r ./$1
# fi