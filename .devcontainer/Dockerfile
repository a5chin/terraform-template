FROM debian:bookworm-slim AS builder

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

# Install gcloud
# ref: https://cloud.google.com/sdk/docs/install#deb
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Install Trivy
# ref: https://trivy.dev/dev/getting-started/installation/
RUN curl https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - && \
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
    | tee -a /etc/apt/sources.list.d/trivy.list

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    google-cloud-cli \
    trivy


FROM mcr.microsoft.com/vscode/devcontainers/base:bookworm

LABEL maintainer="a5chin <a5chin.origin+contact@gmain.com>"

COPY --from=builder --chown=vscode: /usr/bin/python* /usr/bin/python*
COPY --from=builder --chown=vscode: /usr/bin/gcloud /usr/bin/gcloud
COPY --from=builder --chown=vscode: /usr/bin/trivy /usr/bin/trivy
COPY --from=builder --chown=vscode: /usr/lib /usr/lib
