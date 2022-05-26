#!/bin/bash

set -ex

# For some reason vim doesn't use standard CFLAGS for OSDEF
# https://github.com/vim/vim/blob/5fd0f5052f9a312bb4cfe7b4176b1211d45127ee/src/Makefile#L1478
export EXTRA_IPATHS="-I$PREFIX/include"

# unset 'PERL' so that vim's configure doesn't use /usr/bin/perl
# cf. https://github.com/vim/vim/blob/7b5f45be2197403d631b5a3d633f6a20afdf806e/src/auto/configure#L6215
unset PERL

if [ "$PY3K" -eq "1" ]; then
  PYTHONINTERP="--enable-pythoninterp=no --enable-python3interp=yes"
else
  PYTHONINTERP="--enable-pythoninterp=yes --enable-python3interp=no"
fi

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" && "${target_platform}" == "osx-arm64" ]]; then
  # Need to set these explicitly for osx-arm64 since they can't be checked
  # automatically when cross-compiling.
  export vim_cv_toupper_broken=no
  export vim_cv_terminfo=yes
  export vim_cv_tgetent=non-zero
  export vim_cv_getcwd_broken=no
  export vim_cv_stat_ignores_slash=no
  export vim_cv_memmove_handles_overlap=yes
  export TERM_LIB='--with-tlib=ncurses -ltinfo'
fi


./configure --prefix=$PREFIX    \
            --without-x         \
            --without-gnome     \
            --without-tclsh     \
            --without-local-dir \
            --enable-gui=no     \
            --enable-cscope     \
            $PYTHONINTERP       \
             --enable-perlinterp=yes \
            "$TERM_LIB" || { cat src/auto/config.log; exit 1; }

make -j$CPU_COUNT
make install
