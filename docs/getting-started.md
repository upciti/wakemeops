## Add wakemeops repository

Our repository is currently split into four components, __devops__, __dev__, __secops__, and __terminal__.

* To add all four components, run:

```shell
curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash
```

* If you are only interested by terminal goodies, just add the __terminal__ component:

```shell
curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash -s terminal
```

### Set wakemeops repository priority

Dependending on your use case, you may want to lower the priority of the wakemeops repository
to give packages from your distribution precedence over the ones from wakemeops:

```shell
curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/set_repository_priority | sudo bash -s 100
```

* If, on the other hand, you wish to increase wakemeops repository priority:

```shell
curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/set_repository_priority | sudo bash -s 900
```

!!! Info
    On Debian/Ubuntu, the default priority for repositories is 500. `apt-cache policy` will show you the list of installed repositories alongside their priority.

### Install packages

```shell
sudo apt install kubectl helm
```

**How to install a specific package version?**

```shell
sudo apt install <package name>=<version>
```

Example:

If you are looking to install the latest version of kubectl 1.22:

* Search for available versions

```shell
apt-cache madison kubectl
   kubectl | 1.23.1-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.23.0-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.22.4-2~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.22.3-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
   kubectl | 1.22.2-1~ops2deb | http://deb.wakemeops.com stable/devops amd64 Packages
```

* Install kubectl

```shell
sudo apt install 1.22.4-2~ops2deb
# or simply run:
sudo apt install kubectl=1.22\*
```

## Docker images

We also provide docker images with the Wakemeops repository. The Dockerfile is available [here](https://github.com/upciti/wakemeops/blob/main/Dockerfile).

Images are available on [wakemeops/debian](https://hub.docker.com/r/wakemeops/debian) and [wakemeops/ubuntu](https://hub.docker.com/r/wakemeops/ubuntu) and are based from the official repositories of [Debian](https://hub.docker.com/_/debian) and [Ubuntu](https://hub.docker.com/_/ubuntu).

They are updated daily by automatic builds to keep track of the latest changes in the upstream images.

### Available versions

**[Debian](https://hub.docker.com/r/wakemeops/debian/tags)**

```bash
docker pull wakemeops/debian:latest
```

- [latest](https://hub.docker.com/r/wakemeops/debian/tags?name=latest)
- [bookstorm](https://hub.docker.com/r/wakemeops/debian/tags?name=bookstorm), [bookstorm-slim](https://hub.docker.com/r/wakemeops/debian/tags?name=bookstorm-slim)
- [bullseye](https://hub.docker.com/r/wakemeops/debian/tags?name=bullseye), [bullseye-slim](https://hub.docker.com/r/wakemeops/debian/tags?name=bullseye-slim)
- [buster](https://hub.docker.com/r/wakemeops/debian/tags?name=buster), [buster-slim](https://hub.docker.com/r/wakemeops/debian/tags?name=buster-slim)

**[Ubuntu](https://hub.docker.com/r/wakemeops/ubuntu/tags)**

```bash
docker pull wakemeops/ubuntu:latest
```

- [latest](https://hub.docker.com/r/wakemeops/ubuntu/tags?name=latest)
- [rolling](https://hub.docker.com/r/wakemeops/ubuntu/tags?name=rolling)
- [20.04](https://hub.docker.com/r/wakemeops/ubuntu/tags?name=20.04)
- [18.04](https://hub.docker.com/r/wakemeops/ubuntu/tags?name=18.04)
