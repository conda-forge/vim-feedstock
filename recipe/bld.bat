cd %SRC_DIR%\\src
nmake -f Make_mvc.mak GUI=no IME=yes MBYTE=yes ICONV=yes DEBUG=no
nmake -f Make_mvc.mak GUI=yes IME=yes MBYTE=yes ICONV=yes DEBUG=no
if errorlevel 1 exit 1