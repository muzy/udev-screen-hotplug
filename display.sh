#!/bin/sh
# Screen Hotplug Script for udev
#
# (c) Sebastian Muszytowski <muzy@muzybot.de>
# inspired by derf0 <https://derf.homelinux.org>
#
# Prerequisites:
#
#  configure udev:
#  -> check which subsystem is used (execute "sudo udevadm monitor" and plug and disconnect screen)
#  -> create an udev rule
#     Example (for "drm" subsystem)
#
#         SUBSYSTEM=="drm", ACTION=="change", RUN+="/path/to/display.sh"
#
#  -> make sure that /tmp is writeable
#  -> make sure that this script is executeable (chmod +x /path/to/display.sh)
#
#  -> configure absolute path to the config file

cpath="/etc/udev/scripts/config.inc"

#  configure this script:
#  -> open config.inc in an editor of your choice
#  -> configure it your way
#
#  restart udev (/etc/init.d/udev restart)
#
#  HAVE FUN!



dmode="$(cat /sys/class/drm/card0-VGA-1/status)"

# Parse configuration and write it into a temp file

rm /tmp/.udev.screen_cstm_hotplug
cat "${cpath}" | grep -v ^$ | grep -v [[:space:]]# | grep -v ^# >> /tmp/.udev.screen_cstm_hotplug

# Load generic configuration vars

dou="$(cat /tmp/.udev.screen_cstm_hotplug | grep dou | cut -d '=' -f2 )"
dsd="$(cat /tmp/.udev.screen_cstm_hotplug | grep dsd | cut -d '=' -f2 )"
msn="$(cat /tmp/.udev.screen_cstm_hotplug | grep msn | cut -d '=' -f2 )"

# Main routines

export DISPLAY=:0.0

if [ "${dmode}" = disconnected ]; then
	xrandr --output VGA1 --off

elif [ "${dmode}" = connected ]; then

	eidp="$(cat /tmp/.udev.screen_cstm_hotplug | grep eidp | cut -d '=' -f2 )"
	edid="$(cat ${eidp} | base64 | openssl dgst -sha1)"

	if grep -q "${edid}" < /tmp/.udev.screen_cstm_hotplug;;
	then
		mode="$(cat /tmp/.udev.screen_cstm_hotplug | grep ${edid} | cut -d '|' -f2 )"
		orientation="$(cat /tmp/.udev.screen_cstm_hotplug | grep ${edid} | cut -d '|' -f3 )"
		xrandr --output "${dou}" --mode "${mode}" "${orientation}"
	else
		xrandr --output "${dou}" --auto "${dsd}" "${msn}"
	fi
fi
