ARG REGISTRY="docker.io"
ARG IMAGE="debian"
ARG TAG="buster"

FROM ${REGISTRY}/${IMAGE}:${TAG} as runner

ARG FINAL_USER=0
ARG COMPONENTS="devops secops terminal dev"
ARG PACKAGES=""

USER 0

ENV FINAL_USER=${FINAL_USER} \
    PACKAGES=${PACKAGES}

COPY assets/install_repository assets/install_packages /usr/local/bin/

# install wakemops repository
RUN chmod +x /usr/local/bin/install_packages && \
    chmod +x /usr/local/bin/install_repository && \
    install_repository ${COMPONENTS} && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# install packages if needed
RUN if [ ! -z "${PACKAGES}" ]; then install_packages ${PACKAGES}; fi

USER ${FINAL_USER}
