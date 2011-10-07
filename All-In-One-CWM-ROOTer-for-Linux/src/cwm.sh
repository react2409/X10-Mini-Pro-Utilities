#!/bin/bash
#
# If you edit script then please leave this section intact.
#
# All in one CWM Installer and ROOTer was originally created by react2409.

echo ""

echo "Starting ADB Server (If not already running)."
./adb/adb start-server
echo ""

echo "Mount system as R/W."
./adb/adb shell "mount -o rw,remount -t yaffs2 /dev/block/mtdblock0 /system"
echo ""

echo "Pushing recovery tar file."
./adb/adb push files/recovery.tar /system/bin/recovery.tar
echo "Pushing chargemon."
./adb/adb push files/chargemon /system/bin/chargemon
echo "Pushing busybox."
./adb/adb push files/busybox /system/bin/busybox
echo ""

echo "Setting permissions for recovery tar file."
./adb/adb shell "chmod 755 /system/bin/recovery.tar"
echo "Setting permissions for chargemon."
./adb/adb shell "chmod 755 /system/bin/chargemon"
echo "Setting permissions for busybox."
./adb/adb shell "chmod 755 /system/bin/busybox"
