@echo off
powershell.exe -NoLogo -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0install.ps1"
exit /b %errorlevel%
