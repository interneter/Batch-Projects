@echo off

IF "%~1" == "" (set TRUE=1) ELSE (set TRUE=0)
IF "%~2" == "" (set TRUE=1) ELSE (set TRUE=0)
IF "%~3" == "" (set TRUE=1) ELSE (set TRUE=0)

if "%TRUE%" == "1" (
	echo Usage:
	echo 	%0 ^<IP^> ^<PORT^> ^<TIMEOUT^>
	goto :EOF
) ELSE (
	set "ip=%~1"
	set "port=%~2"
	set "timeout=%~3"
)


del %ip%%port%.txt 0>NUL 1>NUL 2>NUL
start cmd /c "timeout 1 >NUL & timeout %timeout% >NUL & (netstat -ano | findstr ESTA | findstr %ip%:%port%) && (taskkill /f /im ftp.exe & echo. > %ip%%port%.txt)"
(echo quit | (echo open %ip% %port% | ftp)) 0>NUL 1>NUL 2>NUL
timeout %timeout% >NUL
if EXIST %ip%%port%.txt (
	echo %ip%:%port% Open.
) ELSE (
	echo %ip%:%port% Closed.
)
del %ip%%port%.txt 0>NUL 1>NUL 2>NUL

:EOF