#!/bin/sh
workdir=$(pwd)
uid=$(stat -c "%u" "$workdir")
gid=$(stat -c "%g" "$workdir")
echo "Setting builder UID: $uid; GID: $gid"

groupmod -g "$gid" builder
usermod -u "$uid" builder

sudo --user=builder --set-home --chdir=/workdir \
    --preserve-env=DEBEMAIL EDITOR=vim -- \
    "${@:-bash}"
