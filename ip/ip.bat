@echo off
certutil -urlcache -f -split http://wtfismyip.com/text 2>NUL 1>NUL 0>NUL
type text
del /a text