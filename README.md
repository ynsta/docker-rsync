# rsync over openssh server Debian based image

- DockerHub : https://hub.docker.com/r/ynsta/rsync
- GitHub : https://github.com/ynsta/docker-rsync

## Usage

### Build

```shell
git clone https://github.com/ynsta/docker-rsync.git
cd docker-rsync
docker build . -t rsync
```

### Run

Run with:

```shell
docker run -d -it --name=rsync \
  -p 4222:22 \
  -v rsync-vol:/etc/ssh \
  -v <my data path>:/srv/rsync \
  -e PUID=<UID of data in my data path volume> \
  -e PGID=<GID of data in my data path volume> \
  ynsta/rsync
```

### Environnement variables

- PUID:\
  User ID of data in the /srv/ftp volume
- GUID:\
  Group ID of data in the /srv/ftp volume
- AUTHORIZED_KEYS:\
  Authorized SSH keys for rsync user
