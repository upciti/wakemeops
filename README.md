# WakeMeOps

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/upciti/wakemeops)
[![GitLab](https://img.shields.io/badge/GitLab-330F63?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.com/upciti/wakemeops)

Generate Debian packages for common binary tools such as bat, fd, exa, kubectl, terraform, ...
using [ops2deb](https://github.com/upciti/ops2deb).

- [WakeMeOps](#wakemeops)
  - [Projects](#projects)
  - [Configuration](#configuration)
    - [Install wakemeops repository](#install-wakemeops-repository)
    - [Reduce the priority of the wakemeops repository](#reduce-the-priority-of-the-wakemeops-repository)
  - [Install package](#install-package)
  - [Available packages](#available-packages)

## Projects

This project uses two other open-source projects:

- [ops2deb](https://github.com/upciti/ops2deb)
- [wakemebot](https://github.com/upciti/wakemebot)

## Configuration

### Install wakemeops repository

```shell
curl https://gitlab.com/upciti/wakemeops/-/snippets/2189589/raw/main/install.sh | sudo bash -s devops secops terminal
```

### Reduce the priority of the wakemeops repository

If you want to keep the default deposits as priority,
use the command below:

```shell
cat << EOF | sudo tee /etc/apt/preferences.d/01wakemeops
Package: *
Pin: origin deb.wakemeops.com
Pin-Priority: 100
EOF
```

## Install package

```shell
sudo apt-get update
sudo apt-get install bat
```

## Available packages

| Package        | Components  | Arch  |
| -------------- | ----------- | ----- |
| argocd         | devops      | amd64 |
| datree         | devops      | amd64 |
| devspace       | devops      | amd64 |
| docker-compose | devops      | amd64 |
| flux           | devops      | amd64 |
| helm           | devops      | amd64 |
| helmfile       | devops      | amd64 |
| istioctl       | devops      | amd64 |
| k3d            | devops      | amd64 |
| k9s            | devops      | amd64 |
| kind           | devops      | amd64 |
| krew           | devops      | amd64 |
| kubectl        | devops      | amd64 |
| kubectl-neat   | devops      | amd64 |
| kubectx        | devops      | amd64 |
| kubens         | devops      | amd64 |
| kube-score     | devops      | amd64 |
| kubeseal       | devops      | amd64 |
| kustomize      | devops      | amd64 |
| linkerd        | devops      | amd64 |
| logcli         | devops      | amd64 |
| minikube       | devops      | amd64 |
| minio-client   | devops      | amd64 |
| minio-server   | devops      | amd64 |
| natscli        | devops      | amd64 |
| rancher        | devops      | amd64 |
| scw            | devops      | amd64 |
| terraform      | devops      | amd64 |
| trivy          | secops      | amd64 |
| vault          | secops      | amd64 |
| velero         | secops      | amd64 |
| bat            | terminal    | amd64 |
| choose         | terminal    | amd64 |
| curlie         | terminal    | amd64 |
| dog            | terminal    | amd64 |
| dust           | terminal    | amd64 |
| exa            | terminal    | amd64 |
| fd             | terminal    | amd64 |
| gping          | terminal    | amd64 |
| procs          | terminal    | amd64 |
| ripgrep        | terminal    | amd64 |
| xh             | terminal    | amd64 |
| yq             | terminal    | amd64 |
