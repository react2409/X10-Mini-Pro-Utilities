#!/bin/bash
#
# If you edit script then please leave this section intact.
#
# ROOTer for Linux was originally created by react2409.
# It is released on XDA under the username rect2409.

echo "ROOTer for Linux by react2409."
echo "Requirements and credits are listed in the README.txt file."
echo "Please make sure requirements are met before continuing."
echo "Remember by using this you understand the risks involved with doing so."
echo ""
echo ""

# Additional safety check to see if you already ROOTed.
read -p "Is your phone already rooted? (y/n)" rooted
    case $rooted in
	[Yy]* ) echo "";
		echo "You do NOT need to run this script then."
		echo "This script is now terminating.";
		exit;;
        [Nn]* ) echo "";;
        * ) echo "Please answer y or n";;
    esac

# Do you wish to continue prompt.
read -p "Do you wish to continue with the ROOTing? (y/n)" contin
    case $contin in
        [Nn]* ) echo "";
		echo "Okay this script will now terminate";
                exit;;
        [Yy]* ) echo "";;
        * ) echo "Please answer y or n";;
    esac

# Check for USB debugging.  Without it the script won't work.
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

echo "Starting ADB server."
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
./adb/adb push files/busybox /system/xbin/busybox
echo ""

echo "Setting permissions for su."
./adb/adb shell "chmod 4755 /system/xbin/su"
echo "Setting permissions for busybox."
./adb/adb shell "chmod 4755 /system/xbin/busybox"
echo ""

echo "Reboot phone."
./adb/adb reboot
echo ""

echo "Stopping ADB Server."
./adb/adb kill-server

echo ""
echo ""
echo "Your phone should now be ROOTed."
