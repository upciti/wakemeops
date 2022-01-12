## Getting started

### Add repository

Our repository is currently split into four components, __devops__, __dev__, __secops__, and __terminal__.

=== "Install all four components :rocket:"
    ```shell
    curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash
    ```

=== "Install __terminal__ goodies only :cry:"

    ```shell
    curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash -s terminal
    ```

??? abstract title "See script content[^1]"
    ```shell title="install_repository"
    --8<-- "assets/install_repository"
    ```

Once the repository is added to your system, update APT cache with:

```shell
sudo apt-get update
```

### Install packages

**You're good to go, the list of packages available on wakemeops is [here](/components/dev).**

To get you started, here are a few terminal goodies that you will probably enjoy:

```shell
sudo apt install bat fd dust exa gping
```


## Basic usage

### Repository priority

Dependending on your use case, you may want to lower the priority of the wakemeops repository
to give packages from your distribution precedence over the ones from wakemeops. In other words,
APT will always prefer a package from your distribution even if its version is lower than the one
hosted by wakemeops.


=== "Set a low package priority"

    ```shell
    curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/set_repository_priority | sudo bash -s 100
    ```

=== "Set a high package priority"

    ```shell
    curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/set_repository_priority | sudo bash -s 900
    ```

??? abstract title "See script content[^1]"
    ```shell title="set_repository_priority"
    --8<-- "assets/set_repository_priority"
    ```


!!! info
    On Debian/Ubuntu, the default priority for repositories is 500. `apt-cache policy` will show you the
    list of installed repositories alongside their priority.


### List package versions

Use `apt-cache madison` to list available versions for a given package:

```shell
apt-cache madison kubectl
   kubectl | 1.23.1-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.23.0-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.22.4-2~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.22.3-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.22.2-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
```


### Pin down package versions

APT lets you select the version you wish to install with the following syntaxe:

```shell
sudo apt install <package name>=<version>
```

Using wildcards is supported:

=== ":material-check: kubectl >=1.22.0,<1.23.0"

    ```shell
    sudo apt install "kubectl=1.22*"
    ```

=== ":material-check: kubectl >=1.0.0,<2.0.0"

    ```shell
    sudo apt install "kubectl=1*"
    ```

=== ":material-check: kubectl == 1.23.1"

    ```shell
    sudo apt install "kubectl=1.23.1*"
    ```

!!! warning
    We only keep the latest revision of each package, beware that pinning down the *exact*
    package version in a CI pipeline may eventually break. In a CI pipeline, you should
    always use a wildcard permissive enough to let APT use the latest package revision.
    **The revision is the number after the last hyphen in a package version**
    (example: 1.23.1-**1**~ops2deb). The revision is not part of the application version,
    it basically is an iteration of the Debian package. In Debian distributions reasons
    to bump the revision of a package include: packaging errors, backports of patches
    and security patches...

    In short:

    * :material-check: `sudo apt-get install -yq kubectl=1.23.1*`
    * :material-alert: `sudo apt-get install -yq kubectl=1.23.1-1~ops2deb`



## Docker images


### Image tags

We provide docker images based on Debian and Ubuntu that come pre-configured with WakeMeOps repository:

=== "Debian"

    === "latest"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/debian/tags?name=latest'>https://hub.docker.com/r/wakemeops/debian/tags?name=latest</a>"
        docker pull wakemeops/debian:latest
        ```


    === "buster"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/debian/tags?name=buster'>https://hub.docker.com/r/wakemeops/debian/tags?name=buster</a>"
        docker pull wakemeops/debian:buster
        ```

    === "buster-slim"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/debian/tags?name=buster-slim'>https://hub.docker.com/r/wakemeops/debian/tags?name=buster-slim</a>"
        docker pull wakemeops/debian:buster-slim
        ```

    === "bullseye"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/debian/tags?name=bullseye'>https://hub.docker.com/r/wakemeops/debian/tags?name=bullseye</a>"
        docker pull wakemeops/debian:bullseye
        ```

    === "bullseye-slim"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/debian/tags?name=bullseye-slim'>https://hub.docker.com/r/wakemeops/debian/tags?name=bullseye-slim</a>"
        docker pull wakemeops/debian:bullseye-slim
        ```


    === "bookworm"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/debian/tags?name=bookworm'>https://hub.docker.com/r/wakemeops/debian/tags?name=bookworm</a>"
        docker pull wakemeops/debian:bookworm
        ```

    === "bookworm-slim"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/debian/tags?name=bookworm-slim'>https://hub.docker.com/r/wakemeops/debian/tags?name=bookworm-slim</a>"
        docker pull wakemeops/debian:bookworm-slim
        ```

=== "Ubuntu"

    === "latest"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/ubuntu/tags?name=latest'>https://hub.docker.com/r/wakemeops/ubuntu/tags?name=latest</a>"
        docker pull wakemeops/ubuntu:latest
        ```

    === "rolling"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/ubuntu/tags?name=rolling'>https://hub.docker.com/r/wakemeops/ubuntu/tags?name=rolling</a>"
        docker pull wakemeops/ubuntu:rolling
        ```

    === "18.04"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/ubuntu/tags?name=18.04'>https://hub.docker.com/r/wakemeops/ubuntu/tags?name=18.04</a>"
        docker pull wakemeops/ubuntu:18.04
        ```

    === "20.04"

        ```bash title="<a href='https://hub.docker.com/r/wakemeops/ubuntu/tags?name=20.04'>https://hub.docker.com/r/wakemeops/ubuntu/tags?name=20.04</a>"
        docker pull wakemeops/ubuntu:20.04
        ```

!!! info
    WakeMeOps images are rebuilt every day [from this Dockerfile](https://github.com/upciti/wakemeops/blob/main/Dockerfile)
    to keep track of the latest changes - such as security fixes - in upstream images.

### Write Dockerfiles

All docker images include a thin wrapper around `apt-get install` named `install_packages`.
It adds retries and does the usual `apt-get update` followed by `rm -r /var/lib/apt/lists /var/cache/apt/archives`.
This handy script comes from the [bitnami minideb image](https://github.com/bitnami/minideb).

??? abstract title "See script content[^1]"
    ```shell title="install_packages"
    --8<-- "assets/install_packages"
    ```

You can leverage this script to write very short dockerfiles for your CI:

=== "I'm careful"

    ```dockerfile
    FROM wakemeops/debian:bullseye

    RUN install_packages \
        helm=3.7.2* \
        kustomize=4.4.1* \
        kubectl=1.23.1*

    USER 1001
    ```

=== "I like to live on the edge :fire:"

    ```dockerfile
    FROM wakemeops/debian:bullseye

    RUN install_packages helm kustomize kubectl
    ```

[^1]: The script content is inserted using the markdown extension `pymdownx.snippets`
when the documentationis built in our CI. The actual content may differ.
