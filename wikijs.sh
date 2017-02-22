#!/bin/sh 
. $NVM_DIR/nvm.sh
nvm install node
nvm use node
cd /var/www/wiki/
exec node wiki start
