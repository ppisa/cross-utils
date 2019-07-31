#!/bin/sh

QMAKE_WRAPPER_DIR="$(cd "$(dirname "$0")" ; pwd)"

export QT_SYSROOT=/srv/nfs/debian-armhf
export TARGET_ARCH=arm-linux-gnueabihf

# test by qmake-debian-armhf.sh -query
QMAKE_CC=$TARGET_ARCH-gcc
QMAKE_CXX=$TARGET_ARCH-g++
QMAKE_LINK=$TARGET_ARCH-g++

export QMAKE_XSPEC=$QT_SYSROOT/usr/lib/$TARGET_ARCH/qt5
export QMAKE_SPEC=linux-g++
export QMAKE_XSPEC=linux-g++
export QMAKE_CONF="$QMAKE_WRAPPER_DIR/$(basename "$0" .sh)"

mode_arg=""

case "$1" in
  -query)
    mode_arg="-query"
    shift 1
    ;;
  -makefile)
    mode_arg="-makefile"
    shift 1
    ;;
  -project)
    mode_arg="-project"
    shift 1
    ;;
esac


tools_args=" "
if [ -n "$QMAKE_CC" ] ; then
  tools_args="$tools_args QMAKE_CC=$QMAKE_CC"
fi
if [ -n "$QMAKE_CXX" ] ; then
  tools_args="$tools_args QMAKE_CXX=$QMAKE_CXX"
fi
if [ -n "$QMAKE_LINK" ] ; then
  tools_args="$tools_args QMAKE_LINK=$QMAKE_LINK"
fi
tools_args="$tools_args QMAKE_LFLAGS+=--sysroot=$QT_SYSROOT"
tools_args="$tools_args QMAKE_CFLAGS+=--sysroot=$QT_SYSROOT"
tools_args="$tools_args QMAKE_CXXFLAGS+=--sysroot=$QT_SYSROOT"

exec /usr/lib/qt5/bin/qmake $mode_arg -qtconf $QMAKE_CONF $tools_args "$@"

