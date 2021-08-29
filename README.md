# Debian pkgdevel

![build status](https://github.com/pgils/docker-debian-pkgdevel/actions/workflows/dockerbuild.yml/badge.svg)

Docker image with tools for developing and building debian packages.

## Usage

```
$ docker run -ti --rm -v $(pwd):/workdir \
    -e "DEBEMAIL=$(git config --get user.email)" \
    ghcr.io/pgils/debian-pkgdevel:bullseye
```
`uid` and `gid` of the `builder` user in the container are automatically updated to match the ownership of the `/workdir` directory.

### Package build example

```
$ apt-get source htop
$ cd htop-3.0.5/
$ sudo apt-get build-dep -y .
$ debuild -uc -us
```
