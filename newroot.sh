#!/bin/busybox sh
/bin/busybox --install -s /bin
/bin/mkdir -p /mnt/newroot /sys /proc /dev
/bin/mount -t sysfs sysfs /sys
/bin/mount -t proc proc /proc
/bin/mount -t devtmpfs devtmpfs /dev
/bin/mount /dev/sda /mnt/newroot
exec switch_root /mnt/newroot /sbin/init
