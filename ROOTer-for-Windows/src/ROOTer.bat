:: If you edit script then please leave this section intact.
::
:: ROOTer for Windows was originally created by react2409.
:: It is released on XDA under the username rect2409.

@echo off
@title ROOTer for Windows Version 1
@echo ROOTer for Windows by rect2409.
@echo Requirements and credits are listed in the README.txt file.
@echo Please make sure requirements are met before continuing.
@echo Remember by using this you understand the risks involved with doing so.
@echo.
@echo.

:: Additional safety check to see if you already ROOTed.
set /p root=Is your phone already ROOTed? (y/n):
if %root% == Y goto Done
if %root% == y goto Done
if %root% == N goto Cont1
if %root% == n goto Cont1

:: Terminates script
:Done
@echo.
@echo You do NOT need to run this script then.
@echo This script is now terminating.
exit

:Cont1
:: Do you wish to continue prompt.
@echo.
set /p check=Do you wish to continue with the ROOTing? (y/n):
if %check% == Y goto Cont2
if %check% == y goto Cont2
if %check% == N goto Term
if %check% == n goto Term

:: Terminates script
:Term
@echo.
@echo Okay this script will now terminating.
exit

:Cont2
:: Check for USB debugging.  Without it the script won't work.
@echo.
set /p debug=Is USB Debugging enabled on your phone? (y/n):
if %debug% == Y goto Cont3
if %debug% == y goto Cont3
if %debug% == N goto Fin
if %debug% == n goto Fin

:: Terminates script
:Term
@echo.
@echo Please turn USB Debugging on. You can find it at:
@echo Settings > Applications > Development > Check 'USB debugging'
@echo Once done run this again.
exit

:Cont3
@echo.
@echo Great thats all the questions over now lets start the process.

@echo Starting ADB Server.
adb\adb.exe start-server
@echo.

@echo Wait for phone to be ready.
adb\adb.exe wait-for-device
@echo.

@echo Push the exploit to the phone.
adb\adb.exe push files\rageagainstthecage /data/local/tmp/expl
adb\adb.exe shell "chmod 777 /data/local/tmp/expl"
@echo.

@echo Run the exploit. There may be a delay whilst this is happening.
adb\adb.exe shell "/data/local/tmp/expl"
adb\adb.exe wait-for-device
@echo.

@echo Mount system as R/W.
adb\adb.exe shell "mount -o rw,remount -t yaffs2 /dev/block/mtdblock0 /system"
@echo.

@echo Push su to phone.
adb\adb.exe push files\su /system/xbin/su
@echo Push Superuser.apk to phone.
adb\adb.exe push files\Superuser.apk /system/app/Superuser.apk
@echo Push busybox to phone.
adb\adb.exe push files\busybox /system/xbin/busybox
@echo.

@echo Setting permissions for su.
adb\adb.exe shell "chmod 4755 /system/xbin/su"
@echo Setting permissions for busybox.
adb\adb.exe shell "chmod 4755 /system/xbin/busybox"
@echo.

@echo Reboot phone.
adb\adb.exe reboot
@echo.

@echo Stopping ADB Server.
adb\adb.exe kill-server

@echo.
@echo.
@echo Your phone should now be ROOTed.
pause