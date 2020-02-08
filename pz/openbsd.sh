wget -c https://www.kerne1.org/pz/openbsd.tar.gz
wget -c https://www.kerne1.org/pz/bg.jpg
tar -zxvf openbsd.tar.gz
pkg_add -l pkg.list
tar -zxvf openbsd-pz.tar.gz -C /
rm /usr/local/share/applications/xfi.desktop
rm /usr/local/share/applications/xfp.desktop
rm /usr/local/share/applications/xfw.desktop
rm /usr/local/share/applications/qterminal_drop.desktop
reboot

