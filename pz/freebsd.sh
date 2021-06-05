#	chengws@outlook.com
#创建一些文件夹
mkdir -p  .config/openbox .config/xfe .config/xfce4/xfconf/xfce-perchannel-xml /usr/local/etc/pkg/repos

#此文件是软件仓库的地址
fetch --no-verify-peer https://www.kfchy.com/pz/freebsd/FreeBSD.conf -o /usr/local/etc/pkg/repos/

#openbox的菜单,只在桌面有效
fetch --no-verify-peer https://www.kfchy.com/pz/openbox/menu-freebsd.xml -o ~/.config/openbox/menu.xml

#关于一些freebsd帮助
fetch --no-verify-peer https://www.kfchy.com/pz/freebsd/help-freebsd.txt

#下载用户登录时的配置,用于指定系统语言
fetch --no-verify-peer https://www.kfchy.com/pz/freebsd/login_conf -o .login_conf

fetch --no-verify-peer https://www.kfchy.com/pz/xfce4/xfce4-taskmanager.rc -o ~/.config/xfce4/

#状态栏的配置
fetch --no-verify-peer https://www.kfchy.com/pz/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml -o ~/.config/xfce4/xfconf/xfce-perchannel-xml/

#启用pkg,用它来安装软件
pkg update -y
pkg update

#安装xorg和窗口管理器
echo y | pkg install xorg-minimal openbox xterm

#安装中文字体和终端
echo y | pkg install wqy-fonts tilix

#安装xfce4状态栏和任务管理器
echo y | pkg install xfce4-panel xfce4-taskmanager

echo y | pkg install pcmanfm mousepad

#安装中文输入法
#echo y | pkg install ibus ibus-m17n ibus-table zh-ibus-libpinyin

#生成机器id,xfce4状态栏需要它
dbus-uuidgen > /etc/machine-id

#原来VLC不能在root用户使用,现在修改root用户也可使用
#cp /usr/local/bin/vlc /usr/local/bin/vlc-bf
#sed -i 's/geteuid/getppid/' /usr/local/bin/vlc

#设置xfe图标的路径
#wei=`find /usr -name gnomeblue-theme`
#sed  -i "s#iconpath=#&$wei#"  ~/.config/xfe/xferc

#添加重启和关机图标
mulu=/usr/local/share/applications
fetch --no-verify-peer https://www.kfchy.com/pz/xfce4/reboot.desktop -o $mulu/
fetch --no-verify-peer https://www.kfchy.com/pz/xfce4/shutdown.desktop -o $mulu/

#隐藏几个快捷图标,使得开始菜单更清爽
sed -i 's/Utility;//' $mulu/xfce4-taskmanager.desktop
echo "NoDisplay=true" >> $mulu/exo-file-manager.desktop
echo "NoDisplay=true" >> $mulu/exo-mail-reader.desktop
echo "NoDisplay=true" >> $mulu/exo-preferred-applications.desktop
echo "NoDisplay=true" >> $mulu/exo-terminal-emulator.desktop
echo "NoDisplay=true" >> $mulu/exo-web-browser.desktop
echo "NoDisplay=true" >> $mulu/xfce4-about.desktop

#现在启动图形化桌面
startx

#退出脚本
exit
