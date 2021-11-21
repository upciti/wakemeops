## Add wakemeops repository

Our repository is currently split into three components, __devops__, __secops__, and __terminal__.


* To add all three components, run:

```shell
curl -sSL https://gitlab.com/upciti/wakemeops/-/snippets/2189589/raw/main/install.sh | sudo bash
```

* If you are only interested by terminal goodies, just add the __terminal__ component:

```shell
curl -sSL https://gitlab.com/upciti/wakemeops/-/snippets/2189589/raw/main/install.sh | sudo bash -s terminal
```


## Set wakemeops repository priority

Dependending on your use case, you may want to lower the priority of the wakemeops repository
to give packages from your distribution precedence over the ones from wakemeops:

```shell
cat << EOF | sudo tee /etc/apt/preferences.d/01wakemeops
Package: *
Pin: origin deb.wakemeops.com
Pin-Priority: 100
EOF
```

!!! Info
    On Debian/Ubuntu, the default priority for repositories is 500. `apt-cache policy` will show you the list of installed repositories alongside their priority.

## Install packages

```shell
sudo apt install kubectl helm
```
