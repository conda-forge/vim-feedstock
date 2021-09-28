cd %SRC_DIR%\\src
nmake -f Make_mvc.mak
if errorlevel 1 exit 1
copy vim.exe %LIBRARY_BIN%
if errorlevel 1 exit 1

