#	chengws@outlook.com
ftp -o - https://www.kerne1.org/pz/openbsd.tar.gz  > openbsd.tar.gz
ftp -o - https://www.kerne1.org/pz/bg.jpg > bg.jpg
tar -zxvf openbsd.tar.gz
echo db说的话大会发言他觉
su root <<EOF
mv installurl /etc/
mv mixerctl.conf /etc/
pkg_add -l .pkg-list | grep 'install\rror' > cuo-wu.txt
rm /usr/local/share/applications/xfi.desktop
rm /usr/local/share/applications/xfp.desktop
rm /usr/local/share/applications/xfw.desktop
rm /usr/local/share/applications/qterminal_drop.desktop
echo quit root
exit
EOF
startx

