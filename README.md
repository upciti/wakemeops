<p align="center">
  <a href="https://docs.wakemeops.com/"><img width="200" height="200" src="https://raw.githubusercontent.com/upciti/wakemeops/main/docs/images/colored-logo.png" alt='WakeMeOps'></a>
</p>

<p align="center"><strong>WakeMeOps</strong> <em>- Debian repository for portable applications.</em></p>

## :star: What is it?

WakeMeOps is an open source effort which aims at centralizing many portable applications - such as statically build applications - in a single Debian repository. WakeMeOps should be compatible with Debian, Ubuntu and other Debian based distributions. It currently mostly contains devops tools such as kubectl, kustomize, helm, k9s, [...](https://docs.wakemeops.com/components/devops/).

## :rocket: Why do I need it?

When you work with many different devops tools, you may find that it gets cumbersome to follow what the latest version of each and every one of them is because they all get released on their own website or github project.
WakeMeOps aims to centralize all those tools and more in one place to make your life a little bit easier.

Of course WakeMeOps doesn't have to be limited to devops, we are open to incorporate all kinds of reputable tools.

### :computer: For terminal

WakeMeOps allows you to accelerate the setup of your terminal:

```bash
sudo apt-get install bat fd dust exa gping
sudo apt-get install pyenv=2.2.* poetry=1.1.*
sudo apt-get install helm=3.7.* kustomize=4.4.* kubectl=1.23.*
```

And to speed up your updates:

```bash
sudo apt-get update
sudo apt-get upgrade
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

Debian packages are generated from [ops2deb](https://github.com/upciti/ops2deb) blueprints versioned the `ops2deb-*.yml` configuration files. Those configuration files are automatically updated when new application releases are available.

## :notebook_with_decorative_cover: Documentation

Please refer to our documentation at https://docs.wakemeops.com for more information.
