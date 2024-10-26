FROM debian:bookworm-slim AS builder

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg

SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

# Install gcloud
# ref: https://cloud.google.com/sdk/docs/install#deb
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    google-cloud-cli


FROM mcr.microsoft.com/vscode/devcontainers/base:bookworm

LABEL maintainer="a5chin <a5chin.origin+contact@gmain.com>"

COPY --from=builder --chown=vscode: /usr/bin/python* /usr/bin/python*
COPY --from=builder --chown=vscode: /usr/bin/gcloud /usr/bin/gcloud
COPY --from=builder --chown=vscode: /usr/lib /usr/lib
