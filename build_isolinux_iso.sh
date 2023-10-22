#!/bin/bash
# apt-get install -y syslinux-common isolinux syslinux-utils curl jq

mkdir -p build
(cd build;
	# TODO: Ask zfsbootmenu release files without the version in the filename. Allows us to just download from https://github.com/USER/PROJECT/releases/latest/download/package.zip
	LATEST=$(curl -s https://api.github.com/repos/zbm-dev/zfsbootmenu/releases/latest |   jq --raw-output '.assets[].browser_download_url' | grep "zfsbootmenu-release-.*.tar.gz")
	curl -L "$LATEST" > latest_zfsbootmenu.tar.gz
	mkdir -p latest-zfsbootmenu
	tar --strip-components=1 -C latest-zfsbootmenu -xvf latest_zfsbootmenu.tar.gz 
	
	mkdir -p cdroot/isolinux cdroot/zfsbootmenu
	cp /usr/lib/ISOLINUX/isolinux.bin cdroot/isolinux/
	cp ../isolinux.cfg cdroot/isolinux/
	cp latest-zfsbootmenu/vmlinuz-bootmenu cdroot/zfsbootmenu/vmlinuz_bootmenu # ISOLINUX does not support the "-" use _ instead
	cp latest-zfsbootmenu/initramfs-bootmenu.img cdroot/zfsbootmenu/initramfs_bootmenu.img # ISOLINUX does not support the "-" character, use _ instead
	cp /usr/lib/syslinux/modules/bios/* cdroot/isolinux/


	mkisofs -o zfsbootmenu_hybrid.iso \
		-b isolinux/isolinux.bin -c isolinux/boot.cat \
		-no-emul-boot -iso-level 2 -boot-load-size 4 -boot-info-table \
		cdroot
   
	isohybrid zfsbootmenu_hybrid.iso
)
