@echo off
dir general /a:d
echo.
echo.
set /p directory="Write the folder name you want to compile:"


java -jar LayersBuilder.jar config.json General/%directory%/config.json
pause