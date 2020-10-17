#!/bin/sh -e

if [ -f "$HOME/.mdvl/infobg/bginfo.pid" ]; then
	rm "$HOME/.mdvl/infobg/bginfo.pid"
fi
/usr/bin/ma_infobg -i -a || true # no fail if absent
