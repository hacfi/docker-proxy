#!/bin/sh

set -e

CONTAINER=$1

PROXY=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER`

sed -i "s/server .*/server $PROXY:80;/g" /etc/nginx/conf.d/proxy_upstream2.conf

nginx -s reload
