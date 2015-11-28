@echo off
color 0A
for /f %%A in ('dir /b /a:a *.apk ^| find /v /c ""') do set cnt=%%A
set /a line_count = %cnt% + 24

:welcomeMessage
	mode con: cols=62 lines=%line_count%
	echo  ===========================================================
	echo.
	echo   Welcome to Aditya and Nicholas' Automatic Layers Installer
	echo.
	echo  ===========================================================
	echo.
	echo   This app cuts down the tedious work of consistently pushing
	echo   and rebooting your device. Why not do it all in one button?
	echo.
	echo   To use this automator, please type in the name of the file 
	echo   at the prompt and you can consistently push the same APK
	echo   to your device which automatically soft reboots after push.
	echo.
	echo  ===========================================================
	echo.
	echo             APK Files Found in current directory
	echo.
	dir /b /a:a *.apk
	echo -----------------------------------------------------------
	echo.
	goto :initializeParameters

:initializeParameters
	set /a "exceptioncounter = 3"
	set /a "availablecounter = 2"
	set /a filename = null
	goto :fileNameChecker
	
:fileNameChecker
	if %exceptioncounter% equ 0 (
		goto :break
	)
	echo Type the name of your file without the
	set /p filename=" file extension (click return to quit): "
	if %filename%==[%1]==[] (
		goto :break
	) else (
		if %filename% neq 0 (
			if %exceptioncounter% neq -1 (
				if exist "%filename%.apk" (
					goto :performTasks
				) else (
					set /a exceptioncounter -= 1
					echo.
					echo You have entered an incorrect file name. Please try again.
					echo You have %availablecounter% error attempts left.
					set /a availablecounter -= 1
					echo.
					goto :fileNameChecker
				)
			) else (
				goto :break
			)
		) else (
			goto :break
		)
	)

:performTasks
	mode con: cols=62 lines=10
	echo  ===========================================================
	echo  You are currently handling "%filename%.apk"
	echo  ===========================================================
	echo.
	echo  What would you like to do? 
	set /p whattodo="(Return to PUSH, other keys for MAIN MENU): "
	if %whattodo%==[%1]==[] (
		adb root
		adb shell "mount -o remount,rw /system"
		adb push "%filename%.apk" /system/vendor/overlay
		adb shell "mount -o remount,ro /system"
		adb shell su -c "killall system_server"
		adb shell su -c "exit"
		cls
		goto :performTasks
	) else (
		cls
		goto welcomeMessage
	) 
:break