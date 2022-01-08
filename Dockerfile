ARG REGISTRY="docker.io"
ARG IMAGE="debian"
ARG TAG="bullseye"

FROM ${REGISTRY}/${IMAGE}:${TAG} as runner

USER 0

ARG DEBIAN_FRONTEND=noninteractive
ENV FINAL_USER=${FINAL_USER} \
    PACKAGES=${PACKAGES} \
    DEBIAN_FRONTEND=${DEBIAN_FRONTEND} \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

COPY assets/install_repository assets/install_packages /usr/local/bin/

# install wakemops repository
ARG COMPONENTS="devops secops terminal dev"
RUN chmod +x /usr/local/bin/install_packages && \
    chmod +x /usr/local/bin/install_repository && \
    install_repository ${COMPONENTS} && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# install packages if needed
ARG PACKAGES=""
RUN if [ ! -z "${PACKAGES}" ]; then install_packages ${PACKAGES}; fi

ARG FINAL_USER=0
USER ${FINAL_USER}
