@echo off
setlocal

goto :Anfang
29.01.2025, 'kompiliert' die Textschnipsel
30.01.2025, Neu: Ordner für GruppenSkripte
07.02.2025, Neu: Ordner für BeispielSkripte
07.02.2025, Kosmetik: Die Ausgabe wurde vereinheitlicht

:Anfang

color 2e

rem Löschen und Neuanlage der bisherigen Skripte
rd .\#justext /q /s
md .\#justext 2>nul


echo Die Textschnipsel-Skripte werden erstellt ...
echo.


goto :weiter
Die BeispielSkripte können später freilich gelöscht und/oder hier ge-rem-t werden
echo BeispielSkripte werden verarbeitet
copy .\BeispielSkripte\*.cmd .\#justext\ /y|find "cmd"
copy .\BeispielSkripte\*.ini .\#justext\ /y
attrib +h ".\#justext\*.ini" > nul
echo.
:weiter


echo GruppenSkripte werden verarbeitet
copy .\GruppenSkripte\*.cmd .\#justext\ /y|find "cmd"
copy .\GruppenSkripte\*.ini .\#justext\ /y
attrib +h ".\#justext\*.ini" > nul
echo.


echo GruppenTexte werden verarbeitet
for /f %%f in (
'dir .\GruppenTexte\*.txt /b'
) do (
echo .\GruppenTexte\%%~nf.cmd
copy "_justext.template" ".\#justext\%%~nf.cmd" /y > nul
copy   ".\GruppenTexte\%%~nf.txt" ".\#justext\%%~nf.dat" /y > nul
attrib +h ".\#justext\%%~nf.dat" > nul
)
echo.


echo meineSkripte werden verarbeitet
copy .\MeineSkripte\*.cmd .\#justext\ /y|find "cmd"
copy .\MeineSkripte\*.ini .\#justext\ /y
attrib +h ".\#justext\*.ini" > nul
echo.


echo meineTexte werden verarbeitet
for /f %%f in (
'dir .\meineTexte\*.txt /b'
) do (
echo .\meineTexte\%%~nf.cmd
copy "_justext.template" ".\#justext\%%~nf.cmd" /y > nul
copy   ".\meineTexte\%%~nf.txt" ".\#justext\%%~nf.dat" /y > nul
attrib +h ".\#justext\%%~nf.dat" > nul
)
echo.


echo Just done!
timeout 3

rem start .\#justext
