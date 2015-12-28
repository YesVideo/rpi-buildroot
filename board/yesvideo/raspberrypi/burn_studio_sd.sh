#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR=`readlink -f $DIR/../../..`

NUM_FILE=$DIR/studio_number.txt
HOSTFILE_TEMPLATE=$DIR/rootfs-overlay/etc/hostapd.conf.template
HOSTFILE=$DIR/rootfs-overlay/etc/hostapd.conf

if [ ! -b "/dev/sdb" ]
then
  echo "/dev/sdb is not mounted"
  exit 1
fi

if [ ! -f $NUM_FILE ]; then
    echo "$NUM_FILE does not exist"
    exit 1
fi

N=`cat $NUM_FILE`
N=`expr $N + 1`

echo "Burning Studio #$N"

sed -e "s/SSID/Studio_$N/g" $HOSTFILE_TEMPLATE > $HOSTFILE

cd $ROOT_DIR
make
cd -

umount /dev/sdb1
umount /dev/sdb2

sudo $ROOT_DIR/board/raspberrypi2/mksdcard /dev/sdb

echo $N > $NUM_FILE

echo -e '\a'
