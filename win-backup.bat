@echo off
setlocal EnableExtensions DisableDelayedExpansion

set adb=".\adb-tools\platform-tools\adb.exe"

:: Check if we already have the ADB tools downloaded
if not exist %adb% (
  echo # ADB tools not found. Now downloading ADB tools...

  :: Download latest ADB tools from official repository
  powershell Invoke-WebRequest "https://dl.google.com/android/repository/platform-tools-latest-windows.zip" -OutFile .\adb-tools.zip

  :: Unzip the downloaded file
  powershell Expand-Archive .\adb-tools.zip .\adb-tools

  :: Delete zip
  del .\adb-tools.zip

  echo # ADB tools successfully downloaded!

) else (
  :: ADB tools present, proceed to 
  echo # ADB tools already present!
)

set regex='^.+\s(.+)$'
set /A counter=1

:: Go through the config file and read it line by line
for /f "tokens=*" %%l in (config.txt) do (
  echo %%l
  set line=%%l

  :: Find the destination folder in the line
  for /f "usebackq" %%f in (`powershell "'%%l' | Select-String -Pattern %regex% | %% {$_.matches.groups[1].value}"`) do set dir=%%f && call :processLine && set /A counter+=1
)

:: Exit program
goto :eof

:: Function to process each dir
:processLine
  :: Is the folder string non-empty?
  if not "%dir%" == "" (

    :: Check if the destination folder exists
    if not exist "%dir%" (
      :: If not, create it
      echo # Creating destination directory: %dir%
      mkdir "%dir%"
    )

    :: Finally pull the data from the source to destination
    echo # Starting back up %counter%: %line%...
    call %adb% pull %line%
    echo # Finished back up %counter%!
  )
exit /b 0
