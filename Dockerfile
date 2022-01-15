ARG REGISTRY="docker.io"
ARG IMAGE="debian"
ARG TAG="bullseye-slim"

## Base image for builder and runner stages
FROM ${REGISTRY}/${IMAGE}:${TAG} as base_image
COPY --chmod=0755 assets/install_packages /usr/local/bin/
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND} \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8
USER 0

## Builder Stage
FROM base_image as builder
COPY --chmod=0755 assets/install_repository /usr/local/bin/
ARG COMPONENTS="devops secops terminal dev"
RUN install_repository ${COMPONENTS}

## Final image
FROM base_image as runner
COPY --from=builder /etc/apt/sources.list.d/wakemeops.list /etc/apt/sources.list.d/wakemeops.list
COPY --from=builder /etc/apt/trusted.gpg.d/wakemeops-keyring.gpg /etc/apt/trusted.gpg.d/wakemeops-keyring.gpg
ARG FINAL_USER=0
USER ${FINAL_USER}
