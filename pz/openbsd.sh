#	chengws@outlook.com
mkdir .config .config/qterminal.org .config/openbox .config/fbpanel .config/xfe .config/smplayer
ftp -o - https://www.kerne1.org/pz/bg.jpg > bg.jpg
ftp -o - https://www.kerne1.org/pz/openbsd/help-openbsd.txt > help-openbsd.txt
ftp -o - https://www.kerne1.org/pz/openbsd/.xinitrc > .xinitrc
ftp -o - https://www.kerne1.org/pz/openbsd/.Xdefaults > .Xdefaults
ftp -o - https://www.kerne1.org/pz/openbsd/.re-fbpanel.sh > .re-fbpanel.sh
ftp -o - https://www.kerne1.org/pz/openbsd/.pkg-list > .pkg-list
ftp -o - https://www.kerne1.org/pz/openbsd/qterminal.ini > ~/.config/qterminal.org/qterminal.ini
ftp -o - https://www.kerne1.org/pz/openbsd/autostart > ~/.config/openbox/autostart
ftp -o - https://www.kerne1.org/pz/openbsd/menu.xml > ~/.config/openbox/menu.xml
ftp -o - https://www.kerne1.org/pz/openbsd/default > ~/.config/fbpanel/default
ftp -o - https://www.kerne1.org/pz/openbsd/xferc > ~/.config/xfe/xferc
ftp -o - https://www.kerne1.org/pz/openbsd/smplayer.ini > ~/.config/smplayer/smplayer.ini
ftp -o - https://www.kerne1.org/pz/openbsd/installurl > /etc/installurl
ftp -o - https://www.kerne1.org/pz/openbsd/mixerctl.conf > /etc/mixerctl.conf
ftp -o - https://www.kerne1.org/pz/openbsd/.profile > /etc/skel/.profile
pkg_add -l .pkg-list | tee guo-cheng.txt
mulu=/usr/local/share/applications
rm $mulu/xfi.desktop $mulu/xfp.desktop $mulu/xfw.desktop $mulu/qterminal_drop.desktop openbsd.tar.gz
startx
