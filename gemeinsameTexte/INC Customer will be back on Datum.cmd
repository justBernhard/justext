@echo off
setlocal
color 2e
title %~n0
echo.
echo Zur Dokumenation im Tickettool wann ein Kunde wiederkehrt.
echo.

set /p bla="Customer will be back on Tag.Monat.(%date:~6,4%)? "

echo Customer will be back on %bla%.%date:~6,4%|clip
