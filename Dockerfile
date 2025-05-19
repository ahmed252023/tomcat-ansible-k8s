FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3-pip \
    wget \
    unzip \
    default-jdk \
    git \
    sshpass \
    software-properties-common \
    procps \
    ansible

# Create working directory
WORKDIR /data
COPY . /data

# Set environment variable
ARG ENVIRONMENT=DEV
ENV ENVIRONMENT=$ENVIRONMENT

# Run Ansible once to install Tomcat and deploy sample.war
RUN ansible-playbook --extra-vars="env=${ENVIRONMENT}" /data/tomcat_deploy.yml

# Make sure the scripts are executable
RUN chmod +x /data/entrypoint.sh

# Start Tomcat
ENTRYPOINT ["/data/entrypoint.sh"]
