@echo off
for /l %%a in (1,0,2) do @(%2 & timeout %1 & cls)