rem Play the nth video in the INF1B-OOP youtube playlist with `oop n`
@echo off
set pos=%1
if %1==0 goto wrong

set /a pos=pos-1
set _tail=%*
call set _tail=%%_tail:*%1=%%
mpv --playlist-start=%pos% --hwdec --script-opts=mpvcord-active=yes https://www.youtube.com/playlist?list=PLNFclWaZfiVKcXdPjMR9_-8Q4JwZdUxTX %_tail%
goto exit

:wrong
echo Wrong arguments
goto exit

:exit
