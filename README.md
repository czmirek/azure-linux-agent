# Azure Pipeline Linux(Debian) agent (working in February 2021)

Easy to use docker image for creating a self-hosted Azure Pipeline Linux agent.

Created on February 2021

```docker
docker run -e ORGANIZATION=myorganization -e PAT=your_personal_access_token_very_long_hash -e AGENT=agent_name -e POOL=agent_pool_name czmirek/azure-pipeline-linux-agent:latest
```