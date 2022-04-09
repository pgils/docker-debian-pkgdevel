ARG DEBIAN_RELEASE=bullseye

FROM debian:${DEBIAN_RELEASE}
ARG DEBIAN_RELEASE

# hadolint ignore=DL3008
RUN echo "deb-src http://deb.debian.org/debian ${DEBIAN_RELEASE} main" \
    > /etc/apt/sources.list.d/main-src.list \
    \
    && apt-get update && apt-get install -qqy --no-install-recommends \
    build-essential dpkg-dev fakeroot devscripts equivs lintian quilt \
    curl vim sudo "bsdtar|libarchive-tools" \
    && rm -rf /var/lib/apt/lists/* \
    \
    && useradd -m -s /bin/bash builder \
    && echo 'builder ALL=(ALL) NOPASSWD:/usr/bin/apt-get' >> /etc/sudoers \
    && echo 'PS1="\W> "' >> /home/builder/.bashrc


COPY entrypoint.sh /
COPY makepkg makerepo updpkgsum /usr/local/bin/
COPY --chown=builder quiltrc /home/builder/.quiltrc

VOLUME [ "/workdir" ]
WORKDIR /workdir

ENTRYPOINT ["/entrypoint.sh"]
