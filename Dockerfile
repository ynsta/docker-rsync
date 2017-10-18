# Run with:
# docker run -d -it --name=rsync \
#   -p 4222:22 \
#   -v rsync-vol:/etc/ssh \
#   -v <my data path>:/srv/rsync \
#   -e PUID=<UID of data in my data path volume> \
#   -e PGID=<GID of data in my data path volume> \
#   ynsta/rsync

# ENVironnement variables:
#
# PUID       = User ID of data in the /srv/ftp volume
# GUID       = Group ID of data in the /srv/ftp volume


FROM debian:stable-slim

LABEL maintainer="Stany MARCEL <stanypub@gmail.com>"
LABEL version="0.1"
LABEL description="rsync over ssh server Debian based image"

ENV LANG=C.UTF-8 \
    PUID=1000 \
    PGID=1000 \
    AUTHORIZED_KEYS=""

# Update and intall required packages
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --fix-missing rsync openssh-server

COPY sshd_config /etc/ssh/sshd_config
COPY run.sh /run.sh
RUN chmod u+x /run.sh

RUN mkdir /run/sshd

VOLUME ["/srv/rsync", "/etc/ssh"]

CMD /run.sh

EXPOSE 22
