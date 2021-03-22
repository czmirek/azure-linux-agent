# Azure Pipeline Linux agent

Easy to use docker image for creating a self-hosted Azure Pipeline Linux agent.

Changelog

- March 22:
  - added git to the agent
  - added --replace to override any existing agent with same name
  - added Azure CLI
  - added Powershell 7.1.3
- March 19: Update
- February 2021: Created

```console
docker run -e ORGANIZATION=myorganization 
           -e PAT=your_personal_access_token_very_long_hash 
           -e AGENT=agent_name 
           -e POOL=agent_pool_name czmirek/azure-pipeline-linux-agent:latest
```
