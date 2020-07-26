#	chengws@outlook.com
# cd ~/
#创建一些文件夹
mkdir -p .scim .config/qterminal.org .config/openbox .config/fbpanel .config/xfe

#下载桌面背景图片,不是必须的
ftp -o - https://www.kfchy.com/pz/bg.jpg > bg.jpg

#下载scim输入法的配置
ftp -o - https://www.kfchy.com/pz/scim/config > ~/.scim/config

#一些常用操作命令
ftp -o - https://www.kfchy.com/pz/openbsd/help-openbsd.txt > help-openbsd.txt

#下载启动图形化桌面的配置
ftp -o - https://www.kfchy.com/pz/openbsd/xinitrc > .xinitrc

#下载xterm的配置
ftp -o - https://www.kfchy.com/pz/openbsd/Xdefaults > .Xdefaults

#下载重启状态栏的脚本
ftp -o - https://www.kfchy.com/pz/openbsd/re-fbpanel.sh > .re-fbpanel.sh
#给它可执行的权限
chmod 0755 .re-fbpanel.sh

#下载ksh的配置
ftp -o - https://www.kfchy.com/pz/openbsd/kshrc > .kshrc

#下载tmux的配置
ftp -o - https://www.kfchy.com/pz/tmux/tmux.conf > .tmux.conf

#下载用户的配置
ftp -o - https://www.kfchy.com/pz/openbsd/profile > .profile

#下载qterminal的配置,这是多窗口的终端
ftp -o - https://www.kfchy.com/pz/qterminal.org/qterminal.ini > ~/.config/qterminal.org/qterminal.ini

#openbox启动时自动执行的命令
ftp -o - https://www.kfchy.com/pz/openbox/autostart-openbsd > ~/.config/openbox/autostart

#openbox的配置
ftp -o - https://www.kfchy.com/pz/openbox/rc.xml > ~/.config/openbox/rc.xml

#openbox的菜单,只在桌面有效
ftp -o - https://www.kfchy.com/pz/openbox/menu.xml > ~/.config/openbox/menu.xml

#下载状态栏的配置
ftp -o - https://www.kfchy.com/pz/fbpanel/default > ~/.config/fbpanel/default

#下载xfe的配置
ftp -o - https://www.kfchy.com/pz/xfe/xferc > ~/.config/xfe/xferc

#此文件是软件仓库的地址
ftp -o - https://www.kfchy.com/pz/openbsd/etc/installurl > /etc/installurl

#各种音频设置
ftp -o - https://www.kfchy.com/pz/openbsd/etc/mixerctl.conf > /etc/mixerctl.conf

#安装窗口管理器,I--是非交互式的,有时候某些软件要你决定安装哪个依赖,有了选项I,会自
#动选择.实现全程自动化安装软件.
pkg_add -I openbox

#安装终端和中文字体
pkg_add -I qterminal zh-wqy-zenhei-ttf

#安装状态栏
pkg_add -I fbpanel 

#安装scim拼音输入法,目前仅发现leafpad支持输入中文
pkg_add -I scim scim-tables scim-pinyin

#安装文件管理器,图片浏览,文本编辑程序
pkg_add -I xfe gpicview wget leafpad

#安装任务管理器
pkg_add -I xfce4-taskmanager

#安装音频播放
pkg_add -I audacious audacious-plugins

#安装功能强大的多媒体播放程序VLC,和图片编辑
pkg_add -I vlc mtpaint

#安装网页浏览软件
pkg_add -I firefox

#设置xfe图标的路径
wei=`find /usr -name gnomeblue-theme`
sed  -i "s#iconpath=#&$wei#"  ~/.config/xfe/xferc

#原来VLC不能在root用户使用,现在修改root用户也可使用
cp /usr/local/bin/vlc /usr/local/bin/vlc-bf
sed -i 's/geteuid/getppid/' /usr/local/bin/vlc

#隐藏几个快捷图标,使得开始菜单更清爽
mulu=/usr/local/share/applications
sed -i 's/Utility;//' $mulu/xfce4-taskmanager.desktop
echo "NoDisplay=true" >> $mulu/xfi.desktop
echo "NoDisplay=true" >> $mulu/xfp.desktop
echo "NoDisplay=true" >> $mulu/xfw.desktop
echo "NoDisplay=true" >> $mulu/qterminal_drop.desktop

#现在启动图形化桌面
startx

#退出脚本
exit
