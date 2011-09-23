#!/bin/sh

echo "ClockWorkMod Recovery Installer for X10 Mini Pro by rect2409."
echo "Requirements and credits are listed in the README.txt file."
echo "Please make sure requirements are met before continuing."
echo ""
echo ""
echo "Press the enter key to continue..."
read contscr

echo "Starting ADB Server."
./adb/adb start-server
echo ""

read -p "Is your phone rooted? (y/n)" rooted
    case $rooted in
        [Nn]* ) echo "This installer requires that yor phone is ROOTed.";
                echo "Please ROOT your phone and then run this script again"
                exit;;
        [Yy]* ) echo "Pushing exploit to gain ROOT access.";
     		./adb/adb push files/rageagainstthecage /data/local/tmp/expl;
		./adb/adb shell "chmod 777 /data/local/tmp/expl";
     		./adb/adb shell "/data/local/tmp/expl";
     		./adb/adb wait-for-device;
     		echo "";;
        * ) echo "Please answer y or n";;
    esac

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
echo ""

echo "Re-mount system as R/O."
./adb/adb shell "mount -o r,remount -t yaffs2 /dev/block/mtdblock0 /system"
echo ""

echo "Reboot phone."
./adb/adb reboot
echo ""

echo "Stopping ADB Server."
./adb/adb kill-server

echo ""
echo ""
echo "If no errors are listed above then CWM has been installed."
echo "Finished."
