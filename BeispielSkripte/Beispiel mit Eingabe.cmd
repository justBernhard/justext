@echo off
setlocal
color 2e
title %~n0
echo.
echo Das is ein tolles Beispiel mit einer tollen Eingabe.
echo.

rem Abfrage der Variablen "bla" per Eingabe
set /p bla="Wann hast Du Geburtstag? "

echo Ich habe am %bla% Geburtstag|clip
