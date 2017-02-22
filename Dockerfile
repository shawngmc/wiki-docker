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
ADD mongodb.yml /etc/service/monogodb/mongodb.yml

# Install Node.js
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
RUN export NVM_DIR="$HOME/nvm"
RUN nvm install node
RUN nvm use node
RUN npm install -g node-gyp

# Install Wiki.js
RUN mkdir /var/www/wiki
WORKDIR /var/www/wiki
RUN npm install wiki.js@latest

# Install WikiJS Phusion Daemon
RUN mkdir /etc/service/wikijs
ADD wikijs.sh /etc/service/wikijs/run

EXPOSE 80

CMD ["/sbin/my_init"]
