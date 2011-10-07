#!/bin/bash
#
# If you edit script then please leave this section intact.
#
# All in one CWM Installer and ROOTer was originally created by react2409.

echo "All in One CWM Installer and ROOTer for X10 Mini Pro by react2409."
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

read -p "Is your phone rooted? (y/n)" rooted
    case $rooted in
        [Nn]* ) sh root.sh;
		echo "";
		echo "Press the enter key to continue...";
                read contscr;;
        [Yy]* ) echo "";
		echo "Ok we can skip ROOTing the phone and go straight to installing CWM Recovery.";
     		echo "";;
        * ) echo "Please answer y or n";;
    esac

echo ""
sh cwm.sh

echo ""
echo ""
echo "Your phone should now be ROOTed and CWM Recovery should be installed."
echo "Instructions on how to use CWM Recovery are in the README.txt." 
