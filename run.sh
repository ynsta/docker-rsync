#!/bin/bash

mkdir -p /srv/rsync

# Delete rsync user if already created
getent passwd rsync &>/dev/null && userdel -rf rsync &> /dev/null

# Create the rsync group and user with wanted UID and GID
groupadd --gid $PGID rsync
useradd  --uid $PUID --gid $PGID --create-home -d /home/rsync -s /bin/bash rsync
usermod -p '*' rsync
chown rsync:rsync /home/rsync
chown rsync:rsync /srv/rsync

mkdir -p /home/rsync/.ssh
echo "${AUTHORIZED_KEYS}" > /home/rsync/.ssh/authorized_keys
chmod 700 /home/rsync/.ssh
chmod 600 /home/rsync/.ssh/authorized_keys
chown -R rsync:rsync /home/rsync/.ssh

# Finally run sshd
/usr/sbin/sshd -D -f /etc/ssh/sshd_config
