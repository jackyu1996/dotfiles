export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=en_US.UTF-8
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

setxkbmap -option caps:ctrl_modifier
systemctl --user import-environment DISPLAY
exec /usr/bin/i3
