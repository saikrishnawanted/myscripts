#! /bin/bash

echo "$RANDOM"  # Supported in bash. No warnings.
#Cleanup output dir
rm -rf out
make mrproper
mkdir out

#export Sys-vars
export PATH="$HOME/android/proton/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/android/proton//lib:$LD_LIBRARY_PATH"
export ARCH=arm64
export SUBARCH=arm64
export AR=llvm-ar
export NM=llvm-nm
export OBJCOPY=llvm-objcopy
export OBJDUMP=llvm-objdump
export STRIP=llvm-strip
#export DTC_EXT=dtc

#Make config
make O=out ARCH=arm64 RMX1921_defconfig

#Build kernel
make -j10 O=out \
                      ARCH=arm64 \
                      CC="ccache $HOME/android/proton/bin/clang" \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi-
