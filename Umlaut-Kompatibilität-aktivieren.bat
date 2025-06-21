@echo off
setlocal

:: Define the input and output file names
set "inputFile=Textschnipsel-machen.cmd"
set "outputFile=Textschnipsel-machen_ANSI.cmd" :: Appending _ANSI to the new file name

:: Check if the input file exists
if not exist "%inputFile%" (
    echo Error: Input file "%inputFile%" not found!
    pause
    exit /b 1
)

echo Converting "%inputFile%" to ANSI...

:: PowerShell command to read UTF-8 and write as OEM (ANSI)
powershell.exe -Command "& {Get-Content -Path '%inputFile%' -Encoding UTF8 | Set-Content -Path '%outputFile%' -Encoding OEM}"

:: Optional: If the above causes issues with specific characters, try -Encoding Default
:: powershell.exe -Command "& {Get-Content -Path '%inputFile%' -Encoding UTF8 | Set-Content -Path '%outputFile%' -Encoding Default}"

if exist "%outputFile%" (
    echo Conversion complete! ANSI file saved as "%outputFile%"
    echo.
    echo To use the new ANSI file, you might want to rename it:
    echo    ren "%outputFile%" "%inputFile%"
    echo    del "%inputFile%_old"
) else (
    echo Error: Conversion failed. "%outputFile%" was not created.
)

pause
endlocal