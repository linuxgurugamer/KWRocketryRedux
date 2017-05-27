 @echo off

set RELEASEDIR=d:\Users\jbb\release
set ZIP="c:\Program Files\7-zip\7z.exe"



copy KWRocketry\GameData\KWRocketry\KWRocketryRedux.version a.version
set VERSIONFILE=a.version
rem set /p VERSION= "Enter version: "

rem The following requires the JQ program, available here: https://stedolan.github.io/jq/download/
c:\local\jq-win64  ".VERSION.MAJOR" %VERSIONFILE% >tmpfile
set /P major=<tmpfile

c:\local\jq-win64  ".VERSION.MINOR"  %VERSIONFILE% >tmpfile
set /P minor=<tmpfile

c:\local\jq-win64  ".VERSION.PATCH"  %VERSIONFILE% >tmpfile
set /P patch=<tmpfile

c:\local\jq-win64  ".VERSION.BUILD"  %VERSIONFILE% >tmpfile
set /P build=<tmpfile
del tmpfile
set VERSION=%major%.%minor%.%patch%
if "%build%" NEQ "0"  set VERSION=%VERSION%.%build%

echo %VERSION%
del a.version


copy "KW Redux Install For Dummies.docx" KWRocketry
copy "KW Redux Install For Dummies.pdf" KWRocketry

set FILE="%RELEASEDIR%\KWRocketryRedux-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% KWRocketry

del "KWRocketry\KW Redux Install For Dummies.docx"
del "KWRocketry\KW Redux Install For Dummies.pdf"

rem Now create an install directory which also contains a default config
mkdir aa
mkdir aa\KWRocketry
xcopy /E KWRocketry aa\KWRocketry


rem Copy the GraduatedPowerResponse
xcopy /E KWRocketry\Extras\GraduatedPowerResponseConfigs\GameData\KWRocketry aa\KWRocketry\GameData\KWRocketry
copy "KW Redux Install For Dummies Manual Install.docx" aa\KWRocketry
copy "KW Redux Install For Dummies Manual Install.pdf" aa\KWRocketry
cd aa

set FILE="%RELEASEDIR%\KWRocketryRedux-StandardInstall-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% KWRocketry

cd ..
rmdir /q/s aa
