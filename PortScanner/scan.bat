@echo off

set "ip=%1"
set "port=%2"
set "timeout=%3"


del %ip%%port%.txt 0>NUL 1>NUL 2>NUL
start cmd /c "timeout 1 >NUL & timeout %3 >NUL & (netstat -ano | findstr ESTA | findstr %ip%:%port%) && (taskkill /f /im ftp.exe & timeout 1 >NUL & echo. > %ip%%port%.txt)"
(echo quit | (echo open %ip% %port% | ftp)) 0>NUL 1>NUL 2>NUL
if EXIST %ip%%port%.txt (
	echo %ip%:%port% Open.
) ELSE (
	echo %ip%:%port% Closed.
)
del %ip%%port%.txt 0>NUL 1>NUL 2>NUL