#	chengws@outlook.com
# cd ~/
mkdir .config .config/qterminal.org .config/openbox .config/fbpanel .config/xfe .config/smplayer
ftp -o - https://www.kerne1.org/pz/bg.jpg > bg.jpg
ftp -o - https://www.kerne1.org/pz/openbsd/help-openbsd.txt > help-openbsd.txt
ftp -o - https://www.kerne1.org/pz/openbsd/xinitrc > .xinitrc
ftp -o - https://www.kerne1.org/pz/openbsd/Xdefaults > .Xdefaults
ftp -o - https://www.kerne1.org/pz/openbsd/re-fbpanel.sh > .re-fbpanel.sh
chmod 0755 .re-fbpanel.sh
ftp -o - https://www.kerne1.org/pz/openbsd/qterminal.ini > ~/.config/qterminal.org/qterminal.ini
ftp -o - https://www.kerne1.org/pz/openbsd/autostart > ~/.config/openbox/autostart
ftp -o - https://www.kerne1.org/pz/openbsd/menu.xml > ~/.config/openbox/menu.xml
ftp -o - https://www.kerne1.org/pz/openbsd/default > ~/.config/fbpanel/default
ftp -o - https://www.kerne1.org/pz/openbsd/xferc > ~/.config/xfe/xferc
ftp -o - https://www.kerne1.org/pz/openbsd/smplayer.ini > ~/.config/smplayer/smplayer.ini
ftp -o - https://www.kerne1.org/pz/openbsd/installurl > /etc/installurl
ftp -o - https://www.kerne1.org/pz/openbsd/mixerctl.conf > /etc/mixerctl.conf
ftp -o - https://www.kerne1.org/pz/openbsd/profile > /etc/skel/.profile
ftp -o - https://www.kerne1.org/pz/openbsd/profile > .profile
pkg_add -Vv openbox
pkg_add -Vv zh-wqy-zenhei-ttf
pkg_add -Vv audacious
pkg_add -Vv audacious-plugins
pkg_add -Vv evincelight
pkg_add -Vv fbpanel
pkg_add -Vv feh
pkg_add -Vv gimp
pkg_add -Vv gthumb
pkg_add -Vv meld
pkg_add -Vv nano
pkg_add -Vv qterminal
pkg_add -Vv smplayer
pkg_add -Vv wget
pkg_add -Vv xfe
pkg_add -Vv featherpad
pkg_add -Vv firefox-esr
pkg_add -Vv firefox-esr-i18n-zh-CN
mulu=/usr/local/share/applications
rm $mulu/xfi.desktop $mulu/xfp.desktop $mulu/xfw.desktop $mulu/qterminal_drop.desktop
startx
