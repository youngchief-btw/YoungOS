#!/bin/bash
rm -rf dist/
mkdir -p dist/{bin,boot,boot/grub,boot/linux,dev,etc,dev,etc,etc/opt,etc/sgml,etc/X11,etc/xml,home,lib,lib32,lib64,media,mnt,opt,proc,root,run,sbin,srv,sys,tmp,usr,usr/bin,usr/include,usr/lib,usr/lib32,usr/lib64,usr/local,usr/sbin,usr/share,usr/src,usr/X11R6,var,var/cache,var/lib,var/lock,var/log,var/mail,var/opt,var/run,var/spool,var/tmp};
echo "root::0:0:root:/root:/bin/bash" >> dist/etc/passwd;
echo "
root:x:0:
bin:x:1:
sys:x:2:
kmem:x:3:
tty:x:4:
daemon:x:6:
disk:x:8:
dialout:x:10:
video:x:12:
utmp:x:13:
usb:x:14:" >> dist/etc/group
echo "
export PATH=/bin:/usr/bin

if [ `id -u` -eq 0 ] ; then
        PATH=/bin:/sbin:/usr/bin:/usr/sbin
        unset HISTFILE
fi


# Set up some environment variables.
export USER=`id -un`
export LOGNAME=$USER
export HOSTNAME=`/bin/hostname`
export HISTSIZE=1000
export HISTFILESIZE=1000
export PAGER='/bin/more '
export EDITOR='/bin/nano'" >> dist/etc/profile;
echo "youngos" >> dist/etc/hostname;
echo "YoungOS" >> dist/etc/issue;
echo '

set default=0
set timeout=5

set root=(hd0,1)

menuentry "YoungOS" {
  linux /boot/vmlinuz-4.16.3 root=/dev/sda1 ro quiet
}
' >> dist/boot/grub/grub.cfg
