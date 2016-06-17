############################################################
# Minimum development environment for Ubuntu-15.04-x86_64
# === How to build the environment ===
# sudo docker build -f deepkh/ubuntu1404_dev_32:base -t my/ubuntu1404_dev_32:base .
# === How to run this docker from local ===
# sudo docker run -it -v /dev:/dev --privileged=true -v /home/build:/home/build my/ubuntu1404_dev_32:base /bin/bash
# === How to run this docker from docker hub ===
# sudo docker run -it -v /dev:/dev --privileged=true -v /home/build:/home/build deepkh/ubuntu1404_dev_32:base /bin/bash
############################################################
FROM m0elnx/ubuntu-32bit
MAINTAINER deepkh <deepkh@gmail.com>

################## BEGIN INSTALLATION ######################

RUN apt-get update
RUN apt-get install -y build-essential debian-archive-keyring gperf bison flex texinfo help2man gawk libtool automake libncurses5-dev vim python python2.7-dev bc curl cmake git wget xz-utils apt-transport-https ca-certificates --no-install-recommends

# add user 'build' with uid 9999 in docker without home
# also add 'build' on host and with home
# so we can bind the host's /home/build to docker's /home/build
RUN useradd -u 9999 build

# change root password to 1234
RUN echo "root:1234" | chpasswd

# change build password to 1234
RUN echo "build:1234" | chpasswd

# add build user to sudo file
RUN echo "build    ALL=(ALL:ALL) ALL" > /etc/sudoers

##################### INSTALLATION END #####################
USER build
WORKDIR /home/build
ENTRYPOINT /bin/bash

