# For some reason vim doesn't use standard CFLAGS for OSDEF
# https://github.com/vim/vim/blob/5fd0f5052f9a312bb4cfe7b4176b1211d45127ee/src/Makefile#L1478
export EXTRA_IPATHS="-I$PREFIX/include"

if [ "$PY3K" -eq "1" ]; then
  PYTHONINTERP="--enable-pythoninterp=no --enable-python3interp=yes"
else
  PYTHONINTERP="--enable-pythoninterp=yes --enable-python3interp=no"
fi

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" && "${target_platform}" == "osx-arm64" ]]; then
  export vim_cv_toupper_broken=yes
  export TERM_LIB="-lncurses -ltinfo"
fi


./configure --prefix=$PREFIX    \
            --without-x         \
            --without-gnome     \
            --without-tclsh     \
            --without-local-dir \
            --enable-gui=no     \
            --enable-cscope     \
            $PYTHONINTERP       \
            $TERM_LIB || { cat src/auto/config.log; exit 1; }

make -j$CPU_COUNT
make install
