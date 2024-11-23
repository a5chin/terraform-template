ARG BASE_IMAGE=mcr.microsoft.com/vscode/devcontainers/python
ARG DEBIAN_VERSION=bookworm
ARG PYTHON_VERSION=3.12
ARG TRIVY_VERSION=0.57.1


FROM ghcr.io/aquasecurity/trivy:$TRIVY_VERSION AS trivy


FROM $BASE_IMAGE:$PYTHON_VERSION-$DEBIAN_VERSION
COPY --from=trivy --chown=vscode: /usr/local/bin/trivy /usr/local/bin/trivy

LABEL maintainer="a5chin <a5chin.origin+contact@gmain.com>"

ARG GCLOUD_SDK_VERSION=502.0.0
ARG TFENV_VERSION=v3.0.0

SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

RUN if [ "$(uname -m)" = 'aarch64' ]; then _ARCH=arm; else _ARCH=x86_64; fi \
    && curl -fsS "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-$GCLOUD_SDK_VERSION-linux-$_ARCH.tar.gz" \
    | tar zx -C /opt \
    && /opt/google-cloud-sdk/install.sh \
    --quiet \
    --usage-reporting=false \
    --additional-components alpha beta

RUN git clone --depth=1 -b $TFENV_VERSION https://github.com/tfutils/tfenv.git /opt/tfenv

ENV PATH=$PATH:/opt/google-cloud-sdk/bin
ENV PATH=$PATH:/opt/tfenv/bin
