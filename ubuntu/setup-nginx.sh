#!/bin/sh

WHOAMI=`python -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`

UBUNTU=`dirname $WHOAMI`
PROJECT=`dirname $UBUNTU`

PROJECT_NAME=`basename ${PROJECT}`

sudo apt-get update
sudo apt-get install -y nginx

NGINX="${PROJECT}/nginx"
CONF="${NGINX}/${PROJECT_NAME}"

if [ ! -f ${CONF}.example ]
then
    echo "missing example ${CONF}"
    exit 1
fi

if [ -f ${CONF} ]
then
    cp ${CONF} ${CONF}.bak
fi

cp ${CONF}.example ${CONF}

perl -p -i -e "s!__PROJECT_ROOT__!${PROJECT}!" ${CONF}
perl -p -i -e "s!__PROJECT_NAME__!${PROJECT_NAME}!" ${CONF}

if [ -L /etc/nginx/sites-enabled/default ]
then
    sudo rm /etc/nginx/sites-enabled/default
fi

if [ -L /etc/nginx/sites-enabled/${PROJECT_NAME} ]
then
    sudo rm /etc/nginx/sites-enabled/${PROJECT_NAME}
fi

sudo ln -s ${CONF} /etc/nginx/sites-enabled/${PROJECT_NAME}

sudo /etc/init.d/nginx restart

exit 0
