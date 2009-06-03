#!/bin/sh

rackup -D -E none -p 9998 -o 127.0.0.1 -s thin -P /home/id-img/tmp/pids/id-img.pid
nginx -c /home/id-img/config/nginx.conf
