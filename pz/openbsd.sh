#	chengws@outlook.com
# cd ~/
mkdir -p .scim .config/qterminal.org .config/openbox .config/fbpanel .config/xfe
ftp -o - https://www.kerne1.org/pz/bg.jpg > bg.jpg
ftp -o - https://www.kerne1.org/pz/openbsd/config > ~/.scim/config
ftp -o - https://www.kerne1.org/pz/openbsd/help-openbsd.txt > help-openbsd.txt
ftp -o - https://www.kerne1.org/pz/openbsd/xinitrc > .xinitrc
ftp -o - https://www.kerne1.org/pz/openbsd/Xdefaults > .Xdefaults
ftp -o - https://www.kerne1.org/pz/openbsd/re-fbpanel.sh > .re-fbpanel.sh
ftp -o - https://www.kerne1.org/pz/openbsd/kshrc > .kshrc
ftp -o - https://www.kerne1.org/pz/openbsd/tmux.conf > .tmux.conf
chmod 0755 .re-fbpanel.sh
ftp -o - https://www.kerne1.org/pz/openbsd/qterminal.ini > ~/.config/qterminal.org/qterminal.ini
ftp -o - https://www.kerne1.org/pz/openbsd/autostart > ~/.config/openbox/autostart
ftp -o - https://www.kerne1.org/pz/openbsd/menu.xml > ~/.config/openbox/menu.xml
ftp -o - https://www.kerne1.org/pz/openbsd/default > ~/.config/fbpanel/default
ftp -o - https://www.kerne1.org/pz/openbsd/xferc > ~/.config/xfe/xferc
ftp -o - https://www.kerne1.org/pz/openbsd/installurl > /etc/installurl
ftp -o - https://www.kerne1.org/pz/openbsd/mixerctl.conf > /etc/mixerctl.conf
pkg_add -I openbox
pkg_add -I zh-wqy-zenhei-ttf
pkg_add -I fbpanel
pkg_add -I qterminal
#目前仅发现leafpad支持输入中文
pkg_add -I scim scim-tables scim-pinyin
pkg_add -I xfe
pkg_add -I xfce4-taskmanager
pkg_add -I audacious
pkg_add -I audacious-plugins
pkg_add -I evince--light
pkg_add -I feh
pkg_add -I gimp
pkg_add -I gthumb
pkg_add -I meld
pkg_add -I vlc nano
pkg_add -I wget aria2
pkg_add -I leafpad
pkg_add -I firefox-esr

wei=`find /usr -name gnomeblue-theme`
sed  -i "s#iconpath=#&$wei#"  ~/.config/xfe/xferc

cp /usr/local/bin/vlc /usr/local/bin/vlc-bf
sed -i 's/geteuid/getppid/' /usr/local/bin/vlc
mulu=/usr/local/share/applications
sed -i 's/Utility;//' $mulu/xfce4-taskmanager.desktop
echo "NoDisplay=true" >> $mulu/xfi.desktop
echo "NoDisplay=true" >> $mulu/xfp.desktop
echo "NoDisplay=true" >> $mulu/xfw.desktop
echo "NoDisplay=true" >> $mulu/qterminal_drop.desktop
startx
