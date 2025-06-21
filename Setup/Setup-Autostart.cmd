@echo off
chcp 1252>nul
rem 07.02.2025, Bernhard Just, kopiert die justext.lnk in den Autostart Ordner des aktuellen Users.

echo.
echo %~n0 kopiert die Verknüpfung zu #justext in den Autostart Ordner aktuellen Users (%USERNAME%)
echo Über diese Verknüpfung wird der Ordner mit den Textschnipsel-Skripten beim Start von Windows aufgerufen.
echo Kopiert wird nach der Pause.
pause

copy .\justext.lnk "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /y
echo.

echo Ist die "justext.lnk" auch da?
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\just*"
echo.
pause
