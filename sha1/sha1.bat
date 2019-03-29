@echo off

IF "%~1" == "" (set TRUE=1) ELSE (set TRUE=0)

if "%TRUE%" == "1" (
	echo Usage:
	echo 	%0 ^<FILE^>
	goto :EOF
) ELSE (
	set "file=%~1"
)

for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20 delims= " %%a in ('certutil -hashfile %file% sha1^|findstr /v hash') do @(echo %%a%%b%%c%%d%%e%%f%%g%%h%%i%%j%%k%%l%%m%%n%%o%%p%%q%%r%%s%%t)

:EOF