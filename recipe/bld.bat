:: Based on https://github.com/vim/vim-win32-installer/blob/master/appveyor.bat

echo on

:: Build
set INCLUDE=%PREFIX%\\include;%INCLUDE%

:: Unset %PYTHON% so that vim's build system does not think we want Python2 support
set PYTHON=

:: Remove dot from PY_VER for PYTHON3_VER
set PYTHON3_VER=%PY_VER:.=%

set PERL=
set PERL_VER=526

set

cd %SRC_DIR%\\src
nmake -f Make_mvc.mak ^
		GUI=no OLE=no DIRECTX=no ^
		FEATURES=HUGE IME=yes MBYTE=yes ICONV=yes DEBUG=no ^
		TERMINAL=yes ^
		DYNAMIC_PYTHON3=yes PYTHON3=%PREFIX% ^
		DYNAMIC_PERL=yes PERL=%PREFIX%

if errorlevel 1 exit 1


:: Test
cd %SRC_DIR%\\src\\testdir
nmake -f Make_dos.mak VIMPROG=..\vim


:: Install
cd %SRC_DIR%\\src\\
copy *.exe %LIBRARY_BIN%
copy xxd\\*.exe %LIBRARY_BIN%
copy tee\\*.exe %LIBRARY_BIN%

xcopy ..\\runtime %LIBRARY_BIN% /Y /E /V /I /H /R /Q
if errorlevel 1 exit 1

