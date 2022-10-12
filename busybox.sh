#!/bin/bash

mkdir -p initrd
cd initrd
    mkdir -p bin dev proc sys
    cp ../busybox ./bin/
    chmod +x ./bin/busybox

    echo '#!/bin/busybox sh' > init
    echo 'echo "---> WELCOME TO deepcracks BUSYBOX! <---"' >> init
    echo '/bin/busybox --install -s /bin' >> init
    echo '/bin/mount -t sysfs sysfs /sys' >> init
    echo '/bin/mount -t proc proc /proc' >> init
    echo '/bin/mount -t devtmpfs devtmpfs /dev' >> init
    echo '/bin/sysctl -w kernel.printk="2 4 1 7"' >> init
    echo '/bin/sh' >> init
    echo 'echo "---> deepcracks BUSYBOX IS SHUTTING DOWN! <---"' >> init
    echo '/bin/poweroff -f' >> init

    chmod -R 777 .
    find . | cpio -o -H newc > ../initrd.img
cd ..

qemu-system-x86_64 -kernel bzImage -initrd initrd.img -nographic -append 'console=ttyS0'
