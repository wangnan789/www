#	chengws@outlook.com
ftp -o - https://www.kerne1.org/pz/openbsd.tar.gz  > openbsd.tar.gz
ftp -o - https://www.kerne1.org/pz/bg.jpg > bg.jpg
ftp -o - https://www.kerne1.org/pz/help-openbsd.txt > help-openbsd.txt
tar -zxvf openbsd.tar.gz
mv installurl /etc/
mv mixerctl.conf /etc/
pkg_add -Vv -l .pkg-list | tee guo-cheng.txt
mulu=/usr/local/share/applications
rm $mulu/xfi.desktop $mulu/xfp.desktop $mulu/xfw.desktop $mulu/qterminal_drop.desktop openbsd.tar.gz
startx
