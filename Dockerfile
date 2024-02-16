# Use an official Ubuntu runtime as base image
FROM ubuntu:noble

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/usr/local/go/bin:/venv/bin:$PATH" \
    TERRAFORM_VERSION="1.7.3" \
    TERRAGRUNT_VERSION="0.55.2"

# Install dependencies and the desired softwares
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg2 \
    libexpat1 \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    iproute2 \
    iputils-ping \
    traceroute \
    netcat-openbsd \
    dnsutils \
    telnet \
    curl \
    wget \
    unzip \
    git \
    binutils \
    nfs-common \
    python3 \
    python3-pip \
    python3-distutils \
    python3-venv && \
    rm -rf /var/lib/apt/lists/* && \ 
    python3 -m venv /venv && \
    . /venv/bin/activate && \
    pip3 install --upgrade pip && \
    pip3 install awscli && \
    git clone https://github.com/aws/efs-utils && \
    cd efs-utils && \
    ./build-deb.sh && \
    apt-get update && \ 
    apt-get install -y ./build/amazon-efs-utils*deb && \
    cd .. && rm -rf efs-utils && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Install specific Go version to address vulnerabilities
RUN wget https://go.dev/dl/go1.20.12.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.12.linux-amd64.tar.gz && \
    rm go1.20.12.linux-amd64.tar.gz

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Terragrunt
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 && \
    chmod +x terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

# Set entrypoint to bash
ENTRYPOINT ["/bin/bash"]
