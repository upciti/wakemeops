### Build ops2deb
FROM python:3.9-buster AS builder
ENV PATH /root/.local/bin:$PATH

RUN apt-get update \
 && apt-get install -y \
      build-essential \
      fakeroot \
      debhelper \
      git \
      openssh-client \
      aptly \
      expect \
      gnupg \
 && rm -rf /var/lib/apt/lists/* \
 && pip install pipx \
 && pipx install ops2deb \
 && ln -s /usr/bin/unzip /bin/unzip
