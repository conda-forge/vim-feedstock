nmake -f Make_mvc.mak GUI=yes IME=yes MBYTE=yes ICONV=yes DEBUG=no %SRC_DIR%\src
if errorlevel 1 exit 1
