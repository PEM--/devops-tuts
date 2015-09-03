#!/bin/bash
if [ ! -f /etc/nginx/conf/servername.conf ]
then
  ln -s /etc/nginx/conf/servername-$HOST_TARGET.conf /etc/nginx/conf/servername.conf
fi
nginx -g "daemon off;"
