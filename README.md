# WakeMeOps

## What is it?

WakeMeOps is an open source effort which aims at centralizing many portable applications - such as statically build applications - in a single Debian repository. WakeMeOps should be compatible with Debian, Ubuntu and other Debian based distributions. It currently mostly contains devops tools such as kubectl, kustomize, helm, k9s, [...](https://docs.wakemeops.com/components/devops/).


## Why do I need it?

When you work with many different devops tools, you may find that it gets cumbersome to follow what the latest version of each and every one of them is because they all get released on their own website or github project.
WakeMeOps aims to centralize all those tools and more in one place to make your life a little bit easier.

Of course WakeMeOps doesn't have to be limited to devops, we are open to incorporate all kinds of reputable tools.


## How does it work?

Debian packages are generated from [ops2deb](https://github.com/upciti/ops2deb) blueprints versioned the `ops2deb-*.yml` configuration files. Those configuration files are automatically updated when new application releases are available.


## Documentation

:notebook_with_decorative_cover: Please refer to our documentation at https://docs.wakemeops.com for more information.


## Roadmap

* [ ] `armhf` support
* [ ] Add license information to packages
* [ ] More packages
