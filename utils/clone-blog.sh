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

for URL in `cat ${THEORY}/index.html | ${PUP} '.wof-blog-post attr{href}' | grep -v .pdf`
do
    
    FNAME=`basename ${URL}`
    POST="${BLOG}/${FNAME}"

    if [ -e ${POST}/index.html ]
    then
	echo "SKIP ${URL}"	
	continue
    fi
    
    if [ ! -d ${POST} ]
    then
	mkdir -p ${POST}
    fi

    echo "FETCH ${URL}"
    curl -s -L ${URL} | ${PUP} '#content' > ${POST}/index.html 

    # TO DO:
    # - fetch images
    # - rewrite post body to reference local images?
    
done
