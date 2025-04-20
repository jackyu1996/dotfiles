if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US
    export LC_CTYPE=en_US.UTF-8
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
    export SDL_IM_MODULE=fcitx
    export MOZ_ENABLE_WAYLAND=1
    export XDG_SESSION_TYPE=wayland
    export GTK_THEME=Materia
    export GDK_BACKEND=wayland

    exec Hyprland
fi
