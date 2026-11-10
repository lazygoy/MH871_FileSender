@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -STA -File "%~dp0src\MH871-File-Sender.ps1"
if errorlevel 1 (
  echo.
  echo The MH-871 File Sender exited with an error.
  pause
)
endlocal
