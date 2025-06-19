@echo off
setlocal
color 2e
title %~n0
echo.
echo Mehrfach erstelltes Ticket. Dieses Ticket wird daher geschlossen und der Fall in INC1234567 bearbeitet. 
echo.

set /p bla="In welchem Ticket wird das Thema weiterbehandelt? "

echo Ticket created multiple times. This ticket will be therefore closed and the incident is processed in %bla%|clip