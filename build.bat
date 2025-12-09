@echo off
ECHO ----------------------------------------
echo Creating Confluence Build Folder
IF EXIST BUILD rmdir BUILD /S /Q
md BUILD

Echo .svn>exclude.txt
Echo .git>exclude.txt
Echo Thumbs.db>>exclude.txt
Echo Desktop.ini>>exclude.txt
Echo dsstdfx.bin>>exclude.txt
Echo exclude.txt>>exclude.txt

ECHO ----------------------------------------
ECHO Creating XPR File...
START /B /WAIT ..\..\Tools\XBMCTex\dist\XBMCTex -input media -output media -noprotect

ECHO ----------------------------------------
ECHO Copying XPR File...
xcopy "media\Textures.xpr" "BUILD\skin.confluence\media\" /Q /I /Y

ECHO ----------------------------------------
ECHO Cleaning Up...
del "media\Textures.xpr"

ECHO ----------------------------------------
ECHO XPR Texture Files Created...
ECHO Building Skin Directory...
xcopy "fonts" "BUILD\skin.confluence\fonts" /E /Q /I /Y /EXCLUDE:exclude.txt
xcopy "backgrounds" "BUILD\skin.confluence\backgrounds" /E /Q /I /Y /EXCLUDE:exclude.txt
xcopy "resources" "BUILD\skin.confluence\resources" /E /Q /I /Y /EXCLUDE:exclude.txt
xcopy "720p\*.*" "BUILD\skin.confluence\720p\" /Q /I /Y /EXCLUDE:exclude.txt
xcopy "colors\*.*" "BUILD\skin.confluence\colors\" /Q /I /Y /EXCLUDE:exclude.txt
xcopy "language" "BUILD\skin.confluence\language" /E /Q /I /Y /EXCLUDE:exclude.txt

del exclude.txt

copy *.xml "BUILD\skin.confluence\"
copy *.txt "BUILD\skin.confluence\"
