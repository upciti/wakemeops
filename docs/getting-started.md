## Add wakemeops repository

Our repository is currently split into four components, __devops__, __dev__, __secops__, and __terminal__.


* To add all four components, run:

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
curl -sSL https://gitlab.com/upciti/wakemeops/-/snippets/2219988/raw/main/preferences.sh | sudo bash -s 100
```

* If, on the other hand, you wish to increase wakemeops repository priority:

```shell
curl -sSL https://gitlab.com/upciti/wakemeops/-/snippets/2219988/raw/main/preferences.sh | sudo bash -s 900
```

!!! Info
    On Debian/Ubuntu, the default priority for repositories is 500. `apt-cache policy` will show you the list of installed repositories alongside their priority.

## Install packages

```shell
sudo apt install kubectl helm
```
