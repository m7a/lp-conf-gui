#!/bin/sh -eu

if [ -f "$HOME/.mdvl/infobg/bginfo.pid" ]; then
	rm "$HOME/.mdvl/infobg/bginfo.pid"
fi

if [ -x /usr/bin/mainfobg3.pl ]; then
	/usr/bin/mainfobg3.pl
fi
