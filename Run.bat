@ECHO OFF
SETLOCAL
SET samples=Plane, SimpleTutorial, Stars, Terry, TileSheetLayer

FOR %%G IN (%samples%) DO (
	ECHO Running project: %%G
	lime test samples\%%G\application.xml flash
)
PAUSE