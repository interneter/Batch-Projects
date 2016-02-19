@echo off
setlocal EnableDelayedExpansion

set "key=abcdef"
set "plaintext=abcdef"

call :KSA %key%
call :printarr
set i=0
set j=0

set strterm=___ENDOFSTRING___
set tmp=%plaintext%%strterm%

:loop
	set char=%tmp:~0,1%

	call :PRGA
	call :ord %char%
	for %%h in (!k!) do (for %%r in (!code!) do (set /a "res=%%h^%%r") )
	::echo !res!
	set tmp=%tmp:~1%
if not "%tmp%" == "%strterm%" goto loop

goto:eof

:KSA
	set "str=%~1"
	call :strlen %~1
	
	set j=0
	call :initarr
	for /l %%i in (0,1,255) do @(
		set /a keyindex = %%i %% !len!
		for %%z in (!keyindex!) do (call :toasciivalue !str:~%%z,1!)
		
		set si=!arr%%i!
		set /A j=!j!+!si!+!asciival!
		set /A j=!j! %% 256
		
		set tempswap=!arr%%i!
		for %%z in (!j!) do (
			for %%h in (arr%%i) do (set %%h=!arr%%z!)
			for %%h in (arr%%z) do (set %%h=!tempswap!)
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
			for %%h in (arr%%a) do (set %%h = !arr%%z!)
			for %%h in (arr%%z) do (set %%h=!tempswap!)
			set /A k=!arr%%z! + !arr%%a!
			set /A k=!k! %% 256
			for %%h in (!k!) do (set k=!arr%%h!)
		)
	)
	
goto:eof

:ord
	set code=0
	if [%~1] EQU [] goto END
	 
	set input=%1
	:: get first character of the input
	set target=%input:~0,1%
	 
		for /L %%i in (32, 1, 126) do (
			cmd /c exit /b %%i
			set Chr=^!=ExitCodeAscii!
			if [^!Chr!] EQU [^!target!] set code=%%i & goto:eof
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
	set #=%~1
	set length=0
	:stringLengthLoop
	if defined # (set #=%#:~1%&set /A length += 1&goto stringLengthLoop)
	set "len=%length%"
goto:eof