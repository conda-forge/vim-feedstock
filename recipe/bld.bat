echo on

:: Build

cd %SRC_DIR%\\src
nmake -f Make_mvc.mak ^
		GUI=no OLE=no DIRECTX=no ^
		FEATURES=HUGE IME=yes MBYTE=yes ICONV=yes DEBUG=no ^
		TERMINAL=yes ^
if errorlevel 1 exit 1


:: Test

cd %SRC_DIR%\\src\\testdir
nmake -f Make_dos.mak VIMPROG=..\vim || exit 1

:: Install
copy vim.exe %LIBRARY_BIN%
if errorlevel 1 exit 1

