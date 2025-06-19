@echo off
setlocal
color 2e
title %~n0
echo.
echo Frage auf Deutsch an Kunden, wann ich mir das vor Ort ansehen kann.
echo.

set /p ich=<ich.ini

set /p bla="welches Thema, Fehlfunktion? "

echo Moin, ich bin %ich% vom Onsite Support. Betreffend %bla%: Wann kann ich mir das wo anschauen?|clip