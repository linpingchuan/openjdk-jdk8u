#!/bin/bash
compile_openjdk8u(){
    is_git_f=$1
    cd /home/lin/openjdk-jdk8u/
    if [ "$is_git_f" == "f" ];then
	    git pull -f
    fi

    cd /home/lin/openjdk-jdk8u/build/linux-x86_64-normal-server-slowdebug/jdk/bin
    has_directory=$?

    if [ "$has_directory" == "1" ];then
        export CXXFLAGS="-Wno-error"
        export CPPFLAGS="-Wno-error"
        export CFLAGS="-Wno-error"
        chuan apt-get install -y libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev
        chuan apt-get install ccache -y
        cd /home/lin/openjdk-jdk8u
        #chuan make dist-clean
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
    fi
    cd /home/lin/openjdk-jdk8u
    # 删除无用的日志
    rm hs_err_pid*.log

    chuan make hotspot-only CONF=linux-x86_64-normal-server-slowdebug ZIP_DEBUGINFO_FILES=0 ENABLE_FULL_DEBUG_SYMBOLS=1 LOG=debug JOBS=2

    export PATH=$PATH:/home/lin/openjdk-jdk8u/build/linux-x86_64-normal-server-slowdebug/jdk/bin/
}
compile_openjdk8u $*
