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

# Install Python, pip and AWS CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* && \
    pip3 install --upgrade awscli

# Set entrypoint to bash
ENTRYPOINT ["/bin/bash"]
