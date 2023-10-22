# zfsbootmenu-cdrom
Script to generate hybrid iso with ztfsbootmenu. 

Used by me to boot Truenas off a NVMe running off a PCIe-card on a BIOS-only proliant server.
Probably useful for somebody else running old hardware without EFI support.

Hybrid ISO, allows boot from cdrom or usb. You can also dd it to a SD-card or similar.

Tested on ubuntu

## Usage (If the reelased ISO has become old)
1. Install dependencies `apt-get install -y syslinux-common isolinux syslinux-utils curl jq`
2. Run ./build_isolinux_iso.sh
3. Use file build/zfsbootmenu_hybrid.iso
