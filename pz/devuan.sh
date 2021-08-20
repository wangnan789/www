#########切换root用户,设置一些系统级的配置
su root

#########删除vim,对于一般用户,难以使用
#apt purge vim-tiny vim-common xxd

#########修改软件仓库地址
cat  > /etc/apt/sources.list  <<EOF
deb http://deb.devuan.org/merged chimaera main
deb http://deb.devuan.org/merged chimaera-security main
deb http://deb.devuan.org/merged chimaera-updates main
 
deb http://deb.devuan.org/devuan chimaera main
deb http://deb.devuan.org/devuan chimaera-security main
deb http://deb.devuan.org/devuan chimaera-updates main


EOF

#########更新软件仓库数据
apt update

#########安装基本的X图形和一些字体(中文)
apt install -y  xorg locales 

#########安装窗口管理器,状态栏,文件管理,音乐播放等等
apt install -y openbox fbpanel sudo pcmanfm xtrlock network-manager alsa-utils
#tilix wget axel rsync gedit \
#qemu qemu-system-x86 firefox-esr w3m \
#qbittorrent blueman vlc audacity meld  xvkbd \
#file-roller evince mtpaint gthumb feh scim scim-pinyin android-file-transfer lsof enca
# (scim-modules-socket libscim8v5 fonts-arphic-uming im-config scim scim-gtk-immodule fonts-arphic-ukai scim-im-agent scim-pinyin )
#根据需要,自行增减

#########缩短一些开始菜单名称
chmod  777  /usr/share/applications/
echo "NoDisplay=true" >> /usr/share/applications/pcmanfm-desktop-pref.desktop
sed -i 's/File Manager PCManFM/PCManFM/'  /usr/share/applications/pcmanfm.desktop
sed -i 's/Openbox Configuration Manager/obconf/' /usr/share/applications/obconf.desktop

#########删去登录后的提示信息
echo  > /etc/update-motd.d/10-uname
echo  > /etc/motd

#########更改为北京时区
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#########让第一个普通用户可以使用sudo,且关机和重启不需密码
username=`awk -F: '/1000/{ print $1 }' /etc/passwd`
hostname=`cat /etc/hostname`
cp /etc/sudoers /etc/sudoers.bak
echo "$username ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "$username $hostname=NOPASSWD:/sbin/halt,/sbin/reboot" >> /etc/sudoers

#########退出root帐户,切换回普通用户
exit

###设置默认的窗口管理器
echo "exec openbox-session"  > .xinitrc

#生成计算器的图标
cat >> /usr/share/applications/xclac.desktop  <<EOF
[Desktop Entry]
Name=xcalc
Icon=accessories-calculator
GenericName=calc
Exec=xcalc
Categories=System;Utility;
Type=Application
Keywords=keyboard;input
EOF

###bashrc配置
cat > .bashrc  <<EOF

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize
color_prompt=yes

# enable color support 
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#https://wiki.bash-hackers.org/scripting/terminalcodes
#https://mywiki.wooledge.org/BashFAQ/037
#颜色
hong=$(tput setaf 9)
bai=$(tput setaf 15)
lan=$(tput setaf 27)
lv=$(tput setaf 2)
reset=$(tput sgr0)

#明亮
ml=$(tput bold)

#下划线
xhx=$(tput smul)

xie=$(tput smso)
#闪现
sx=$(tput blink)

PS1='\[$ml$lan\]\u\[$reset\]\[$sx$hong\]@\[$reset\]\[$xhx\]\H\[$reset\]\[$ml$lan\]\W\[$reset\] \[$sx$xie$lv\]\$\[$reset\] '
######这是没有颜色的
#PS1='\u@\H(\t)\W\# \!\$ '
PS4='+{$LINENO:${FUNCNAME[0]}} '

alias vi='nano'
alias vim='nano'
alias apts='apt search'
alias apti='sudo apt install'
alias aptp='sudo apt purge'
alias aptsh='apt show'
alias aptu='sudo apt update'
alias aptfu='sudo apt full-upgrade'
alias aptdu='sudo apt dist-upgrade'
alias aptd='apt depends'
alias aptr='apt rdepends'
alias aptl='dpkg -L'
alias aptss='dpkg -S'

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
. startx >/dev/null 2>&1
logout
fi

EOF

###虚拟键盘的图标
cat  > /usr/share/applications/xvkbd.desktop  <<EOF

[Desktop Entry]
Name=xvkbd
Icon=input-keyboard
GenericName=X Virtual Keyboard
Exec=xvkbd
Categories=System;Utility;
Type=Application
Keywords=keyboard;input

EOF

###创建一些程序的文件夹,用来放置它们的配置
mkdir -p  ~/.config/openbox ~/.config/fbpanel ~/.config/pcmanfm/default 

###创建xterm的配置,默认的配置不是很适合
cat  > .Xdefaults  <<EOF

xterm*scrollBar: true
XTerm*rightScrollBar:true
XTerm*loginShell: true
XTerm*SaveLines: 4096

XTerm*background: black
XTerm*foreground: blue

! English font 
xterm*faceName: DejaVu Sans Mono:pixelsize=14

! Chinese font 
XTerm*faceNameDoublesize:WenQuanYi Micro Hei:pixelsize=13

XTerm*dynamicColors:true

!mouse selecting to copy, ctrl-v to paste
!Ctrl p to print screen content to file
XTerm*VT100.Translations: #override \
Ctrl <KeyPress> V: insert-selection(CLIPBOARD,PRIMARY,CUT_BUFFER0) \n\
<BtnUp>: select-end(CLIPBOARD,PRIMARY,CUT_BUFFER0) \n\
Ctrl <KeyPress> P: print() \n 

EOF

###创建nano的配置,默认的配置不是很适合
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

###创建pcmanfm文件管理器的配置,默认的配置不是很适合
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

###创建openbox的配置,默认的配置不是很适合
cat  > ~/.config/openbox/autostart <<EOF
#在后台启动状态栏
fbpanel &

#设置桌面背景
feh --no-fehbg --bg-fill '/home/cws/bj.jpg' & 
xtrlock
EOF

###创建openbox的桌面右键菜单,默认的配置不是很适合
cat  > ~/.config/openbox/menu.xml <<EOF
<!--	chengws@outlook.com	 -->

<?xml version="1.0" encoding="UTF-8"?>

<openbox_menu xmlns="http://openbox.org/3.4/menu">

<menu id="root-menu" label="Openbox 3">

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


###创建状态栏的配置,默认的配置不是很适合
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



function getdir(){


###以下这些配置.暂时未使用
###设置默认使用的输入法
cat >> .bashrc  <<EOF
export XMODIFIERS=@im=scim
export XIM=scim
export GTK_IM_MODULE=scim 
export QT_IM_MODULE=scim 
EOF

###虚拟键盘的配置
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

###创建scim输入法的配置,默认的配置不是很适合
mkdir -p ~/.scim
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

cat  > ~/.profile <<EOF
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


EOF

}
