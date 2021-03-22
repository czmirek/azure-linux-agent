FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        wget \
        sudo \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libicu60 \
        libunwind8 \
        netcat \
        libssl1.0 \
        zip \
        unzip

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.1.3/powershell_7.1.3-1.debian.11_amd64.deb
RUN apt-get install -f -y ./powershell_7.1.3-1.debian.11_amd64.deb

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker
WORKDIR /home/docker

RUN wget https://vstsagentpackage.azureedge.net/agent/2.183.1/vsts-agent-linux-x64-2.183.1.tar.gz
RUN tar -xf vsts-agent-linux-x64-2.183.1.tar.gz
RUN sudo ./bin/installdependencies.sh

RUN echo "#!/bin/bash" > entrypoint.sh
RUN echo "echo \"Organization:\$ORGANIZATION\"" >> entrypoint.sh
RUN echo "echo \"Pool:\$POOL\"" >> entrypoint.sh
RUN echo "echo \"Agent:\$AGENT\"" >> entrypoint.sh

RUN echo "./config.sh --unattended --url https://dev.azure.com/\$ORGANIZATION --auth pat --token \$PAT --pool \$POOL --agent \$AGENT --replace --acceptTeeEula" >> entrypoint.sh
RUN echo "./run.sh" >> entrypoint.sh
RUN sudo chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]