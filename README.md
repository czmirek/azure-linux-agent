# Azure Pipeline Linux agent

Easy to use docker image for creating a self-hosted Azure Pipeline Linux agent.

Created on February 2021

```console
docker run -e ORGANIZATION=myorganization 
           -e PAT=your_personal_access_token_very_long_hash 
           -e AGENT=agent_name 
           -e POOL=agent_pool_name czmirek/azure-pipeline-linux-agent:latest
```