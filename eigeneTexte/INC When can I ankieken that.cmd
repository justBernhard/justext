@echo off
setlocal
color 2e
title %~n0
echo.
echo Frage auf Englisch an Kunden, wann ich mir das vor Ort ansehen kann.
echo.

set /p ich=<ich.ini

set /p bla="which topic/issue? "

echo Moin, I'm %ich% from Onsite Support. Regarding %bla%: When can I have a look at this where?|clip