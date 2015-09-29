#!/bin/sh

RAW_DEVICE=/dev/${MDEV}
ROOT_DEVICE=`echo $RAW_DEVICE | sed -e 's/\([^0-9]*\).*/\1/'`
DEVICE=`fdisk -l --bytes $ROOT_DEVICE | grep -e "^$ROOT_DEVICE" | sort -rnk 5 |head -1|cut -d ' ' -f 1`

MOUNT="/media/usb"

logger automount: ${ACTION} $RAW_DEVICE =\> $DEVICE

case ${ACTION} in
    "add")
        # bail if device doesn't exist
        if [ ! -b ${DEVICE} ]; then exit 0; fi

        # bail if not a FAT partition
        if ! dd if=${DEVICE} bs=512 count=1 2>/dev/null | grep -q "FAT"; then exit 0; fi

        # bail if we're already mounted
        if grep -q "^${DEVICE} ${MOUNT}" /proc/mounts; then exit 0; fi

        # else first unmount the MOUNT
        umount ${MOUNT} 2>/dev/null

        mkdir -p ${MOUNT}
        mount ${DEVICE} ${MOUNT}
        ;;

    "remove")
        umount ${MOUNT} 2>/dev/null
        ;;

    *)
        ;;
esac

exit $?