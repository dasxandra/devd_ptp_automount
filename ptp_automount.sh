#!/bin/sh

PATH=${PATH}:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

readonly MOUNT_POINT='/media/PTP-CAMERA'
readonly MOUNT_OPTIONS='-o allow_other'

if [ "${1}" != 'attach' ] && [ "${1}" != 'detach' ]; then
	exit 1
fi

case "$1" in
	'attach')
		mkdir -p "$MOUNT_POINT" || exit 1
		mount | grep -q "gphotofs on ${MOUNT_POINT}" || exit 1
		gphotofs $MOUNT_OPTIONS "$MOUNT_POINT"
		;;
	'detach')
		rmdir "$MOUNT_POINT" || { umount -f "$MOUNT_POINT" && rmdir "$MOUNT_POINT"; }
		;;
esac