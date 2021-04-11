% Start playing music with `yta search term here`
% Will keep autoplaying based on YouTube's autoplay thing
@echo off
for /f "tokens=* usebackq" %%f in (`youtube-dl "ytsearch1:%*" --get-id`) do set playid=%%f
set youtubeurl=https://www.youtube.com/watch?v=%playid%

:loop
mpv --volume=50 --no-video --loop=no --loop-playlist=no --script-opts=mpvcord-active=yes %youtubeurl%
for /F "usebackq tokens=*" %%i in (`curl -s "%youtubeurl%" ^| wsl grep -Po "\"autoplay\":{\"autoplay\":(?:.*?)\"watchEndpoint\":{\"videoId\":\"\K.*?(?^=\")" ^| wsl awk '{print "https://www.youtube.com/watch?v="$1}'`) do (
set youtubeurl=%%i
goto loop
)
