# Debian pkgdevel

![build status](https://github.com/pgils/docker-debian-pkgdevel/actions/workflows/dockerbuild.yml/badge.svg)

Docker image with tools for developing and building debian packages.

## Usage

### Starting the container

```cli
> docker run -ti --rm -v $(pwd):/workdir \
    -e "DEBEMAIL=$(git config --get user.email)" \
    ghcr.io/pgils/debian-pkgdevel:bullseye
```

- `uid` and `gid` of the `builder` user in the container are automatically updated to match the ownership of the `/workdir` directory.
- `DEBEMAIL` should be set if you are editing Changelogs

### (Re)building package from source repositories

```cli
> apt-get source htop
> cd htop-3.0.5/
> sudo apt-get build-dep -y .
> debuild -uc -us
```

### Building custom packages with `makepkg`

`makepkg` is a helper script to automate building custom packages. It can fetch sources based on a `pkg.conf` file. See [example-package/hello-world](example-package/hello-world) for an example.

Example building `hello-world`:

```cli
> cd example-package/hello-world
> makepkg
```

#### `makepkg` usage

```cli
❯ ./makepkg -h

  usage: makepkg [-sqh]

    -s, --source        Only fetch sources and exit
    -q, --quiet         Do not output to stdout
    -h, --help          Print this help and exit
```

### Generating repositories with `makerepo`

> This example uses the output from [`hello-world`](#building-custom-packages-with-makepkg)

`makerepo` searches for `.deb` files recursively, so these files need to be in a path below `pwd`.

```cli
> makerepo output
```

This will produce packages, sources, and repository index files in `output/`:

```cli
output
├── packages
│   ├── hello-world_0.0.1-1_arm64.deb
│   └── Packages.gz
└── sources
    ├── hello-world_0.0.1-1.debian.tar.xz
    ├── hello-world_0.0.1-1.dsc
    ├── hello-world_0.0.1.orig.tar.gz
    └── Sources.gz
```

> note that packages are **not signed**.

#### `makerepo` usage

```cli
❯ ./makerepo -h

  usage: makerepo [-qh] OUTPUT_DIR

    -q, --quiet         Do not output to stdout
    -h, --help          Print this help and exit
```
