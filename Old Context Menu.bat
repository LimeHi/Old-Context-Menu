@echo off
setlocal enableextensions enableddelayeplexpansion

:: Clear screen before running
cls

:: Interface for choosing actions
echo Choose your action:
echo.
echo 1. Enable Old Context Menu (Windows 10 style).
echo 2. Restore Modern Context Menu (Windows 11 default).
echo.
choice /C 12 /N /M "Your choice: "

:: Process selected option
if "%ERRORLEVEL%"=="1" goto enable_classic
if "%ERRORLEVEL%"=="2" goto restore_modern

goto :EOF

:: Enables Classic Style Context Menu
:enable_classic
reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /v "" /t REG_SZ /d "" /f
echo Old context menu has been set successfully!
goto restart_explorer

:: Restores Modern Style Context Menu
:restore_modern
reg delete HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /va /f
echo Modern context menu restored successfully!
goto restart_explorer

:: Restarting Explorer process to apply changes immediately
:restart_explorer
taskkill /F /IM explorer.exe && start explorer.exe
echo Explorer has been restarted. Changes applied.
pause
exit