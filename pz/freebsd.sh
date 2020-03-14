#	chengws@outlook.com
mkdir -p .config/qterminal.org .config/openbox .config/xfe .config/xfce4/xfconf/xfce-perchannel-xml /usr/local/etc/pkg/repos
fetch --no-verify-peer https://www.kerne1.org/pz/openbsd/qterminal.ini -o ~/.config/qterminal.org/
fetch --no-verify-peer https://www.kerne1.org/pz/bg.jpg
fetch --no-verify-peer https://www.kerne1.org/pz/openbsd/tmux.conf -o .tmux.conf
fetch --no-verify-peer https://www.kerne1.org/pz/openbsd/xferc -o ~/.config/xfe/
fetch --no-verify-peer https://www.kerne1.org/pz/openbsd/xinitrc -o .xinitrc
fetch --no-verify-peer https://www.kerne1.org/pz/freebsd/FreeBSD.conf -o /usr/local/etc/pkg/repos/
fetch --no-verify-peer https://www.kerne1.org/pz/freebsd/menu.xml -o ~/.config/openbox/
fetch --no-verify-peer https://www.kerne1.org/pz/freebsd/re-xfce4-panel.sh
fetch --no-verify-peer https://www.kerne1.org/pz/freebsd/autostart -o ~/.config/openbox/
fetch --no-verify-peer https://www.kerne1.org/pz/freebsd/help-freebsd.txt
fetch --no-verify-peer https://www.kerne1.org/pz/freebsd/login_conf -o .login_conf
mulu=/usr/local/share/applications
fetch --no-verify-peer https://www.kerne1.org/pz/xfce4/xfce4-taskmanager.rc -o ~/.config/xfce4/
fetch --no-verify-peer https://www.kerne1.org/pz/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml -o ~/.config/xfce4/xfconf/xfce-perchannel-xml/
fetch --no-verify-peer https://www.kerne1.org/pz/xfce4/reboot.desktop -o $mulu/
fetch --no-verify-peer https://www.kerne1.org/pz/xfce4/shutdown.desktop -o $mulu/
pkg update
echo y | pkg install xorg-minimal openbox
echo y | pkg install wqy-fonts qterminal
echo y | pkg install xfce4-panel xfce4-taskmanager
echo y | pkg install xfe vlc nano
echo y | pkg install evince-lite firefox
echo y | pkg install gimp gthumb
echo y | pkg install meld wget leafpad
echo y | pkg install audacious audacious-plugins
echo y | pkg install ibus ibus-m17n ibus-table zh-ibus-libpinyin
dbus-uuidgen > /etc/machine-id
cp /usr/local/bin/vlc /usr/local/bin/vlc-bf
sed -i 's/geteuid/getppid/' /usr/local/bin/vlc
wei=`find /usr -name gnomeblue-theme`
sed  -i "s#iconpath=#&$wei#"  ~/.config/xfe/xferc
sed -i 's/Utility;//' $mulu/xfce4-taskmanager.desktop
echo "NoDisplay=true" >> $mulu/xfi.desktop
echo "NoDisplay=true" >> $mulu/xfp.desktop
echo "NoDisplay=true" >> $mulu/xfw.desktop
echo "NoDisplay=true" >> $mulu/qterminal_drop.desktop
echo "NoDisplay=true" >> $mulu/exo-file-manager.desktop
echo "NoDisplay=true" >> $mulu/exo-mail-reader.desktop
echo "NoDisplay=true" >> $mulu/exo-preferred-applications.desktop
echo "NoDisplay=true" >> $mulu/exo-terminal-emulator.desktop
echo "NoDisplay=true" >> $mulu/exo-web-browser.desktop
echo "NoDisplay=true" >> $mulu/xfce4-about.desktop
startx
exit
