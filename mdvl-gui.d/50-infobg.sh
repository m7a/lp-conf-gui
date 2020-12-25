#!/bin/sh -eu

if [ -f "$HOME/.mdvl/infobg/bginfo.pid" ]; then
	rm "$HOME/.mdvl/infobg/bginfo.pid"
fi
if [ -x "$HOME/.mdvl/user_bin/ma_infobg" ]; then
	"$HOME/.mdvl/user_bin/ma_infobg" -i -a || true # no fail if absent
fi
