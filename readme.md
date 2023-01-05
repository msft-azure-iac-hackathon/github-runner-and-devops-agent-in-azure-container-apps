# Credits
## Original author
This repository was created initially as a rework of the following 2 repositories belonging to the github user [Pwd9000-ML](https://github.com/Pwd9000-ML):
* https://github.com/Pwd9000-ML/docker-github-runner-linux
* https://github.com/Pwd9000-ML/docker-github-runner-windows
## Maintainer
* [Bogdan Grozoiu](https://github.com/bogdan-grozoiu)

# Status
[![Deploy the Azure infrastructure for GitHub runners](https://github.com/MSFT-NL-Demo/github-runner-in-azure-container-apps/actions/workflows/deploy-azure-infrastructure-for-ghr.yml/badge.svg)](https://github.com/MSFT-NL-Demo/github-runner-in-azure-container-apps/actions/workflows/deploy-azure-infrastructure-for-ghr.yml)
# Scope
* To empower every person and every organization on the planet to achieve more
* Feel free to clone or fork this repo and use it for your own benefit

# Goal
Demonstrate the creation of GitHub Runners (Linux and Windows based) and the full greenfield Azure Infrastructure to run them.

They will run in Azure Container Apps with private networking.

# License
* [MIT](https://github.com/MSFT-NL-Demo/github-runner-in-azure-container-apps/blob/main/LICENSE)

# Secrets needed
* TENANT_ID - the ID of the Azure AD tenant where you've registered the SPN for this deployment
* SUBSCRIPTION_ID - the ID of the Azure Subscription where all the components will deployed
* CLIENT_ID - the ID of the client to be used for the OIDC login steps

* GH_OWNER - the name of the GitHub organization where the new GH runner will self register
* GH_REPOSITORY - the name of the GitHub repository where the new GH runner will self register
* GH_PAT - your fine grained token meeting the following needs:
    - Organization permissions: none
    - Repository permissions (Scoped to the GH_REPOSITORY above)
        - Read access to metadata
        - Read and Write access to administration