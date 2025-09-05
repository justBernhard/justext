@echo off
setlocal
color 2e
title %~n0
echo.
echo ruft die HTTP-Seite eines Druckers auf (z.B. PRN123 bzw. 1.2.3.4)
echo.

set /p prn="Druckername oder IP? "

start http://%prn%