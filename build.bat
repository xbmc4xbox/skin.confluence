@echo off
SET ADDON_NAME_ID=skin.confluence

ECHO ----------------------------------------
echo Creating Confluence Build Folder
IF EXIST BUILD rmdir BUILD /S /Q
md BUILD

Echo .git>exclude.txt
Echo Thumbs.db>>exclude.txt
Echo Desktop.ini>>exclude.txt
Echo dsstdfx.bin>>exclude.txt
Echo exclude.txt>>exclude.txt

ECHO ----------------------------------------
ECHO Creating XPR File...
START /B /WAIT XBMCTex -input media -output media -noprotect

ECHO ----------------------------------------
ECHO Copying XPR File...
xcopy "media\Textures.xpr" "BUILD\%ADDON_NAME_ID%\media\" /Q /I /Y

ECHO ----------------------------------------
ECHO Cleaning Up...
del "media\Textures.xpr"

ECHO ----------------------------------------
ECHO XPR Texture Files Created...
ECHO Building Skin Directory...
xcopy "fonts" "BUILD\%ADDON_NAME_ID%\fonts" /E /Q /I /Y /EXCLUDE:exclude.txt
xcopy "backgrounds" "BUILD\%ADDON_NAME_ID%\backgrounds" /E /Q /I /Y /EXCLUDE:exclude.txt
xcopy "resources" "BUILD\%ADDON_NAME_ID%\resources" /E /Q /I /Y /EXCLUDE:exclude.txt
xcopy "720p\*.*" "BUILD\%ADDON_NAME_ID%\720p\" /Q /I /Y /EXCLUDE:exclude.txt
xcopy "colors\*.*" "BUILD\%ADDON_NAME_ID%\colors\" /Q /I /Y /EXCLUDE:exclude.txt
xcopy "language" "BUILD\%ADDON_NAME_ID%\language" /E /Q /I /Y /EXCLUDE:exclude.txt

del exclude.txt

copy *.xml "BUILD\%ADDON_NAME_ID%\"
copy *.txt "BUILD\%ADDON_NAME_ID%\"

ECHO ----------------------------------------
ECHO Getting addon version...
FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -NoProfile -Command ^
    "[xml]$xml = Get-Content 'addon.xml'; $xml.addon.version"`) DO (
    SET "VERSION=%%F"
)

ECHO ----------------------------------------
ECHO Compressing addon...
cd BUILD
7z a -tzip "%ADDON_NAME_ID%-%VERSION%.zip" "%ADDON_NAME_ID%\*"
move "%ADDON_NAME_ID%-%VERSION%.zip" "..\"
