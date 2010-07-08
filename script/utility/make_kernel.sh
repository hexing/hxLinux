#!/bin/sh

if [ ! -d /usr/src/linux ]; then
mount --bind /dev/shm /usr/src
cd /usr/src
tar -xjf /opt/linux-2.6.33.tar.bz2
ln -s linux-2.6.33 linux
fi
cd /usr/src/linux

if [ ! -f .config ]; then
echo '.config does not exist'
exit 7
fi
[ ! -f .config ] && exit 1
make clean
make menuconfig || exit 2

make prepare
KERNEL_RELEASE=$(make kernelrelease)
KERNEL_CURRENT=$(uname -r)
if [ "$KERNEL_RELEASE" = "$KERNEL_CURRENT" ]; then
echo $KERNEL_RELEASE
echo $KERNEL_CURRENT
exit 3
fi

make && make modules_install
[ "$?" -ne ] && exit 4

set -v
DIR_KERNEL="/boot/backup_kernels/$KERNEL_RELEASE"
mkdir -p $DIR_KERNEL
F_SYSTEM_MAP="$DIR_KERNEL/System.map-$KERNEL_RELEASE"
cp System.map $F_SYSTEM_MAP || exit 5
F_KERNEL="$DIR_KERNEL/kernel-$KERNEL_RELEASE"
cp arch/`uname -m`/boot/bzImage $F_KERNEL || exit 6
/sbin/depmod -v $KERNEL_RELEASE
mkinitcpio -k $KERNEL_RELEASE -g bzImage.img
F_IMG="$F_KERNEL.img"
cp bzImage.img $F_IMG
set +v
echo '-------Success--------'
