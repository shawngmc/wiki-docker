#!/bin/sh
cd /var/html/wiki/
exec /sbin/setuser wikijs node wiki start
