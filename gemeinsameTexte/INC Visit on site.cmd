@echo off
setlocal
color 2e
title %~n0
echo.
echo Zur Dokumentation im Tickettool
echo.

echo INC Visit on site...
echo.
set /p bla="was wurde beim Besuch vor Ort getan? "

echo Visit on site: %bla%|clip
