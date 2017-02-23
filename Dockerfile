FROM phusion/baseimage:0.9.19
 
# Update Software repository
RUN apt-get update

# Install Build Tools
RUN apt-get install -y build-essential libssl-dev

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# Install MongoDB Phusion Daemon
RUN mkdir /etc/service/mongodb
ADD mongodb.sh /etc/service/mongodb/run

# Install NVM/Node/NPM/LocalCompile
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 7.5.0
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install node \
    && nvm use node \
    && npm install -g node-gyp
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

# Install Wiki.js
RUN mkdir -p /var/www/wiki
WORKDIR /var/www/wiki
RUN . $NVM_DIR/nvm.sh \
    && nvm use node \
    && npm install --verbose wiki.js@latest \
    && node wiki -V
    && node wiki start

# Install WikiJS Phusion Daemon
#RUN mkdir /etc/service/wikijs
#ADD wikijs.sh /etc/service/wikijs/run

EXPOSE 80

CMD ["/sbin/my_init"]
