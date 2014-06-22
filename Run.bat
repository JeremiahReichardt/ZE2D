@ECHO OFF
SETLOCAL
SET samples=Stars, Terry, TileSheetLayer

FOR %%G IN (%samples%) DO openfl test samples\%%G\application.xml flash
pause