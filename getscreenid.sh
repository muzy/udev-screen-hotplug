#/bin/sh
if [ -z $1 ]
then 
foo="$(cat /sys/class/drm/card0-VGA-1/edid | base64 | openssl dgst -sha1)"
else
foo="$(cat ${1} | base64 | openssl dgst -sha1)"
fi
echo ${foo}
