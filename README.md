<p align="center">
  <a href="https://docs.wakemeops.com/"><img width="200" height="200" src="https://raw.githubusercontent.com/upciti/wakemeops/main/docs/images/colored-logo.png" alt='WakeMeOps'></a>
</p>

<p align="center"><strong>WakeMeOps</strong> <em>- A Debian repository for portable applications.</em></p>

## :star: What is it?

WakeMeOps is a Debian repository for portable applications.

* Old releases are kept for three years to let you write reproducible Dockerfiles and CI/CD pipelines.
* Applications can easily be added through pull requests on Github using a simple YAML configuration file.
* WakeMeOps is a <a href="https://www.gitops.tech/">GitOps</a> project: the state of the Debian repository is declared and managed using Git and CI/CD.

Our repository contains over 100 applications and is divided into five components: Desktop, DevOps, Dev, SecOps, and Terminal.

For instance, you will find in WakeMeOps these widely used applications:

- Desktop: [mattermost-desktop](https://docs.wakemeops.com/packages/mattermost-desktop)
- Dev: [poetry](https://docs.wakemeops.com/packages/poetry), [pyenv](https://docs.wakemeops.com/packages/pyenv), [github-cli](https://docs.wakemeops.com/packages/github-cli), [glab](https://docs.wakemeops.com/packages/glab)
- DevOps: [kubectl](https://docs.wakemeops.com/packages/kubectl), [helm](https://docs.wakemeops.com/packages/helm), [docker-compose](https://docs.wakemeops.com/packages/docker-compose), [terraform](https://docs.wakemeops.com/packages/terraform)
- SecOps: [trivy](https://docs.wakemeops.com/packages/trivy), [vault](https://docs.wakemeops.com/packages/vault), [boundary](https://docs.wakemeops.com/packages/boundary)
- Terminal: [bat](https://docs.wakemeops.com/packages/bat), [fd](https://docs.wakemeops.com/packages/fd), [yq](https://docs.wakemeops.com/packages/yq), [gping](https://docs.wakemeops.com/packages/gping), [chezmoi](https://docs.wakemeops.com/packages/chezmoi)

See all packages [here](https://docs.wakemeops.com/packages/)

## :rocket: Why do I need it?

When you work with many different devops tools, you may find that it gets cumbersome to follow what the latest version of each and every one of them is because they all get released on their own website or github project.
WakeMeOps aims to centralize all those tools and more in one place to make your life a little bit easier.

Of course WakeMeOps doesn't have to be limited to devops, we are open to incorporate all kinds of reputable tools.

### :computer: For terminal

WakeMeOps allows you to accelerate the setup of your terminal:

```bash
# Add WakeMeOps repository
curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash

# Now you can install packages from WakeMeOps
sudo apt install bat fd dust exa gping
sudo apt install pyenv=2.2.* poetry=1.1.*
sudo apt install helm=3.7.3 kustomize=4.4.* kubectl=1.23.1
```

And to speed up your updates:

```bash
sudo apt update
sudo apt upgrade
```

### :whale: For Dockerfile

WakeMeOps allows you to write concise and readable dockerfiles:

```Dockerfile
FROM wakemeops/debian:bullseye

RUN install_packages \
    helm=3.7.2* \
    kustomize=4.4.1* \
    kubectl=1.23.1*

USER 1001
```

## :monocle_face: How does it work?

Debian packages are generated from [ops2deb](https://github.com/upciti/ops2deb) `ops2deb.yml` configuration files. Those configuration files are automatically updated when new application releases are available.

## :wrench: How to add new packages?

* Install [ops2deb](https://github.com/upciti/ops2deb).
* Add the configuration for the new application in `./blueprints/{component}/{application_name}/ops2deb.yml`.
* Run `make format` to format the configuration file.
* Run `make lock` to update the lock files.
* Create a new pull request using [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).

> [!TIP]
> If you are running on Apple `arm64` based system you can use this command to format and generate lock files:
> ```sh
> docker run --platform linux/amd64 --workdir /home/ops2deb --volume ./:/home/ops2deb --rm \
>   docker.io/wakemeops/debian /bin/bash -c "apt update && apt install -y make ops2deb && make format && make lock"
> ```

## :notebook_with_decorative_cover: Documentation

Please refer to our documentation at https://docs.wakemeops.com for more information.
