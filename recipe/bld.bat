cd %SRC_DIR%\\src
nmake -f Make_mvc.mak GUI=no
nmake -f Make_mvc.mak GUI=yes
cp vim.exe %LIBRARY_BIN%
cp gvim.exe %LIBRARY_BIN%
if errorlevel 1 exit 1