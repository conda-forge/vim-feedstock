cd %SRC_DIR%\\src
nmake -f Make_mvc.mak GUI=no
nmake -f Make_mvc.mak GUI=yes
if errorlevel 1 exit 1
.\install.exe