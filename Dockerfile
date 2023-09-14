FROM ubuntu:latest

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install common networking tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    iproute2 \
    iputils-ping \
    traceroute \
    netcat \
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
    python3-distutils && \
    pip3 install --upgrade awscli && \
    git clone https://github.com/aws/efs-utils && \
    cd efs-utils && \
    ./build-deb.sh && \
    apt-get install -y ./build/amazon-efs-utils*deb && \
    cd .. && rm -rf efs-utils \
    && rm -rf /var/lib/apt/lists/*

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add Docker repository
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Install Terraform
ARG TERRAFORM_VERSION="1.5.7"  # You can update this to your desired version
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Terragrunt
ARG TERRAGRUNT_VERSION="0.50.14"  # You can update this to your desired version
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 && \
    chmod +x terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

# Set entrypoint to bash
ENTRYPOINT ["/bin/bash"]
