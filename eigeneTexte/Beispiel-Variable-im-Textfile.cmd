@echo off
setlocal
color 2e
title %~n0
echo.
echo Das is ein tolles Beispiel mit einer ausgelagerten Variablen.
rem Die .ini Datei muss denselben Namen haben, wie das Skript. Nur die Erweiterung muss natürlich ".ini" sein.
echo.

rem Einlesen der Variable "ich" aus der .ini
rem Der Teil "%~n0" wird aufgelöst zu dem Dateinamen (ohne Erweiterung).
set /p ich=<"%~n0.ini"

rem Abfrage der Variablen "du" per Eingabe
set /p du="Wie bist Du? "

echo Moin, ich bin %ich% und du bist %du%.|clip