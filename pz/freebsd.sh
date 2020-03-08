#	chengws@outlook.com
mkdir -p .config/qterminal.org .config/openbox .config/xfe /usr/local/etc/pkg/repos
pkg update -y
fetch https://www.kerne1.org/pz/openbsd/qterminal.ini -o ~/.config/qterminal.org/qterminal.ini
fetch https://www.kerne1.org/pz/bg.jpg
fetch https://www.kerne1.org/pz/openbsd/xferc -o ~/.config/xfe/xferc
fetch https://www.kerne1.org/pz/openbsd/xinitrc -o .xinitrc

fetch https://www.kerne1.org/pz/freebsd/FreeBSD.conf -o /usr/local/etc/pkg/repos
fetch https://www.kerne1.org/pz/freebsd/menu.xml -o ~/.config/openbox/menu.xml
fetch https://www.kerne1.org/pz/freebsd/re-xfce4-panel.sh
fetch https://www.kerne1.org/pz/freebsd/profile -o .profile
fetch https://www.kerne1.org/pz/freebsd/autostart -o ~/.config/openbox/autostart
fetch https://www.kerne1.org/pz/freebsd/help-freebsd.txt
fetch https://www.kerne1.org/pz/freebsd/login_conf -o .login_conf
echo y | pkg install xorg-minimal openbox
echo y | pkg install wqy-fonts qterminal
echo y | pkg install xfce4-panel xfce4-taskmanager
echo y | pkg install xfe vlc nano
echo y | pkg install evince-lite firefox
echo y | pkg install gimp gthumb
echo y | pkg install meld wget leafpad
echo y | pkg install audacious audacious-plugins
dbus-uuidgen > /etc/machine-id
cp /usr/local/bin/vlc /usr/local/bin/vlc-bf
sed -i 's/geteuid/getppid/' /usr/local/bin/vlc
mulu=/usr/local/share/applications
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
startx
