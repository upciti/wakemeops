ARG REGISTRY="docker.io"
ARG IMAGE="debian"
ARG TAG="buster"

FROM ${REGISTRY}/${IMAGE}:${TAG} as dev

ARG FINAL_USER=0
ARG COMPONENTS="devops secops terminal"
ARG PACKAGES=""

USER 0

ENV APT_DEPENDENCIES="curl ca-certificates gnupg2" \
    FINAL_USER=${FINAL_USER} \
    PACKAGES=${PACKAGES}

COPY assets/install_packages /usr/local/bin/

# install wakemops repository
RUN chmod +x /usr/local/bin/install_packages && \
    install_packages ${APT_DEPENDENCIES} && \
    curl https://gitlab.com/upciti/wakemeops/-/snippets/2189589/raw/main/install.sh | bash -s ${COMPONENTS} && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# install packages if needed
RUN test "${PACKAGES}" && install_packages ${PACKAGES}; \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

USER ${FINAL_USER}
