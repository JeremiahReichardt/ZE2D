@ECHO OFF
SETLOCAL
SET samples=Plane, Stars, Terry, TileSheetLayer

FOR %%G IN (%samples%) DO openfl test samples\%%G\application.xml flash
pause