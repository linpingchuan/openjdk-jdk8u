#!/bin/bash

compile_openjdk10(){
    sudo apt-get install -y libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev 
    sudo apt-get install ccache -y
    cd /home/lin/openjdk-jdk10
    current_directory=`pwd | grep -a 'jdk' | grep -a 'u'`
    if [ -n "$current_directory" ];then
        # 指定 bootjdk 为 openjdk10
        bash configure --with-debug-level=slowdebug --disable-warnings-as-errors \
            --enable-sjavac \
            --enable-ccache --with-native-debug-symbols=external \
            --with-boot-jdk=/home/lin/openjdk-jdk10/build/linux-x86_64-normal-server-slowdebug/jdk
    else
        bash configure --with-debug-level=slowdebug --disable-warnings-as-errors --enable-ccache --with-native-debug-symbols=external 
    fi
    sudo make clean CONF=linux-x86_64-normal-server-fastdebug
    sudo make clean CONF=linux-x86_64-normal-server-slowdebug

    make CONF=linux-x86_64-normal-server-slowdebug

    export PATH=$PATH:/home/lin/openjdk-jdk10/build/linux-x86_64-normal-server-slowdebug/jdk/bin
}

compile_openjdk11u(){
    sudo apt-get install -y libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev 
    sudo apt-get install ccache -y
    cd /home/lin/openjdk-jdk11u
    current_directory=`pwd | grep -a 'jdk' | grep -a 'u'`
    if [ -n "$current_directory" ];then
        # 指定 bootjdk 为 openjdk10
        bash configure --with-debug-level=slowdebug --disable-warnings-as-errors \
            --enable-sjavac \
            --enable-ccache --with-native-debug-symbols=external \
            --with-boot-jdk=/home/lin/openjdk-jdk10/build/linux-x86_64-normal-server-slowdebug/jdk
    else
        bash configure --with-debug-level=slowdebug --disable-warnings-as-errors --enable-ccache --with-native-debug-symbols=external 
    fi
    # sudo make clean CONF=linux-x86_64-normal-server-fastdebug
    # sudo make clean CONF=linux-x86_64-normal-server-slowdebug

    sudo make CONF=linux-x86_64-normal-server-slowdebug ZIP_DEBUGINFO_FILES=0 ENABLE_FULL_DEBUG_SYMBOLS=1 LOG=debug

    export PATH=$PATH:/home/lin/openjdk-jdk11u/build/linux-x86_64-normal-server-slowdebug/jdk/bin/
}
# 远程调试 https://www.cnblogs.com/jhxxb/p/11094578.html
compile_openjdk8u(){
    export CXXFLAGS="-Wno-error"
    export CPPFLAGS="-Wno-error"
    export CFLAGS="-Wno-error"
    sudo apt-get install -y libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev
    sudo apt-get install ccache -y
    cd /home/lin/openjdk-jdk8u
    #sudo make dist-clean
    current_directory=`pwd | grep -a 'jdk' | grep -a 'u'`
    if [ -n "$current_directory" ];then
        # 指定 bootjdk 为 openjdk8
        bash configure --with-debug-level=slowdebug \
	    --enable-sjavac \
	    --with-target-bits=64 \
            --enable-ccache 
    else
        bash configure --with-debug-level=slowdebug --disable-warnings-as-errors --enable-ccache --with-native-debug-symbols=external
    fi
    # sudo make clean CONF=linux-x86_64-normal-server-fastdebug
    # sudo make clean CONF=linux-x86_64-normal-server-slowdebug

    sudo make CONF=linux-x86_64-normal-server-slowdebug ZIP_DEBUGINFO_FILES=0 ENABLE_FULL_DEBUG_SYMBOLS=1 LOG=debug

    export PATH=$PATH:/home/lin/openjdk-jdk8u/build/linux-x86_64-normal-server-slowdebug/jdk/bin/
}
# compile_openjdk10
compile_openjdk8u
# compile_openjdk11u
