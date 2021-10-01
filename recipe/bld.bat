echo on

:: Build
set INCLUDE=%PREFIX%\\include;%INCLUDE%

:: Unset %PYTHON% so that the build does not think we want Python2 support
set PYTHON=

set PYTHON3_VER=%PYTHON3_VER

set

cd %SRC_DIR%\\src
nmake -f Make_mvc.mak ^
		GUI=no OLE=no DIRECTX=no ^
		FEATURES=HUGE IME=yes MBYTE=yes ICONV=yes DEBUG=no ^
		TERMINAL=yes ^
		DYNAMIC_PYTHON3=yes PYTHON3=%PREFIX%

if errorlevel 1 exit 1


:: Test
cd %SRC_DIR%\\src\\testdir
nmake -f Make_dos.mak VIMPROG=..\vim


:: Install
cd %SRC_DIR%\\src\\
copy vim.exe %LIBRARY_BIN%

xcopy ..\\runtime %LIBRARY_BIN% /Y /E /V /I /H /R /Q
if errorlevel 1 exit 1

