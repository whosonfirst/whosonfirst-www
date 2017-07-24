#!/bin/sh

# for example:
#
# ./utils/mk-utils.sh go-whosonfirst-meta wof-build-metafiles
#
# and then in your Makefile:
#
# UNAME_S := $(shell uname -s)
#
# metatools:
#	./utils/mk-utils.sh go-whosonfirst-meta wof-build-metafiles
# 
# metafiles:
# ifeq ($(UNAME_S),Darwin)
#	utils/darwin/wof-build-metafiles
# else ifeq ($(UNAME_S),Linux)
#	utils/linux/wof-build-metafiles
# else ifeq ($(UNAME_S),Windows)
#	utils/windows/wof-build-metafiles
# else
#	echo "this OS is not supported yet"
#	exit 1
# endif

WHOAMI=`python -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`

if [ $? -ne 0 ]
then
    echo "[fatal] E_INSUFFICIENT_INTROSPECTION"
    exit 1
fi

UTILS=`dirname ${WHOAMI}`
ROOT=`dirname ${UTILS}`

REPO=$1
shift

TOOLS=$@

ARCHIVE="https://github.com/whosonfirst/${REPO}/archive/master.zip"
SOURCE="${REPO}-master"

GO=`which go`
CURL=`which curl`
UNZIP=`which unzip`

if [ ! -e ${GO} ]
then
    echo "You must have Go installed in order for this to work."
    exit 1
fi

cd ${ROOT}

if [ -e ${SOURCE}.zip ]
then
    rm ${SOURCE}.zip
fi

if [ -e ${SOURCE} ]
then
    rm -rf ${SOURCE}
fi

${CURL} -o ${ROOT}/${SOURCE}.zip -L ${ARCHIVE}

if [ $? -ne 0 ]
then
    echo "[fatal] failed to fetch source code for ${REPO} (${ARCHIVE})"
    exit 1
fi

${UNZIP} ${ROOT}/${SOURCE}.zip

if [ $? -ne 0 ]
then
    echo "[fatal] failed unzip source code for ${REPO}"
    exit 1
fi

cd ${ROOT}/${SOURCE}

for OS in darwin linux windows
do

    rm -rf bin/*

    # https://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5

    export GOOS=${OS}
    export GOARCH=386

    make bin

    if [ ! -d ${UTILS}/${OS} ]
    then
	mkdir -p ${UTILS}/${OS}
    fi

    for BINARY in ${TOOLS}
    do

	if [ ! -e bin/${BINARY} ]
	then
	    echo "Can't find ${BINARY} in bin directory!"
	    exit 1
	fi

	cp bin/${BINARY} ${UTILS}/${OS}/
    done

done

cd ${ROOT}

rm ${SOURCE}.zip
rm -rf ${SOURCE}

exit 0
