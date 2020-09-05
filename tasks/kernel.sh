#!/bin/bash
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2020 Saurabh Charde <saurabhchardereal@gmail.com>
#

# set compiler paths
COMPILER_PATH="$HOME/compiler"
CLANG_PATH="$COMPILER_PATH/clang/clang-r370808/bin"
GCC_PATH="$COMPILER_PATH/gcc/bin"
GCC_32_PATH="$COMPILER_PATH/gcc32/bin"

# Kernel specific
DEFCONFIG="X00T_defconfig"
ANYKERNEL=flasher/anykernel
ZIMAGE=out/arch/arm64/boot/Image.gz-dtb
KERNEL_NAME="ARAGOTO"
ZIP_NAME="${KERNEL_NAME}-$(date +"%d%m%Y")-$(date +%H:%M).zip"

export KBUILD_BUILD_USER="SaurabhCharde"
export KBUILD_BUILD_HOST="ProjectWeeb"

# Colors
NOR='\033[0m'
RED='\033[0;31m'
LGR='\033[1;32m'
YEL='\033[1;33m'
BLU='\033[1;34m'

# Clone compilers if does not exist
[[ ! -d $CLANG_PATH ]] && \
git clone --depth=1 https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86 -b master $COMPILER_PATH/clang

[[ ! -d $GCC_PATH ]] && \
git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-10.0.0_r40 $COMPILER_PATH/gcc

[[ ! -d $GCC_32_PATH ]] && \
git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b android-10.0.0_r40 $COMPILER_PATH/gcc32

[[ ! -d $ANYKERNEL ]] && \
git clone https://github.com/saurabhchardereal/AnyKernel3 -b ARAGOTO $ANYKERNEL

# arguments
ARGS+="-j$(nproc --all) O=out \
	ARCH=arm64 \
	CC=$CLANG_PATH/clang \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=$GCC_PATH/aarch64-linux-android- \
	CROSS_COMPILE_ARM32=$GCC_32_PATH/arm-linux-androideabi- "

# functions
makeClean(){
echo -e $LGR "===========================================" $NOR
echo -e $LGR "               Making Clean...             " $NOR
echo -e $LGR "===========================================" $NOR
    make $ARGS clean
    make $ARGS mrproper
echo -e $BLU "Cleaned!" $NOR
}

makeDefconfig(){
echo -e $LGR "===========================================" $NOR
echo -e $LGR "          Renegrating defconfig...         " $NOR
echo -e $LGR "===========================================" $NOR
    make $ARGS $DEFCONFIG
    mv out/.config arch/arm64/configs/X00T_defconfig
echo -e $BLU "Renerating defconfig done!" $NOR
}

makeKernel(){
echo -e $LGR "===========================================" $NOR
echo -e $LGR "             Building Kernel...            " $NOR
echo -e $LGR "===========================================" $NOR
    make $ARGS $DEFCONFIG
    make $ARGS
echo -e $BLU "Kernel image built!" $NOR
}

makeZip(){
# Fail build if previous command isn't a success
if [ $? -ne 0 ]; then
    echo -e $RED "Build Failed!" $NOR
else
    echo -e $LGR "===========================================" $NOR
    echo -e $LGR "            Making Flashable Zip...        " $NOR
    echo -e $LGR "===========================================" $NOR

    cp -f $ZIMAGE $ANYKERNEL
    cd $ANYKERNEL
    find . -name "*.zip" -type f -delete
    zip -r $ZIP_NAME *
fi
    DURATION=$(($END - $START))
    echo -e $YEL "Build completed in $(($DURATION/60)) mins and $(($DURATION % 60)) secs" $NOR
}

# add built parameters
while ((${#})); do
    case ${1} in
        -r | --regendef)
		makeDefconfig;
		;;

        -c | --clean)
		makeClean;
		;;
    esac
shift
done

# Build kernel
START=$(date +"%s")
makeKernel
END=$(date +"%s")
makeZip
