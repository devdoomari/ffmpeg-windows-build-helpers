#!/bin/bash
# based on the script install-ffmpeg from svnpenn/a/install-ffmpeg.sh (givin' credit where it's due :)
# uses an (assumed installed via package) cross compiler to compile ffmpeg with fdk-aac

set -x

host=i686-w64-mingw32

rootDir=$(pwd)/dist/win32
prefix=$rootDir/install_root
export PKG_CONFIG_PATH="$prefix/lib/pkgconfig" # let ffmpeg find our dependencies [currently not working :| ]

mkdir -p $prefix

cd $rootDir

rm -rf ffmpeg.tmp.git
git clone --depth 1 https://github.com/FFmpeg/FFmpeg.git ffmpeg.tmp.git

cd ffmpeg.tmp.git
./configure \
  --arch=x86 --target-os=mingw32 \
  --cross-prefix=$host- --pkg-config=pkg-config --prefix=$rootDir
  rm **/*.a # attempt force a rebuild...
  make -j5 install && echo "created runnable ffmpeg.exe in $rootDir/bin/ffmpeg.exe!"

# cd ..
