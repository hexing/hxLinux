# Maintainer: Bartek Piotrowski <barthalion@gmail.com>

#{{{1 package information
pkgname=vim-gnome
_realname=vim
_srcver=7.3
_patchlevel=$(wget ftp://ftp2.kr.vim.org/pub/vim/patches/${_srcver}/ -q -O - | sed -n '/7.3./ s/.*7.3.\([0-9]\+\).*/\1/p' | tail -1)
pkgver=${_srcver}.${_patchlevel}
pkgrel=3
pkgdesc="Modified from extra/gvim, compiled with gtk2 ui, without deps on vi/vim, ruby and desktop utils."
arch=(i686 x86_64)
license=('custom:vim')
url="http://www.vim.org"
depends=('libxt' 'gtk2')
provides=(${_realname})
conflicts=(gvim vim vim-gtk)
tarfile="vim-${_srcver}.tar.bz2"
source=(ftp://ftp2.kr.vim.org/pub/vim/unix/${tarfile})
md5sums=('5b9510a17074e2b37d8bb38ae09edbf2')
_python2=n
_vimfolder=${_realname}$(echo ${_srcver} | sed "s/\.//")

if [ ${_python2} = "y" ]; then
  makedepends=('wget' 'sed' 'grep' 'python2' 'perl' 'gzip')
else
  makedepends=('wget' 'sed' 'grep' 'python' 'perl' 'gzip') 
fi

do_configure() #{{{1
{
	#{{{2
	ARGV=" 
	--disable-darwin
	--disable-netbeans
	--disable-largefile
	--disable-gtktest
	--disable-xsmp
	--disable-xsmp-interact

	--enable-mzschemeinterp=no
	--enable-rubyinterp=no
	--enable-tclinterp=no
	--enable-workshop=no
	--enable-sniff=no
	--enable-hangulinput=no
	--enable-perlinterp=no
	--enable-pythoninterp=no
	--enable-luainterp=no

	--enable-python3interp=dynamic
	--enable-cscope
	--enable-multibyte
	--enable-motif-check=no
	--enable-athena-check=no
	--enable-nextaw-check=no
	--enable-carbon-check=no
	--enable-nls

	--with-modified-by=HeXing
	--with-compiledby=Xing.He
	--with-x=no
	--with-features=normal
	"

	#--enable-xim
	#--enable-fontset
	#--enable-gui=auto

	#--disable-selinux
	#--disable-acl


	#--with-python3-config-dir=PATH  Python's config directory
	#--with-gnome-includes=DIR Specify location of GNOME headers
	#--with-gnome-libs=DIR   Specify location of GNOME libs
	#--with-motif-lib=STRING   Library for Motif
	#--with-tlib=library     terminal library to be used
	#--with-global-runtime=/usr/share/vim

	CFLAGS="-march=x86-64 -mtune=generic" #{{{2
	cat /proc/cpuinfo | /bin/grep -o -m 1 'Pentium(R) Dual-Core' &>/dev/null
	if [ 0 -eq $? ]; then
		CFLAGS="-march=core2 -mtune=core2"
	fi

	CFLAGS="$CFLAGS -O2 -pipe -s \
	-Wall -Wextra -Wshadow -Wmissing-prototypes -fno-strength-reduce \
	"
	CPPFLAGS="$CPPFLAGS -DFEAT_CSCOPE -DFEAT_CONCEAL -DFEAT_MBYTE -DSYS_VIMRC_FILE=\"\\\"/etc/vimrc\\\"\" -DSYS_GVIMRC_FILE=\"\\\"/etc/gvimrc\\\"\""
	#-DFEAT_CSCOPE -DFEAT_CONCEAL -DFEAT_MBYTE -DUNICODE16 -DFEAT_XIM -DUSE_XIM=1 -DFEAT_XFONTSET -DFEAT_LIBCALL -DFEAT_XTERM_SAVE -DMEN_PROFILE -DWANT_X11 -DFEAT_CLIPBOARD -DFEAT_XCLIPBOARD -DFEAT_AUTOCHDIR -DFEAT_PERSISTENT_UNDO
	#-UFEAT_RELTIME -UFEAT_TITLE -UFEAT_VIMINFO -UFEAT_SPELL -USOME_BUILTIN_TCAPS -UFEAT_LISP -UFEAT_SESSION -UFEAT_TOOLBAR -UFEAT_MENU -UFEAT_WRITEBACKUP -USTARTUPTIME -USESSION_FILE -UUSE_XSMP -UFEAT_MOUSE_XTERM -UFEAT_MOUSE_GPM -UFEAT_SYSMOUSE -UFIND_REPLACE_DIALOG -UFEAT_CLIENTSERVER -UFEAT_TERMRESPONSE -UFEAT_SIGNS -UFEAT_SIGN_ICONS -UFEAT_BEVAL_TIP -UFEAT_FOOTER

	F_FEATURE_H="${srcdir}/${_vimfolder}/src/feature.h" #{{{2
	if [ -w $F_FEATURE_H ]; then
		UNDEF_ARR=(FEAT_TAG_OLDSTATIC FEAT_TAG_ANYWHITE FEAT_FLOAT FEAT_PRINTER FEAT_POSTSCRIPT)
		for u in ${UNDEF_ARR[@]}; do
			echo "#undef $u" >> $F_FEATURE_H
		done
	fi

	if [ 'GUI' == $1 ]; then  #{{{2
		ARGV="$ARGV --enable-gui=gnome2 --enable-gtk2-check --enable-gnome-check --with-gnome --with-vim-name=gvim"
	else
		ARGV="$ARGV --enable-gui=no --disable-gpm --disable-sysmouse"
	fi

	./configure --prefix=/usr --localstatedir=/var/lib/vim --mandir=/usr/share/man \
	$ARGV CFLAGS="$CFLAGS" CPPFLAGS="$CPPFLAGS"
}

do_patch() #{{{1
{
	PATCHES=$(ls ../../*${_srcver}*patch*.tar.xz)
	if [ -r "$PATCHES" ]; then
		xz -dc $PATCHES | tar -xf -
	else
		echo 'where is the patches?' && exit 9
		wget ftp://ftp.vim.org/pub/vim/patches/${_srcver}/${_srcver}.*
		wget ftp://ftp.vim.org/pub/vim/patches/${_srcver}/MD5SUMS
		md5sum -c MD5SUMS || return 1
	fi

	for x in `ls ${_srcver}.*`; do patch -p0 -i $x; done
}

clean_unneeded_files() #{{{1
{
#Clean unneeded files {{{2
	mv ${srcdir}/gvim ${pkgdir}/usr/bin
	MAN_DIR=${pkgdir}/usr/share/man
	if [ -d "$MAN_DIR/man1" ]; then
		mv "$MAN_DIR/man1"  man1 &&\
			rm -fr "$MAN_DIR" &&
			mkdir -p "$MAN_DIR" &&
			mv man1 "$MAN_DIR" 
	fi

	VIMRUNTIME=${pkgdir}/usr/share/vim/${_vimfolder}
	rm -fr $VIMRUNTIME/print
	rm -fr $VIMRUNTIME/keymap

	TUTOR=$VIMRUNTIME/tutor
	tos=(tutor tutor.utf-8 tutor.zh.utf-8 README.txt)
	for i in ${tos[@]}; do
		mv $TUTOR/$i . || exit
	done
	rm -fr "$TUTOR" &&\
	mkdir -p "$TUTOR" &&\
	for i in ${tos[@]}; do
		mv $i $TUTOR || exit
	done

	LANG_DIR=$VIMRUNTIME/lang
	lngs=(es zh_CN.UTF-8 menu_en_gb.utf-8.vim menu_es.utf-8.vim menu_es_es.utf-8.vim menu_zh_cn.utf-8.vim README.txt)
	for i in ${lngs[@]}; do
		mv "$LANG_DIR"/$i . || exit
	done
	rm -fr "$LANG_DIR" &&\
	mkdir -p "$LANG_DIR" &&\
	for i in ${lngs[@]}; do
		mv $i $LANG_DIR || exit
	done
#}}}2

# Clean unneeded binary files and man pages
	cd ${pkgdir}/usr/bin
	rm -f ex view rview xxd vimtutor

	find ${pkgdir}/usr/share/man -type d -name 'man1' 2>/dev/null | \
	while read _mandir; do
		cd ${_mandir}
		rm -f ex.1 view.1 vimtutor.1 xxd.1
	done

# Fix FS#17216
	sed -i 's|messages,/var|messages,/var/log/messages.log,/var|' \
	${pkgdir}/usr/share/vim/${_vimfolder}/filetype.vim

# Patch filetype.vim for better handling of pacman related files
	sed -i "s/rpmsave/pacsave/;s/rpmnew/pacnew/;s/,\*\.ebuild/\0,PKGBUILD*,*.install/" \
	${pkgdir}/usr/share/vim/${_vimfolder}/filetype.vim
	sed -i "/find the end/,+3{s/changelog_date_entry_search/changelog_date_end_entry_search/}" \
	${pkgdir}/usr/share/vim/${_vimfolder}/ftplugin/changelog.vim

# License
	install -Dm644 ${srcdir}/${_vimfolder}/runtime/doc/uganda.txt\
	${pkgdir}/usr/share/licenses/${_realname}/license.txt
}

build() #{{{1
{
	if [ -z ${srcdir} ]; then
		srcdir=src
		if [ ! -d "${srcdir}/${_vimfolder}" ]; then
			if [ -r ${tarfile} ]; then
				bzip2 -dc ${tarfile} | tar -xf - -C ${srcdir}
			fi
		fi
	fi

	cd ${srcdir}/${_vimfolder}

	do_patch

	if [ ${_python2} = "y" ]; then
		sed -i -e 's|vi_cv_path_python, python|vi_cv_path_python, python2|' \
		${srcdir}/${_vimfolder}/src/configure.in
		(cd ${srcdir}/${_vimfolder}/src && autoconf)
	fi

	do_configure GUI
	make -j2 || return 1
	mv `find ./ -type f -name 'gvim'` ${srcdir} || return 2

	make clean && make distclean
	do_configure
	make -j2 || return 1

	make VIMRCLOC=/etc DESTDIR=${pkgdir} install

	clean_unneeded_files
}
