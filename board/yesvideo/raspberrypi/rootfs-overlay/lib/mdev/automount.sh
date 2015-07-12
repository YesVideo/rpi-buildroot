#!/bin/sh

DEVICE=/dev/${MDEV}
MOUNT="/media/usb"

# bail if device doesn't exist
if [ ! -b ${DEVICE} ]; then exit 0; fi

# bail if not a FAT partition
if ! dd if=${DEVICE} bs=512 count=1 2>/dev/null | grep -q "FAT"; then exit 0; fi

unmount() {
    umount $2
}

case ${ACTION} in
    "add")
        # bail if we're already mounted
        if grep -q "^${DEVICE} ${MOUNT}" /proc/mounts; then exit 0; fi

        # else first unmount the MOUNT
        umount ${MOUNT} 2>/dev/null

        mkdir -p ${MOUNT}
        mount ${DEVICE} ${MOUNT}
        ;;
    
    "remove")
        procmounts=$(grep "^${DEVICE}" /proc/mounts)
        unmount $procmounts
        ;;
    
    *)
        ;;
esac

exit $?
