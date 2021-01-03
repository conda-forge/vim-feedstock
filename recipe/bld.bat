cd %SRC_DIR%\\src
nmake -f Make_mvc.mak GUI=yes IME=yes MBYTE=yes ICONV=yes DEBUG=no PYTHON3=C:\Miniconda
if errorlevel 1 exit 1
