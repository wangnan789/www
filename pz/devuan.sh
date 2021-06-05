#切换root用户
su root

##########删除vim,对于一般用户,难以使用
apt purge vim-common vim-tiny xxd

cat >> .bashrc  <<EOF
export XMODIFIERS=@im=scim
export XIM=scim
export GTK_IM_MODULE=scim 
export QT_IM_MODULE=scim 
#export LC_ALL=”zh_CN.UTF-8”
alias vi='nano'
alias vim='nano'
EOF

##########修改软件仓库地址
cat  > /etc/apt/sources.list  <<EOF
deb http://deb.devuan.org/merged chimaera-security main
deb http://deb.devuan.org/merged chimaera-updates main
deb http://deb.devuan.org/merged chimaera main contrib non-free
EOF

##########更新软件仓库数据
apt update

##########安装基本的X图形和一些字体(中文)
apt install xserver-xorg-video-dummy xserver-xorg-video-vesa xserver-xorg-input-libinput  xinit x11-xserver-utils xorg xterm  \
xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable fonts-wqy-microhei -y

##########安装窗口管理器,状态栏,文件管理,音乐播放等等
apt install openbox fbpanel sudo pcmanfm tilix xtrlock wget axel rsync gedit \
qemu qemu-system-x86 network-manager firefox-esr w3m \
qbittorrent blueman alsa-utils audacious audacious-plugins vlc audacity meld  xvkbd inotify-tools enca  \
file-roller xournal mtpaint gthumb feh rsync scim scim-pinyin android-file-transfer -y
# (scim-modules-socket libscim8v5 fonts-arphic-uming im-config scim scim-gtk-immodule fonts-arphic-ukai scim-im-agent scim-pinyin )
#根据需要,自行增减
#窗口管理器 opengbox
#状态栏 fbpanel
#文件管理 pcmanfm
#多窗口多标签的终端 tilix
#锁住电脑 xtrlock 
#文本编辑 mousepad  或者 gedit
#虚拟机 qemu qemu-system-x86
#连接网络 network-manager (包含nmtui)
#网络浏览 firefox-esr
#命令行下的网络浏览器 w3m
#BT下载 qbittorrent
#蓝牙连接 blueman
#声音驱动 alsa-utils  (包含音量调节alsamixer）
#音乐播放 audacious audacious-plugins
#视频播放 vlc
#音频编辑 audacity
#音量调节 pavucontrol
#文件对比 meld
#软键盘 xvkbd
#监视文件夹变化 inotify-tools
#检测,转换文件编码 enca
#压缩解压缩 file-roller
#笔记和查看pdf xournal  或者evince
#图片编辑 mtpaint
#图片浏览 gthumb
#设置桌面背景 feh 这个是命令行的
#中文输入法 scim scim-pinyin
#安卓手机传输文件 android-file-transfer  
#libmtp-common libmtp-runtime libmtp9
##########缩短一些开始菜单名称
chmod  777  /usr/share/applications/
echo "NoDisplay=true" >> /usr/share/applications/pcmanfm-desktop-pref.desktop
echo "NoDisplay=true" >> /usr/share/applications/im-config.desktop
sed -i 's/File Manager PCManFM/PCManFM/'  /usr/share/applications/pcmanfm.desktop
sed -i 's/Openbox Configuration Manager/obconf/' /usr/share/applications/obconf.desktop

##########删去登录后的提示信息
echo  > /etc/update-motd.d/10-uname
echo  > /etc/motd

##########更改为北京时区
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

##########让第一个普通用户可以使用sudo,且关机和重启不需密码
username=`awk -F: '/1000/{ print $1 }' /etc/passwd`
hostname=`cat /etc/hostname`
cp /etc/sudoers /etc/sudoers.bak
echo "$username ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "$username $hostname=NOPASSWD:/sbin/halt,/sbin/reboot" >> /etc/sudoers

#切换回普通用户
exit


echo "exec openbox-session"  > .xinitrc

cat >> .bashrc  <<EOF
export XMODIFIERS=@im=scim
export XIM=scim
export GTK_IM_MODULE=scim 
export QT_IM_MODULE=scim 
#export LC_ALL=”zh_CN.UTF-8”
alias vi='nano'
alias vim='nano'
EOF

##########修改语言为中文,登录后自动启动图形界面
cat  >> .profile  <<EOF
LANG=zh_CN.UTF-8
LC_ALL="zh_CN.UTF-8"
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
EOF

##########虚拟键盘的配置
cat  > .xvkbd  <<EOF
#quick_modifiers 1
#shift_lock 0
#altgr_lock 0
#modifiers_lock 0
#key_click 0
#autoclick 0
#always_on_top 0
#wm_toolbar 1
#jump_pointer 1
#insert_blank_after_completion 1
#integrate_completion_panel 0
#dict_file /usr/share/xvkbd/words.english
#private_dict_weight 1
EOF

mkdir -p  ~/.config/openbox ~/.config/fbpanel ~/.config/pcmanfm/default ~/.scim

cat  > .nanorc  <<EOF
## Constantly display the cursor position in the status bar.  Note that
## this overrides "quickblank".
#set constantshow
set quickblank

set linenumbers
set matchbrackets "(<[{)>]}"

## Use the blank line below the title bar as extra editing space.
set morespace

#set mouse
set multibuffer

## dos  mac
unset noconvert

#set nohelp

## Enable soft line wrapping (AKA full-line display).
set softwrap
#set nowrap

## Fix numeric keypad key confusion problem.
#set rebindkeypad

## Put the cursor on the highlighted item in the file browser;
## useful for people who use a braille display.
set showcursor

## Use smooth scrolling as the default.
set smooth

## Allow nano to be suspended.
set suspend

## Save automatically on exit; don't prompt.
set tempfile

## Snip whitespace at the end of lines when justifying or hard-wrapping.
set trimblanks

## Disallow file modification. 
# set view

## Paint the interface elements of nano.  These are examples;
 set titlecolor brightwhite,blue
 set statuscolor brightwhite,red
 set errorcolor brightwhite,red
 set selectedcolor brightwhite,cyan
 set numbercolor blue
 set keycolor brightmagenta
 set functioncolor magenta

EOF

cat  > ~/.config/pcmanfm/default/pcmanfm.conf <<EOF
[config]
bm_open_method=0

[volume]
mount_on_startup=1
mount_removable=1
autorun=0

[ui]
always_show_tabs=0
max_tab_chars=32
win_width=640
win_height=480
maximized=1
splitter_pos=226
media_in_new_tab=0
desktop_folder_new_win=0
change_tab_on_drop=1
close_on_unmount=0
focus_previous=0
side_pane_mode=dirtree
view_mode=compact
show_hidden=1
sort=name;ascending;case;
columns=name:200;ext;desc;size;mtime;
toolbar=newtab;navigation;home;
show_statusbar=1
pathbar_mode_buttons=0
EOF

cat  > ~/.scim／config <<EOF
/DefaultIMEngineFactory/si_LK = IMEngine-M17N-si-wijesekera
/DefaultIMEngineFactory/ta_IN = IMEngine-M17N-ta-tamil99
/DefaultIMEngineFactory/zh_CN = 29ab338a-5a27-46b8-96cd-abbe86f17132
/DefaultIMEngineFactory/zh_HK = 5da9d4ff-ccdd-45af-b1a5-7bd4ac0aeb5f
/DefaultIMEngineFactory/zh_SG = 05235cfc-43ce-490c-b1b1-c5a2185276ae
/DefaultIMEngineFactory/zh_TW = fcff66b6-4d3e-4cf2-833c-01ef66ac6025
/FrontEnd/ChangeFactoryGlobally = false
/FrontEnd/IMOpenedByDefault = false
/FrontEnd/OnTheSpot = false
/FrontEnd/SharedInputMethod = false
/FrontEnd/Socket/ConfigReadOnly = false
/FrontEnd/Socket/MaxClients = 512
/FrontEnd/X11/BrokenWchar = true
/FrontEnd/X11/Dynamic = false
/FrontEnd/X11/OnTheSpot = true
/FrontEnd/X11/ServerName = SCIM
/Hotkeys/FrontEnd/NextFactory = 
/Hotkeys/FrontEnd/NextFactory/zh_CN = 
/Hotkeys/FrontEnd/NextFactory/zh_HK = 
/Hotkeys/FrontEnd/NextFactory/zh_SG = 
/Hotkeys/FrontEnd/NextFactory/zh_TW = 
/Hotkeys/FrontEnd/Off = 
/Hotkeys/FrontEnd/On = 
/Hotkeys/FrontEnd/PreviousFactory = 
/Hotkeys/FrontEnd/PreviousFactory/zh_CN = 
/Hotkeys/FrontEnd/PreviousFactory/zh_HK = 
/Hotkeys/FrontEnd/PreviousFactory/zh_SG = 
/Hotkeys/FrontEnd/PreviousFactory/zh_TW = 
/Hotkeys/FrontEnd/ShowFactoryMenu = 
/Hotkeys/FrontEnd/Trigger = Control+space
/Hotkeys/FrontEnd/Trigger/ja_JP = Zenkaku_Hankaku,Alt+grave,Control+space
/Hotkeys/FrontEnd/Trigger/ko_KR = Alt+Alt_L+KeyRelease,Shift+space,Control+space,Hangul
/Hotkeys/FrontEnd/ValidKeyMask = Shift+Control+Alt+Meta+Super+Hyper+CapsLock
/IMEngine/Pinyin/AlwaysShowLookup = true
/IMEngine/Pinyin/Ambiguity/AnAng = false
/IMEngine/Pinyin/Ambiguity/Any = true
/IMEngine/Pinyin/Ambiguity/ChiCi = true
/IMEngine/Pinyin/Ambiguity/EnEng = false
/IMEngine/Pinyin/Ambiguity/FoHe = false
/IMEngine/Pinyin/Ambiguity/InIng = false
/IMEngine/Pinyin/Ambiguity/LeRi = false
/IMEngine/Pinyin/Ambiguity/NeLe = false
/IMEngine/Pinyin/Ambiguity/ShiSi = true
/IMEngine/Pinyin/Ambiguity/ZhiZi = true
/IMEngine/Pinyin/AutoCombinePhrase = true
/IMEngine/Pinyin/AutoFillPreedit = true
/IMEngine/Pinyin/BurstStackSize = 128
/IMEngine/Pinyin/ChineseSwitchKey = Control+space
/IMEngine/Pinyin/DisablePhraseKey = 
/IMEngine/Pinyin/DynamicAdjust = true
/IMEngine/Pinyin/DynamicSensitivity = 6
/IMEngine/Pinyin/FullWidthLetterKey = 
/IMEngine/Pinyin/FullWidthPunctKey = 
/IMEngine/Pinyin/Incomplete = true
/IMEngine/Pinyin/MatchLongerPhrase = false
/IMEngine/Pinyin/MaxPreeditLength = 32
/IMEngine/Pinyin/MaxUserPhraseLength = 8
/IMEngine/Pinyin/ModeSwitchKey = 
/IMEngine/Pinyin/PageDownKey = period,equal,bracketright,Page_Down
/IMEngine/Pinyin/PageUpKey = comma,minus,bracketleft,Page_Up
/IMEngine/Pinyin/SavePeriod = 300
/IMEngine/Pinyin/ShowAllKeys = true
/IMEngine/Pinyin/ShuangPin = false
/IMEngine/Pinyin/ShuangPinScheme = 4
/IMEngine/Pinyin/SmartMatchLevel = 20
/IMEngine/Pinyin/Tone = false
/IMEngine/Pinyin/User/DataBinary = false
/IMEngine/RawCode/Locales = default
/Panel/Gtk/Color/ActiveBackground = light sky blue
/Panel/Gtk/Color/ActiveText = black
/Panel/Gtk/Color/NormalBackground = #F7F3F7
/Panel/Gtk/Color/NormalText = black
/Panel/Gtk/DefaultSticked = false
/Panel/Gtk/Font = default
/Panel/Gtk/LookupTableEmbedded = true
/Panel/Gtk/LookupTableVertical = true
/Panel/Gtk/ShowStatusBox = false
/Panel/Gtk/ShowTrayIcon = true
/Panel/Gtk/ToolBar/AlwaysHidden = false
/Panel/Gtk/ToolBar/AlwaysShow = false
/Panel/Gtk/ToolBar/AutoSnap = false
/Panel/Gtk/ToolBar/HideTimeout = 2
/Panel/Gtk/ToolBar/POS_X = 785
/Panel/Gtk/ToolBar/POS_Y = 698
/Panel/Gtk/ToolBar/ShowFactoryIcon = false
/Panel/Gtk/ToolBar/ShowFactoryName = true
/Panel/Gtk/ToolBar/ShowHelpIcon = false
/Panel/Gtk/ToolBar/ShowMenuIcon = false
/Panel/Gtk/ToolBar/ShowPropertyLabel = false
/Panel/Gtk/ToolBar/ShowSetupIcon = true
/Panel/Gtk/ToolBar/ShowStickIcon = false
/UpdateTimeStamp = 1621344950:514146
EOF
cat  > ~/.scim／global <<EOF
/DefaultKeyboardLayout = US_Default
/DisabledIMEngineFactories = 6e029d75-ef65-42a8-848e-332e63d70f9c

EOF


#openbox的配置
cat  > ~/.config/openbox/autostart <<EOF
#在后台启动状态栏
fbpanel &

#设置桌面背景
feh --no-fehbg --bg-fill '/home/cws/bj.jpg' & 
EOF

cat  > ~/.config/openbox/menu.xml <<EOF
<!--	chengws@outlook.com	 -->

<?xml version="1.0" encoding="UTF-8"?>

<openbox_menu xmlns="http://openbox.org/3.4/menu">

<menu id="root-menu" label="Openbox 3">

  <item label="Tilix">
    <action name="Execute"><execute>tilix</execute></action>
  </item>

  <item label="Xterm">
    <action name="Execute"><execute>xterm</execute></action>
  </item>

    <!--重新加载openbox的配置 -->
  <item label="ReThisMenu">
    <action name="Reconfigure" />
  </item>

    <!--退出图形界面,回到命令行.记得保存文件哟 -->
  <item label="OutToCmd">
    <action name="Exit">
    </action>
  </item>

</menu>

</openbox_menu>
EOF


#状态栏的配置
cat  > ~/.config/fbpanel/default  <<EOF
Global {
    edge = bottom
    allign = center
    margin = 0
    widthtype = percent
    width = 100
    height = 28
    transparent = true
    alpha = 120
    setdocktype = true
    setpartialstrut = true
    autohide = false
    heightWhenHidden = 2
    roundcorners = false
    layer = above
    MaxElemHeight = 32
    xmargin = 0
    ymargin = 0
    setlayer = false
    roundcornersradius = 0
}
Plugin {
    type = menu
    config {
        IconSize = 22
        icon = go-home
        systemmenu {
        }
        separator {
        }
        menu {
            name = Computer
            icon = computer
            item {
                name = 锁住Lock
                icon = changes-prevent
                action = xtrlock
            }
            item {
                name = 重启Rebook
                icon = audio-speakers
                action = sudo reboot
            }
            item {
                name = 关机Shutdown
                icon = media-optical
                action = sudo halt -p
            }
            item {
                name = OutToCmd
                icon = utilities-terminal
                action = /usr/lib/fbpanel/fbpanel/xlogout
            }
        }
    }
}

###############

###############
Plugin {
    type = taskbar
    expand = true
    config {
        ShowIconified = true
        ShowMapped = true
        ShowAllDesks = false
        tooltips = false
        IconsOnly = false
        MaxTaskWidth = 130
    }
}
Plugin {
    type = wincmd
    config {
        icon = object-flip-vertical
        tooltip = 全部缩小
    }
}
plugin {
    type = battery
}
Plugin {
    type = tclock
    config {
        ClockFmt = %R
        TooltipFmt = %A %x
        ShowCalendar = false
        ShowTooltip = true
    }
}

EOF

startx

