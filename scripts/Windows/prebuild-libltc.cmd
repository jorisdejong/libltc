@echo off
setlocal

REM The first argument is the build configuration, e.g. Release or Debug
set CONFIGURATION=%1

REM Calculate the path to libltc.lib relative to this script location
REM Adjust this path if needed depending on where you put the batch file

set SCRIPT_DIR=%~dp0
set LIBLTC_BUILD=%SCRIPT_DIR%..\..\builds
set LIBLTC_LIB=%LIBLTC_BUILD%\%CONFIGURATION%\libltc.lib

REM Normalize path (remove trailing backslash if any)
if "%LIBLTC_BUILD:~-1%"=="\" set LIBLTC_BUILD=%LIBLTC_BUILD:~0,-1%

if not exist "%LIBLTC_LIB%" (
    echo libltc.lib not found, building libltc...
    if not exist "%LIBLTC_BUILD%" (
        mkdir "%LIBLTC_BUILD%"
    )
    pushd "%LIBLTC_BUILD%"
    cmake .. -G "Visual Studio 17 2022" -A x64
    cmake --build . --config %CONFIGURATION%
    popd
) else (
    echo libltc.lib already built, skipping build.
)

endlocal