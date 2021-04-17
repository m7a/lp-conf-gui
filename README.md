---
section: 32
x-masysma-name: conf-gui
title: MDVL GUI Configuration Package
date: 2021/02/02 20:45:11
lang: en-US
author: ["Linux-Fan, Ma_Sys.ma (Ma_Sys.ma@web.de)"]
keywords: ["mdvl", "conf", "dotfiles", "gui", "mdvl-conf-gui", "x11", "linux"]
x-masysma-version: 1.0.0
x-masysma-website: https://masysma.lima-city.de/32/conf-gui.xhtml
x-masysma-repository: https://www.github.com/m7a/lp-conf-gui
x-masysma-owned: 1
x-masysma-copyright: |
  Copyright (c) 2021 Ma_Sys.ma.
  For further info send an e-mail to Ma_Sys.ma@web.de.
---
Description
===========

This package contains dotfile-like configuration settings for Linux GUI
programs. It is intended to be installed on MDVL systems but may not be suitable
for general-purpose Debian installations given that some changes deviate far
from the defaults and do not integrate well unless many other MDVL packages
are also installed.

Configured Programs
===================

Here is an overview on the files provided and the programs configured.

## GTK-Configuration

The following files configure GTK (2.0 and 3.0) to use a dark theme and set
GUI fonts to Terminus:

 * `/etc/gtk-2.0/gtkrc`
 * `/etc/gtk-3.0/settings.ini`
 * `/usr/share/themes/masysma/gtk-2.0/gtkrc`

## Feh Keybindings

File `/etc/feh/keys` reconfigures the keybindings of the `feh` image viewer to
be similar to `plan_view.py`. See also: [image_viewer(32)](image_viewer.xhtml).

## i3-Configuration

File `/etc/i3/config` configures the i3 window manager to use the [WINDOWS]
(aka. [SUPER]) together with certain keys to manage windows. It is mostly based
on an old i3 version's defaults with notable changes being described in the
following:

	bindsym $m+Shift+h        move left
	bindsym $m+Shift+j        move down
	bindsym $m+Shift+k        move up
	bindsym $m+Shift+l        move right

All movement commands are configured to use VIM-style [H]/[J]/[K]/[L] keys:

	bindsym $m+Escape         mode "passthrough"
	mode "passthrough" {
		bindsym $m+Escape mode "default"
	}

A _passthrough_ mode is provided to be invoked by [WINDOWS]-[ESC] which disables
all keybindings. This may be useful when interacting with Windows VMs and such.

	bindsym Mod1+F1           exec /usr/bin/materm
	bindsym Mod1+F2           exec /usr/bin/dmenu_run
	bindsym Mod1+F3           exec /usr/bin/materm -e vifm /data/main
	bindsym Mod1+F5           exec /usr/bin/materm -e d5mantui
	bindsym Mod1+F7           exec GTK_THEME=Adwaita:dark /usr/bin/firefox
	bindsym Mod1+F9           exec /usr/bin/materm -e htop
	bindsym Mod1+F10          exec /usr/bin/virt-manager
	bindsym $m+Shift+Delete   exec /usr/bin/q

Various programs are configured to be assigned to [ALT]-[FX] combinations where
X is one of the F-keys' numbers like X=1 for [ALT]-[F1] to invoke a `materm`.
The settings used here are expected to be changed by users to their respectively
used applications. The defaults provided here are used as a reference across
multiple Ma_Sys.ma systems. E. g. Ma_Zentral DVDs assign F1, F2, F7, F9 to
Windows programs that perform similar tasks to their Linux counterparts
configured here.

	# requires xdotool, .mdvl/scrroot.txt, maim
	bindsym --release Print   exec "/bin/sh -ec 'dnam=\\"$(cat \\"$HOME/.mdvl/scrroot.txt\\")/$(date +%Y%m%d)\\"; [ -d \\"$dnam\\" ] || mkdir \\"$dnam\\"; fnam=\\"$(date +%Y%m%d%H%M%S).png\\"; maim -i $(xdotool getactivewindow) > \\"$dnam/$fnam\\"'"

An elaborated screenshot function is assigned to the [PRINTSCREEN] key.
This setting invokes the `maim` tool to take a screenshot of the currently
active window and saves it into the directory path specified in
`$HOME/.mdvl/scrroot.txt`. It automatically ensures that screenshots are stored
into different subdirectories depending on the current day.

	exec /bin/run-parts --exit-on-error --regex=".*" --verbose /usr/lib/mdvl-gui.d

This line enables the scripts from below `/usr/lib/mdvl-gui.d` to be
automatically invoked upon GUI startup.

	font -*-terminus-medium-*-normal-*-16-*-*-*-*-*-iso10646-1

	# class                  border   bg       fg       split
	client.focused           #cc4040  #cc4040  #ffffff  #ff0000
	client.focused_inactive  #806060  #806060  #aaaaaa  #bb0000
	client.unfocused         #201818  #201818  #505050  #400000
	client.urgent            #ffaa00  #ffaa00  #ffffff  #ffaa00

	bar {
		font -*-terminus-medium-*-normal-*-12-*-*-*-*-*-iso10646-1
		status_command /usr/bin/mai3bar --json
		position top
		tray_output primary
		colors {
			#                   border  bg      fg
			focused_workspace   #cc4040 #cc4040 #ffffff
			active_workspace    #806060 #806060 #aaaaaa
			inactive_workspace  #201818 #201818 #505050
			urgent_workspace    #ffaa00 #ffaa00 #ffffff
			background                  #000000
			statusline                          #ffffff
			separator                           #333333
		}
	}

This block configures a Ma_Sys.ma-specific color scheme that is based on red
colors. Additionally, the `i3bar` is populated by `mai3bar` --
see [i3bar(32)](i3bar.xhtml). Additionally, the GUI is configured to use
Terminus for all window manager parts.

GUI Autorun Scripts
===================

Directory `/usr/lib/mdvl-gui.d` is checked for scripts to automatically invoke
upon starting i3 with the configuration described above. Relevant default
configuration is found in file `00-initial.sh`:

~~~{.bash}
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
~~~

The keyboard configuration is set to German keyboard layout, faster repeat
rate and all bell sounds are disabled. For details on the effects of the
keyboard configuration, see also: [linux_x11_keyboard_configuration(37)](../37/linux_x11_keyboard_configuration.xhtml).

Afterwards, some optional components are invoked depending on whether they are
present:

 * If installed, theme `awdark` is set for use with Tk GUIs like
   `password-gorilla`. This theme is available from Debian 11 onwards.
 * If installed, `screenindex` logging is started in background.
   See [screenindex(32)](screenindex.xhtml) for details.
 * Finally, depending on whether the current system is a virtual machine
   (decided by the name for the lack of a better criterion), different processes
   are started: Physical systems run `xscreensaver` whereas virtual machines
   start `spice-vdagent` if installed and fix the DPI setting that is sometimes
   incorrect in VMs.

The advantage of the `run-parts`-based approach here is that system-specific
additional GUI startup scripts (like e.g. `nm-applet` for laptops) can be
provided by separate packages.

Changes to `/etc/skel`
======================

In the past, most Ma_Sys.ma dotfiles were configured in `/etc/skel` -- a
directory that is taken as a base for creating new users. Given that this makes
updates slow (new settings are only applied upon re-creating the user!), this
approach is newly avoided whenever possible.

Currently, the following files are provided for `/etc/skel`:

`.xscreensaver`
:   Default configuration for `xscreensaver`
`.xsession`
:   Default X11 session set to `i3`
