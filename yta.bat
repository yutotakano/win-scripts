rem Start playing music with `yta search term here`
rem Will keep autoplaying based on YouTube's autoplay thing
@echo off
setlocal EnableDelayedExpansion
for /f "tokens=* usebackq" %%f in (`youtube-dl "ytsearch1:%*" --get-id`) do set playid=%%f
set currentUrl=https://www.youtube.com/watch?v=%playid%
set /a videoCount=0

:loop
set history[!videoCount!]=%currentUrl%
mpv --volume=50 --no-video --loop=no --loop-playlist=no --script-opts=mpvcord-active=yes %currentUrl%

set found=false
for /F "usebackq tokens=*" %%i in (`curl -s "%currentUrl%" ^| wsl grep -Po "\"watchEndpoint\":{\"videoId\":\"\K.*?(?^=\")" ^| wsl awk '{print "https://www.youtube.com/watch?v="$1}'`) do (
    rem loop through all related videos and choose first one not in history
    for /l %%h in (0,1,%videoCount%) do (
        if !history[%%h]!==%%i (
            set found=true
        )
    )
    if !found!==false (
        set /a videoCount=%videoCount%+1
        set currentUrl=%%i
        goto loop
    )
)
echo Repetitive tracks reached, ending.
