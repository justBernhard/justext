@echo off
chcp 65001 >NUL
setlocal

color 2e

rem Löschen und Neuanlage der bisherigen Skripte
rd .\#justext /q /s
md .\#justext 2>nul


title Die Textschnipsel-Skripte werden erstellt ...


echo gemeinsameTexte werden verarbeitet
copy .\gemeinsameTexte\*.cmd .\#justext\ /y|find "cmd"
copy .\gemeinsameTexte\*.ini .\#justext\ /y
attrib +h ".\#justext\*.ini" > nul
echo.

for /f %%f in (
'dir .\gemeinsameTexte\*.txt /b'
) do (
echo .\gemeinsameTexte\%%~nf.cmd
copy "_justext.template" ".\#justext\%%~nf.cmd" /y > nul
copy   ".\gemeinsameTexte\%%~nf.txt" ".\#justext\%%~nf.dat" /y > nul
attrib +h ".\#justext\%%~nf.dat" > nul
)
echo.


echo eigeneTexte werden verarbeitet
copy .\eigeneTexte\*.cmd .\#justext\ /y|find "cmd"
copy .\eigeneTexte\*.ini .\#justext\ /y
attrib +h ".\#justext\*.ini" > nul
echo.

for /f %%f in (
'dir .\eigeneTexte\*.txt /b'
) do (
echo .\eigeneTexte\%%~nf.cmd
copy "_justext.template" ".\#justext\%%~nf.cmd" /y > nul
copy   ".\eigeneTexte\%%~nf.txt" ".\#justext\%%~nf.dat" /y > nul
attrib +h ".\#justext\%%~nf.dat" > nul
)
echo.


echo Just done!
timeout 3
