#!/bin/sh
cd /var/www/wiki/
exec /sbin/setuser wikijs node wiki start
