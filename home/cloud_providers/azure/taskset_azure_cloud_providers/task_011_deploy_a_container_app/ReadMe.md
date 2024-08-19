# [Exercise - Deploy a container app](https://learn.microsoft.com/en-us/training/modules/implement-azure-container-apps/3-exercise-deploy-app)

## Prepare your environment

Install the Azure Container Apps extension for the CLI.

```bash
az extension add --name containerapp --upgrade
```

Register the Microsoft.App namespace.

```bash
az provider register --namespace Microsoft.App
```

Register the Microsoft.OperationalInsights provider for the Azure Monitor Log Analytics workspace

```bash
az provider register --namespace Microsoft.OperationalInsights
```

Set environment variables used later in this exercise. Replace <location> with a region near you.

```bash
RANOM=22388202393912
myRG=az204-appcont-rg
myLocation=eastus
myAppContEnv=az204-env-$RANDOM
```

Create the resource group for your container app.

```bash
az group create \
    --name $myRG \
    --location $myLocation
```

## Create an environment

```bash
az containerapp env create \
    --name $myAppContEnv \
    --resource-group $myRG \
    --location $myLocation
```

## Create a container app

```bash
az containerapp create \
    --name my-container-app \
    --resource-group $myRG \
    --environment $myAppContEnv \
    --image mcr.microsoft.com/azuredocs/containerapps-helloworld:latest \
    --target-port 80 \
    --ingress 'external' \
    --query properties.configuration.ingress.fqdn
```

## Verify deployment

Select the link returned by the az containerapp create command to verify the container app is running.

## Clean up resources

```bash
az group delete --name $myRG
```