#!/usr/bin/env bash
####################################
# usage:
# decrypt_disk <device> 
decrypt_disk()
{
    local device=$1
    local username=`users`
    mkdir ./$device
    sudo dislocker-fuse -V /dev/$device -u ./$device
    if [ $? -ne 0 ]
    then
        echo -e "\033[31mcreate decrypted device failed!\033[0m"
        echo -e "\033[31mplease check you password and the disk device!\033[0m"
        exit -1
    fi
    echo "disk: $device decrypted!"
}
####################################
# usage:
# mount_disk <device> 
mount_disk()
{
    # check if the mount point of decrypted filesystem exist
    local device=$1
    local username=`users`
    sudo test -d /media/$username/$device
    if [ 0 -eq $? ]
    then
        sudo rm -r /media/$username/$device
    fi
    sudo mkdir /media/$username/$device
    sudo chown $username:$username /media/$username/$device
    sudo mount -t auto -o uid=$username,gid=$username,dmask=022,fmask=133 ./$device/dislocker-file /media/$username/$device
    echo "decrypted disk: $device mounted!"
}
####################################
# from start
####################################
if [ $# -ne 1 ]
then
    echo "usage:$0 device"
    exit -1
fi
device=$1
username=`users`
# check if it is decrypted 
sudo test -e ./$device/dislocker-file
if [ 0 -eq $? ]
then
    echo -e "\033[33mdisk: $device already decrypted!\033[0m"
    # then check if it is mounted
    res=`mount | grep "/media/$username/$device" | wc -l`
    if [ 0 -eq $res ]
    then
        mount_disk $device
        exit 0
    else
        echo -e "\033[33mdecrypted disk:$device already mounted!\033[0m"
        exit -1
    fi
fi
# check if the mount point of decrypted device exist
sudo test -d ./$device
if [ 0 -eq $? ]
 then
    sudo rm -r ./$device
fi
decrypt_disk $device
mount_disk $device