#!/bin/sh -e

# -- Keyboard --
/usr/bin/xmodmap
setxkbmap -layout de -variant deadgraveacute
# Speed up key repeat
xset r rate 270 30
# disable bell
xset b 0

# -- Background Processes --
/usr/bin/screenindex -l -g &

if [ "$(head -c 3 /etc/hostname)" = "vm-" ]; then
	/usr/bin/spice-vdagent &
	xrandr --dpi 109
else
	/usr/bin/xscreensaver -no-splash &
fi

# -- udisks --
# Query once to enable automatic device nodes $ man udisks
/usr/bin/udisks --enumerate &
