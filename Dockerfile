
FROM ubuntu:latest

MAINTAINER Tobias Gurtzick <magic@wizardtales.com>

RUN apt-get update && apt-get install -y curl wget apt-transport-https \
      && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get update \
      && apt-get install -y yarn build-essential git unzip python && apt-get dist-upgrade -y \
      && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN adduser --disabled-password --gecos "" cirunner
WORKDIR /home/cirunner
USER cirunner

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
ADD runner_bash /home/cirunner/.runner_bash
ENV BASH_ENV ~/.runner_bash
ENV NPM_CONFIG_LOGLEVEL info
