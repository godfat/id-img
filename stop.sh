#!/bin/sh

kill `cat /home/id-img/tmp/pids/nginx.pid`
kill `cat /home/id-img/tmp/pids/id-img.pid`
