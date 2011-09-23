@echo off
@title ClockWorkMod Recovery Installer Version 1
@echo ClockWorkMod Recovery Installer for X10 Mini Pro by rect2409.
@echo Requirements and credits are listed in the README.txt file.
@echo Please make sure requirements are met before continuing.
@echo.
@echo.
pause
@echo.


set /p root=Is your device ROOTed? (Y/N):
if %root% == Y goto Continue
if %root% == y goto Continue
if %root% == N goto Fix
if %root% == n goto Fix

:Fix
@echo.
@echo For this to work you need to ROOT your device.
@echo Please enable USB Debugging on your device then click ROOT in the application that opens.
start superoneclick\SuperOneClick.exe
@echo.

@echo Once SuperOneClick is finished then please continue.
pause
@echo.

@echo Starting ADB Server if not started (SuperOneClick stops it).
adb\adb.exe start-server
@echo.
goto TwoQuestion

:Continue
@echo.
@echo Starting ADB Server.
adb\adb.exe start-server
@echo.
@echo Pushing exploit to gain ROOT access.
adb\adb.exe push files\rageagainstthecage /data/local/tmp/expl
adb\adb.exe shell "chmod 777 /data/local/tmp/expl"
adb\adb.exe shell "/data/local/tmp/expl"
adb\adb.exe wait-for-device
@echo.
goto TwoQuestion

:TwoQuestion
@echo Mount system as R/W.
adb\adb.exe shell "mount -o rw,remount -t yaffs2 /dev/block/mtdblock0 /system"
@echo.

set /p recovery=Do you already have a recovery installed? (Y/N):
if %recovery% == Y goto DelRec
if %recovery% == y goto DelRec
if %recovery% == N goto Complete
if %recovery% == n goto Complete

:DelRec
@echo.
@echo Removing old recovery.
adb\adb.exe shell "rm /system/bin/recovery.tar"
adb\adb.exe shell "rm /system/bin/chargemon"
adb\adb.exe shell "rm /system/bin/busybox"
goto Complete

:Complete
@echo.
@echo Pushing recovery tar file.
adb\adb.exe push files\recovery.tar /system/bin/recovery.tar
@echo Pushing chargemon.
adb\adb.exe push files\chargemon /system/bin/chargemon
@echo Pushing busybox.
adb\adb.exe push files\busybox /system/bin/busybox
@echo.

@echo Setting permissions for recovery tar file.
adb\adb.exe shell "chmod 755 /system/bin/recovery.tar"
@echo Setting permissions for chargemon.
adb\adb.exe shell "chmod 755 /system/bin/chargemon"
@echo Setting permissions for busybox.
adb\adb.exe shell "chmod 755 /system/bin/busybox"
@echo.

@echo Mount system as read only.
adb\adb.exe shell "mount -o r,remount -t yaffs2 /dev/block/mtdblock0 /system"
@echo.

@echo Reboot phone.
adb\adb.exe reboot
@echo.

@echo Stopping ADB Server.
adb\adb.exe kill-server
@echo.

@echo.
@echo.
@echo If no errors are listed above then CWM has been installed.
@echo Finished.
pause