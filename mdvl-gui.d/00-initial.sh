#!/bin/sh -eu
# Ma_Sys.ma MDVL GUI Startup Script 00-initial 2.0.0,
# Copyright (c) 2020 Ma_Sys.ma.
# For further info send an e-mail to Ma_Sys.ma@web.de.

# -- Keyboard --
/usr/bin/xmodmap
setxkbmap -layout de -variant deadgraveacute
# Speed up key repeat
xset r rate 270 30
# disable bell
xset b 0

# -- Theme for password-gorilla --
if [ -d /usr/share/tcltk/awthemes ]; then
	echo "*TkTheme: awdark" | xrdb -merge
fi

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
