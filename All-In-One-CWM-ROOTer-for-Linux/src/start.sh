#!/bin/bash
#
# If you edit script then please leave this section intact.
#
# CWM Installer for Linux was originally created by react2409 for XDA.
# It is released on XDA under the username rect2409.

echo "ClockWorkMod Recovery Installer for X10 Mini Pro by react2409."
echo "Requirements and credits are listed in the README.txt file."
echo "Please make sure requirements are met before continuing."
echo ""
echo ""
echo "Press the enter key to continue..."
read contscr

read -p "Is USB Debugging enabled on your phone? (y/n)" usbdebug
    case $usbdebug in
        [Nn]* ) echo "Please turn USB Debugging on. You can find it at:";
                echo "Settings > Applications > Development > Check 'USB debugging'";
		echo "Once done run this again.";
                exit;;
        [Yy]* ) echo "Great lets start the process.";
     		echo "";;
        * ) echo "Please answer y or n";;
    esac

echo "Starting ADB Server."
./adb/adb start-server
echo ""

read -p "Is your phone rooted? (y/n)" rooted
    case $rooted in
        [Nn]* ) echo "This installer requires that yor phone is ROOTed.";
                echo "Luckily for you we have managed to create you a Linux app";
		echo "that can do this for you.";
		echo "There is a link to it in the README.txt.";
                exit;;
        [Yy]* ) echo "Pushing exploit to the phone.";
     		./adb/adb push files/rageagainstthecage /data/local/tmp/expl;
		./adb/adb shell "chmod 777 /data/local/tmp/expl";
		echo "Run the exploit.  There may be a delay whilst this is happening."
     		./adb/adb shell "/data/local/tmp/expl";
     		./adb/adb wait-for-device;
     		echo "";;
        * ) echo "Please answer y or n";;
    esac

echo "Mount system as R/W."
./adb/adb shell "mount -o rw,remount -t yaffs2 /dev/block/mtdblock0 /system"
echo ""

read -p "Did the system get re-mounted correctly (no errors)? (y/n)" remount
    case $remount in
        [Nn]* ) echo "Please check you meet the requirements.";
                echo "If you do then copy and paste all the above and ask a question";
		echo "in the thread on XDA. Link is in the README.txt";
                exit;;
        [Yy]* ) echo "Great we can continue.";
     		echo "";;
        * ) echo "Please answer y or n";;
    esac

echo "Pushing recovery tar file."
./adb/adb push files/recovery.tar /system/bin/recovery.tar
echo "Pushing chargemon."
./adb/adb push files/chargemon /system/bin/chargemon
echo "Pushing busybox."
./adb/adb push files/busybox /system/bin/busybox
echo ""

read -p "Did the get pushed correctly (no errors)? (y/n)" push
    case $push in
        [Nn]* ) echo "Please copy and paste all the above and ask a question";
		echo "in the thread on XDA. Link is in the README.txt";
                exit;;
        [Yy]* ) echo "Great we can continue.";
     		echo "";;
        * ) echo "Please answer y or n";;
    esac

echo "Setting permissions for recovery tar file."
./adb/adb shell "chmod 755 /system/bin/recovery.tar"
echo "Setting permissions for chargemon."
./adb/adb shell "chmod 755 /system/bin/chargemon"
echo "Setting permissions for busybox."
./adb/adb shell "chmod 755 /system/bin/busybox"
echo ""

echo "Reboot phone."
./adb/adb reboot
echo ""

echo "Stopping ADB Server."
./adb/adb kill-server

echo ""
echo ""
echo "ClockWorkMod has been successfully installed."
echo "Instructions on how to use it are in the README.txt." 
echo "Finished."
