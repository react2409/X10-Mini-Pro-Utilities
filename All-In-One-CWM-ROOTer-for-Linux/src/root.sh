#!/bin/bash
#
# If you edit script then please leave this section intact.
#
# All in one CWM Installer and ROOTer was originally created by react2409.

echo ""

echo "Starting ADB server (If not already running)."
./adb/adb start-server
echo ""

echo "Wait for phone to be ready."
./adb/adb wait-for-device
echo ""

echo "Push the exploit to the phone."
./adb/adb push files/rageagainstthecage /data/local/tmp/expl
./adb/adb shell "chmod 777 /data/local/tmp/expl"
echo ""

echo "Run the exploit. There may be a delay whilst this is happening."
./adb/adb shell "/data/local/tmp/expl"
./adb/adb wait-for-device
echo ""

echo "Mount system as R/W."
./adb/adb shell "mount -o rw,remount -t yaffs2 /dev/block/mtdblock0 /system"
echo ""

echo "Push su to phone."
./adb/adb push files/su /system/xbin/su
echo "Push Superuser.apk to phone."
./adb/adb push files/Superuser.apk /system/app/Superuser.apk
echo "Push busybox to phone."
./adb/adb push files/busybox-rooter /system/xbin/busybox
echo ""

echo "Setting permissions for su."
./adb/adb shell "chmod 4755 /system/xbin/su"
echo "Setting permissions for busybox."
./adb/adb shell "chmod 4755 /system/xbin/busybox"
