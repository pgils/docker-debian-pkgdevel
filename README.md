# Debian pkgdevel

Docker image with tools for developing and building debian packages.

## Usage
```
$ docker run -ti --rm -v $(pwd):/workdir \
    -e "DEBEMAIL=$(git config --get user.email)" \
    ghcr.io/pgils/debian-pkgdevel:bullseye
```
```
$ apt-get source htop
$ cd htop-3.0.5/
$ sudo apt-get build-dep -y .
# debuild -uc -us
```
