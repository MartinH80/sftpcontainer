FROM alpine:3.21.0@sha256:fcc4c908760c4f561a5199f2e53576063b1b8eeaa0c41e6432d705aab4389753

MAINTAINER MartinHerrman martin@herrman.nl

WORKDIR /

# update
RUN apk update
RUN apk upgrade

# install openssh-server
RUN apk add openssh-server
RUN apk add openssh-sftp-server

# make directory to expose user folders
RUN mkdir /data

# copy startup script
ADD startup.sh /startup.sh

# Execute startup script
CMD ["/bin/sh","-c","/startup.sh"]
