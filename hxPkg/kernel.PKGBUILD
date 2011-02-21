pkgname=kernel26-hexing
basekernel=2.6.37.1
pkgver=2.6.37.1
pkgrel=1
pkgdesc="The Linux Kernel and modules compiled by hexign"
arch=('i686' 'x86_64')
license=('GPL')
url="http://www.kernel.org"
depends=('module-init-tools' 'mkinitcpio')
provides=(kernel26)
install=kernel.INSTALL

build() {
	make mrproper
	zcat /proc/config.gz > .config
	make oldconfig
	[ ! -e /sbin/lsmod ] && ln -s /bin/lsmod /sbin/lsmod
	make localmodconfig
	make menuconfig

	LOCAL_VERSION="$(grep "CONFIG_LOCALVERSION=" $srcdir/.config | sed 's/.*"\(.*\)"/\1/')"

	make || return 1
	mkdir -p $pkgdir/{lib/modules,boot}
	make INSTALL_MOD_PATH=$pkgdir modules_install || return 1

# There's no separation of firmware depending on kernel version - 
# comment this line if you intend on using the built kernel exclusively,
# otherwise there'll be file conflicts with the existing kernel
	rm -rf $pkgdir/lib/firmware

	install -Dm644 "System.map" "$pkgdir/boot/System.map26$LOCAL_VERSION"
	install -Dm644 "arch/x86/boot/bzImage" "$pkgdir/boot/vmlinuz26$LOCAL_VERSION"

# Change the version strings in kernel26.install
	sed -i \
	-e "s/KERNEL_VERSION=.*/KERNEL_VERSION=\"$basekernel\"/" \
	-e "s/LOCAL_VERSION=.*/LOCAL_VERSION=\"$LOCAL_VERSION\"/" \
	$startdir/${install}
}
