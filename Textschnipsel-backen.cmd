@echo off
setlocal

color f0
title %~n0
echo.

echo Die Textschnipsel werden aus den Texte-Ordnern erstellt

rem Löschen der bisherigen Skripte und Neuanlage des Ordners.
rd #justext /q /s > nul 2>&1
md #justext > nul 2>&1

rem Die Textschnipsel-Ordner.ini wird als Grundlage für die zu verarbeitenden Ordner
rem Falls es keine Textschnipsel-Ordner.ini gibt, wird eine leere angelegt
if not exist Textschnipsel-Ordner.ini echo. > Textschnipsel-Ordner.ini
copy Textschnipsel-Ordner.ini %TEMP%\Textschnipsel-Ordner.tmp /y > nul 2>&1

rem Danach werden die Ordner im aktuellen Ordner in die Textschnipsel-Ordner.tmp geschrieben
for /d %%c in (*Texte) do (
	echo %%c >> %TEMP%\Textschnipsel-Ordner.tmp
)

for /f %%d in (%TEMP%\Textschnipsel-Ordner.tmp) do (

	echo.
	echo erstelle Schnipsel aus: %%d

	rem Kopieren fertiger Skripte und zugehöriger .ini
	copy %%d\*.cmd #justext\ /y|find "cmd"
	copy %%d\*.ini #justext\ /y > nul 2>&1

	rem "delims=": Diese Option setzt die Liste der Trennzeichen auf leer. Dadurch wird der gesamte Dateiname, inklusive Leerzeichen, der Variablen %%f zugewiesen.
	for /f "delims=" %%f in ('dir %%d\*.txt /b') do (
		echo %%d\%%~nf.cmd

		rem Hier beginnt die Magie: Die Dateinamen der Textdateien werden in der Schleife (%%f) genutzt, 
		rem um im Zielordner entsprechende, gleichnamige Paare aus .cmd und .dat zu ertellen.
		rem Die die _justext.template wird zur .cmd und die .dat enthält den Text, aus dem sich die .cmd bei der Anwendung den Textschnipsel holt.
		copy "_justext.template" "#justext\%%~nf.cmd" /y > nul 2>&1
		copy "%%d\%%~nf.txt" "#justext\%%~nf.dat" /y > nul 2>&1
	)

)

del %TEMP%\Textschnipsel-Ordner.tmp

rem Damit im #justext Ordner ausschließlich .cmd Dateien zu sehen sind, werden andere versteckt.
attrib +h "#justext\*.dat" > nul 2>&1
attrib +h "#justext\*.ini" > nul 2>&1

echo.

echo Just done!
timeout 11
