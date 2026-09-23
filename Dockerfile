FROM alpine:3.24.2@sha256:c54a80678a9e7a744b39d478329d5eb8e568c2e0321defd14cab57047557e202

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
