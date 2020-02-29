#	chengws@outlook.com
cd ~/
ftp -o - https://www.kerne1.org/pz/openbsd.tar.gz  > openbsd.tar.gz
ftp -o - https://www.kerne1.org/pz/bg.jpg > bg.jpg
tar -zxvf openbsd.tar.gz
echo Ready to install software, Input root password
su root
mv installurl /etc/
mv mixerctl.conf /etc/
pkg_add -l .pkg-list | grep 'install\rror' > cuo-wu.txt
rm /usr/local/share/applications/xfi.desktop
rm /usr/local/share/applications/xfp.desktop
rm /usr/local/share/applications/xfw.desktop
rm /usr/local/share/applications/qterminal_drop.desktop
echo quit root
exit
startx

