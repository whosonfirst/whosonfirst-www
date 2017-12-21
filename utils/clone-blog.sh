#!/bin/sh
# -*-shell-*-

WHOAMI=`python -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`

if [ $? -ne 0 ]
then
    echo "[fatal] E_INSUFFICIENT_INTROSPECTION"
    exit 1
fi

UTILS=`dirname ${WHOAMI}`
ROOT=`dirname ${UTILS}`

WWW="${ROOT}/www"
THEORY="${WWW}/theory"
BLOG="${WWW}/blog"

# pup is https://github.com/ericchiang/pup

PUP="${UTILS}/darwin/pup"	# PLEASE FIX ME TO CHECK OS...

for URL in `cat ${BLOG}/index.html | ${PUP} '.blog-post attr{href}' | grep -v .pdf`
do

    FNAME=`basename ${URL}`
    POST="${BLOG}/${FNAME}"

    echo "FETCH ${POST} AS ${FNAME}"
    
    if [ ! -d ${POST} ]
    then
	mkdir -p ${POST}
    fi

    # fetch the post

    if [ ! -e ${POST}/index.html ]
    then
	echo "FETCH ${URL}"
	curl -s -L ${URL} | ${PUP} '#content' > ${POST}/index.html
    fi

    # fetch the images

    for IMG in `cat ${POST}/index.html | ${PUP} "img attr{src}" | grep mapzen-assets.s3.amazonaws.com`
    do

	if [ ! -d ${POST}/images ]
	then
	    mkdir -p ${POST}/images
	fi

	I_FNAME=`basename ${IMG}`

	if [ ! -e ${POST}/images/${I_FNAME} ]
	then
	    echo "FETCH ${IMG}"
	    curl -s -o ${POST}/images/${I_FNAME} ${IMG}
	fi

    done

    perl -p -i -e "s/https\:\/\/mapzen-assets\.s3\.amazonaws\.com\/images\/${FNAME}\//images\//g" ${POST}/index.html

done
