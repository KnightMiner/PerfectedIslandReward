@echo off

IF EXIST build RMDIR /q /s build
IF EXIST "PerfectedIslandReward-#.#.#.zip" DEL "PerfectedIslandReward-#.#.#.zip"
MKDIR build
MKDIR build\PerfectedIslandReward

REM Copy required files into build directory
XCOPY img build\PerfectedIslandReward\img /s /e /i
XCOPY scripts build\PerfectedIslandReward\scripts /s /e /i

REM Zipping contents
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('build', 'PerfectedIslandReward-#.#.#.zip'); }"

REM Removing build directory
RMDIR /q /s build
