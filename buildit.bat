rem @echo off
set DEFHOMEDRIVE=d:
set DEFHOMEDIR=%DEFHOMEDRIVE%%HOMEPATH%
set HOMEDIR=
set HOMEDRIVE=%CD:~0,2%

set RELEASEDIR=d:\Users\jbb\release
set ZIP="c:\Program Files\7-zip\7z.exe"
echo Default homedir: %DEFHOMEDIR%

set /p HOMEDIR= "Enter Home directory, or <CR> for default: "

if "%HOMEDIR%" == "" (
set HOMEDIR=%DEFHOMEDIR%
)
echo %HOMEDIR%

SET _test=%HOMEDIR:~1,1%
if "%_test%" == ":" (
set HOMEDRIVE=%HOMEDIR:~0,2%
)



type KWRocketry\GameData\KWRocketry\KWRocketryRedux.version
set /p VERSION= "Enter version: "


set FILE="%RELEASEDIR%\KWRocketryRedux-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% KWRocketry

rem Now create an install directory which also contains a default config
mkdir aa
mkdir aa\KWRocketry
xcopy /E KWRocketry aa\KWRocketry

rem Copy the GraduatedPowerResponse
xcopy /E KWRocketry\Extras\GraduatedPowerResponseConfigs\GameData\KWRocketry aa\KWRocketry\GameData\KWRocketry
cd aa

set FILE="%RELEASEDIR%\KWRocketryRedux-MANUAL-%VERSION%.zip"
IF EXIST %FILE% del /F %FILE%
%ZIP% a -tzip %FILE% KWRocketry

cd ..
rmdir /s aa
