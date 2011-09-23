#!/bin/sh

echo "ROOTer for Linux by rect2409."
echo "Requirements and credits are listed in the README.txt file."
echo "Please make sure requirements are met before continuing."
echo ""
echo ""
echo "Press the enter key to continue..."
read contscr

echo "Starting ADB server."
./adb/adb start-server
echo ""

echo "Wait for phone to be ready."
./adb/adb wait-for-device
echo ""

echo "Push exploit to phone and run."
./adb/adb push files/rageagainstthecage /data/local/tmp/expl
./adb/adb shell "chmod 777 /data/local/tmp/expl"
./adb/adb shell "/data/local/tmp/expl"
echo ""

echo "Wait for phone to be ready."
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
./adb/adb push files/busybox /system/xbin/busybox
echo ""

echo "Setting permissions for su."
./adb/adb shell "chmod 4755 /system/xbin/su"
echo "Setting permissions for busybox."
./adb/adb shell "chmod 4755 /system/xbin/busybox"
echo ""

echo "Re-mount system as R/O."
./adb/adb shell "mount -o ro,remount -t yaffs2 /dev/block/mtdblock0 /system"
echo ""

echo "Reboot phone."
./adb/adb reboot
echo ""

echo "Stopping ADB Server."
./adb/adb kill-server

echo ""
echo ""
echo "Your phone should now be ROOTed."
