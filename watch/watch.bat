@echo off

IF "%~1" == "" (set TRUE=1) ELSE (set TRUE=0)
IF "%~2" == "" (set TRUE=1) ELSE (set TRUE=0)

if "%TRUE%" == "1" (
	echo Usage:
	echo 	%0 ^<TIMEOUT^> ^<FILE^>
	goto :EOF
) ELSE (
	set "timeout=%~1"
	set "command=%~2"
)

for /l %%a in (1,0,2) do @(%command% & timeout %timeout% & cls)

:EOF