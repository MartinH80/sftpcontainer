FROM alpine:3.23.4@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

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
