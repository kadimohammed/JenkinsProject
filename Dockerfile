FROM jenkins/jenkins:lts

USER root

# Install necessary packages
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    sudo \
    wget \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install .NET SDK
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y dotnet-sdk-8.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add jenkins user to sudo group and allow passwordless sudo
RUN usermod -aG sudo jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create dotnet directory and set permissions
RUN mkdir -p /var/www/dotnet && chown -R jenkins:jenkins /var/www/dotnet

# Switch back to jenkins user
USER jenkins

# Set working directory
WORKDIR /var/jenkins_home 