@echo off
set zeit=%time:~0,5%
rem so kommt die führende 0 dazu
rem https://www.ugg.li/windows-batch-uhrzeit-und-datum-verwenden-mit-fuehrender-0-bei-einstelligen-stunden/
if "%zeit:~0,1%" == " " SET zeit=0%zeit:~1,5%
echo %date% %zeit% |clip