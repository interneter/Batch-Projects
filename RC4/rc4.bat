@echo off
setlocal EnableDelayedExpansion

set "str=abcdef"
call :KSA %str%
set i=0
set j=0

call :PRGA

goto:eof

:KSA
	call :strlen %~1
	set "str=%~1"
	
	set j=0
	call :initarr
	for /l %%i in (0,1,256) do @(
		Set /a keyindex = %%i %% !len!
		for %%z in (!keyindex!) do (call :toasciivalue !str:~%%z,1!)
		set /A j=!j!+%%i+!asciival!
		set /A j=!j! %% 256
		
		set tempswap=!arr%%i!
		for %%z in (!j!) do (
			for %%h in (arr%%z) do (set %%h=!tempswap!)
			for %%h in (arr%%i) do (set %%h = !arr%%z!)
		)
	)
goto:eof

:PRGA
	set /A i=!i! + 1
	set /A i=!i! %% 256
	for %%h in (!i!) do (set /A j=!j! + !arr%%h!)
	set /A j=!j! %% 256
	
	for %%a in (!i!) do (
		set tempswap=!arr%%a!
		for %%z in (!j!) do (
			for %%h in (arr%%z) do (set %%h=!tempswap!)
			for %%h in (arr%%a) do (set %%h = !arr%%z!)
		)
	)
	
	
goto:eof

:initarr
	for /l %%x in (0,1,255) do (set arr%%x=%%x)
goto:eof

:printarr
	for /l %%x in (0,1,255) do (echo !arr%%x!)
goto:eof

:toasciivalue
	set asciival=0
	for /L %%a in (33,1,126) do (
		cmd /c exit %%a
		if "!=exitcodeAscii!"=="%~1" set "asciival=%%a"
	)
goto:eof

:strlen
	set len=0
	echo %~1 > %temp%\tmp24921.TMP
	for /f "tokens=4 delims= " %%a in ('dir %temp%\tmp24921.TMP^|findstr tmp24921.TMP') do (
		set len=%%a> NUL
	)
	del /a %temp%\tmp24921.TMP
	set /A len=%len%-4
goto:eof
