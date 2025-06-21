@echo off
chcp 1252>nul
rem 07.02.2025, Bernhard Just, kopiert die justext.lnk ins Startmenü des aktuellen Users.

echo.
echo %~n0 kopiert die Verknüpfung zu #justext ins Startmenü des aktuellen Users (%USERNAME%)
echo Über diese Verknüpfung wird der Ordner mit den Textschnipsel-Skripten aufgerufen.
echo Kopiert wird nach der Pause.
pause

copy .\justext.lnk "%APPDATA%\Microsoft\Windows\Start Menu\Programs" /y
echo.

echo Ist die "justext.lnk" auch da?
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\just*"
echo.
pause
