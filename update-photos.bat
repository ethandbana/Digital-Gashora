@echo off
echo Scanning images folders...

set output=photos.json
echo {> %output%

set first=1

for /d %%F in (images\*) do (
    set "folder=%%~nxF"
    if not "!first!"=="1" echo ,>> %output%
    echo   "%%~nxF": [>> %output%
    
    set firstFile=1
    for %%I in ("%%F\*.jpg" "%%F\*.jpeg" "%%F\*.png" "%%F\*.gif" "%%F\*.webp" "%%F\*.JPG" "%%F\*.PNG") do (
        if exist "%%I" (
            if not "!firstFile!"=="1" echo ,>> %output%
            set "filename=%%~nxI"
            set "name=%%~nI"
            echo     { "file": "%%~nxI", "name": "%%~nI" }>> %output%
            set firstFile=0
        )
    )
    echo   ]>> %output%
    set first=0
)

echo }>> %output%

echo Done! photos.json has been created.
echo Now run: git add . & git commit -m "Updated photos" & git push
pause