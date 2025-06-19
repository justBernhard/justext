@echo off
setlocal
color 2e
title %~n0
echo.
echo Zur Dokumentation einer Kundenkommunikation im Tickettool
echo.

echo INC Conversation with customer ...
echo.
set /p bla="Was war das Thema unserer Konversation? "

echo Conversation with customer ... %bla%|clip
