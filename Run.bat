@ECHO OFF
SETLOCAL
SET samples=Imgui, Plane, SimpleTutorial, Stars, Terry, TileSheetLayer

ECHO Please choose your target, flash: 1, windows: 2, html5: 3
SET /p choice="Target: "

set app=
IF %choice% EQU 1 SET app=flash
IF %choice% EQU 2 SET app=windows
IF %choice% EQU 3 SET app=html5

FOR %%G IN (%samples%) DO (
	ECHO Building project %%G, target as %app% 
	lime test samples\%%G\application.xml %app%
)
PAUSE