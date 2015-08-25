@ECHO OFF
SETLOCAL
SET samples=Plane, SimpleTutorial, Stars, Terry, TileSheetLayer

FOR %%G IN (%samples%) DO lime test samples\%%G\application.xml flash
pause