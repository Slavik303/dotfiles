#!/bin/sh

userresources=$XDG_CONFIG_HOME/X11/xresources
usermodmap=$XDG_CONFIG_HOME/X11/keymaps
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge $userresources
fi

if [ -f "$usermodmap" ]; then
    xmodmap $usermodmap
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ -f /usr/local/bin/dwm ]; then
	session=${1:-dwm}
else
	session=${1:-i3}
fi


case "$session" in
	i3|i3wm) exec /usr/bin/i3 ;;
	dwm) exec /usr/local/bin/dwm ;;
	*) exec $1 ;;
esac
