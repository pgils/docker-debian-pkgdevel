# Debian pkgdevel

![build status](https://github.com/pgils/docker-debian-pkgdevel/actions/workflows/dockerbuild.yml/badge.svg)

Docker image with tools for developing and building debian packages.

## Usage
### Starting the container

```
$ docker run -ti --rm -v $(pwd):/workdir \
    -e "DEBEMAIL=$(git config --get user.email)" \
    ghcr.io/pgils/debian-pkgdevel:bullseye
```
- `uid` and `gid` of the `builder` user in the container are automatically updated to match the ownership of the `/workdir` directory.
- `DEBEMAIL` should be set if you are editing Changelogs

### (Re)building package from source repositories

```
$ apt-get source htop
$ cd htop-3.0.5/
$ sudo apt-get build-dep -y .
$ debuild -uc -us
```

### Building custom packages with `buildpkgs`

`buildpkgs` is a helper script to automate building custom packages. It can fetch sources based on a `pkg.conf` file. See [example-package/hello-world](example-package/hello-world) for an example.

Example building `hello-world`:

```
$ buildpkgs -p example-package -o output build
```

This will produce packages, sources, and repository index files in `output/`:

```
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

#### `buildpkgs` usage

```
usage: buildpkgs [-poqh] <command> [<package>]

-p, --packages-dir  Path to packages to build
-o, --output        Path to output built packages to
-q, --quiet         Do not output to stdout
-h, --help          Print this help and exit

command             Command to run. One of:

    source          Fetch sources for <package>
    build           Build package(s)

package             Package in <packages-dir> to run
                    <command> for
```
