# Configuration file for automatic screen settings
# 
# (c) 2010 Sebastian Muszytowski <muzy@muzybot.de>

# Default Output
dou=VGA1

# Main Screen Name
msn=LVDS1

# Default screen direction
#
# Allowed Values: --left-of,--right-of,--above,--below
dsd=--below


# Screen EDID Path
eidp=/sys/class/drm/card0-VGA-1/edid


# Custom Options for screens
# --------------------------
# Format:
# EDID-HASH|Screen-Resolution|Screen-Direction Output
# 
# Example:
# b1234b4c185643dde62ef581841331608da5088f|1680x1050|--below LVDS1
#
# The EDID-HASH can be gained by executing  "sh getscreenid.sh EDID-PATH"
#  Hint: If no EDID-PATH is set the default EDID-Path of VGA1 on Debian is assumed 
