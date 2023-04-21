# Credits
## Original author
This repository was created initially as a rework of the following 2 repositories belonging to the github user [Pwd9000-ML](https://github.com/Pwd9000-ML):
* https://github.com/Pwd9000-ML/docker-github-runner-linux
* https://github.com/Pwd9000-ML/docker-github-runner-windows
## Maintainer
* [Bogdan Grozoiu](https://github.com/bogdan-grozoiu)

# Status
[![Build and Deploy the GH Runners and DevOps Agents in Azure Azure Container Apps](https://github.com/msft-azure-iac-hackathon/github-runner-and-devops-agent-in-azure-container-apps/actions/workflows/build-and-deploy-workflow.yml/badge.svg)](https://github.com/msft-azure-iac-hackathon/github-runner-and-devops-agent-in-azure-container-apps/actions/workflows/build-and-deploy-workflow.yml)
# Scope
Help organizations jumpstart their way into GitHub and Azure DevOps with low-cost self-hosted runners.

# Goal
Demonstrate the creation of GitHub Runners and Azure DevOps Agents and the full greenfield Azure Infrastructure to run them.

They will run in Azure Container Apps with private networking.

# License
* [MIT](https://github.com/MSFT-NL-Demo/github-runner-in-azure-container-apps/blob/main/LICENSE)

# Secrets needed
* TENANT_ID - the ID of the Azure AD tenant where you've registered the SPN for this deployment
* SUBSCRIPTION_ID - the ID of the Azure Subscription where all the components will deployed
* CLIENT_ID - the ID of the client to be used for the OIDC login steps

* GH_OWNER - the name of the GitHub organization where the new GH runner will self register
* GH_REPOSITORY - the name of the GitHub repository where the new GH runner will self register (only if you intend to do worker registration at repo level)
* GH_PAT - your fine grained token meeting the following needs:
    - Organization permissions:
        - Read access to organization administration
        - Read and Write access to organization self hosted runners
    - Repository permissions: none
* ADO_ORG_URL - the url of the Azure DevOps Organization where the new DevOps agents will self register
* ADO_HOSTPOOL_NAME - the name of the Azure DevOps hostpool name where the new DevOps agents will self register
* ADO_PAT - your fine grained token meeting the following requirements:
    - Agents Pool
        - Read and Manage
    - Code
        - Read and Write
    - Packaging
        - Read and Write
