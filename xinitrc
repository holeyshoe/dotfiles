#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set background
# feh --bg-center ~/backgrounds/arch-dark.png <-- set a new background
sh ~/.fehbg & # <-- restore background on login

# Export GTK Theme for Qt
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Configure X settings
xrdb -merge ~/.Xresources &
xsetroot -cursor_name left_ptr &
xscreensaver -no-spash &
xset +fp /usr/share/fonts/local
xset fp rehash

# Start some programs
nm-applet &
volumeicon &
dropbox start &
pidgin &
skype &

# Add new WM's with:
# window_manager)
#	exec window_manager
#	;;

DEFAULT_SESSION=xmonad

case $1 in
xmonad)
	exec xmonad
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
