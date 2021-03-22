FROM debian

RUN apt-get update && \
    apt-get upgrade -y && \
    apt install wget -y && \
    apt install sudo -y && \
    apt install git -y

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker
WORKDIR /home/docker

RUN wget https://vstsagentpackage.azureedge.net/agent/2.183.1/vsts-agent-linux-x64-2.183.1.tar.gz
RUN tar -xf vsts-agent-linux-x64-2.183.1.tar.gz
RUN sudo ./bin/installdependencies.sh

RUN echo "#!/bin/bash" > entrypoint.sh
RUN echo "./config.sh --unattended --url https://dev.azure.com/\$ORGANIZATION --auth pat --token \$PAT --pool \$POOL --agent \$AGENT --acceptTeeEula" >> entrypoint.sh
RUN echo "./run.sh" >> entrypoint.sh
RUN sudo chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
