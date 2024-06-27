# Capture Web Application Logs with App Service Diagnostics Logging

[learn.microsoft.com » Capture Web Application Logs with App Service Diagnostics Logging](https://learn.microsoft.com/en-us/training/modules/capture-application-logs-app-service/)

<br>

## Learning objectives

- Enable app logging on an Azure Web App.
- View live app logging activity with the log streaming service.
- Retrieve app log files from an app with Kudu or the Azure CLI.

<br>

### [Exercise - Enable and configure App Service application logging using the Azure portal](https://learn.microsoft.com/en-us/training/modules/capture-application-logs-app-service/3-enable-and-configure-app-service-application-logging-using-the-azure-portal)

<br>

#### Use Azure CLI to deploy the webapp

Set the variables

```bash
gitRepo=https://github.com/MicrosoftDocs/mslearn-capture-application-logs-app-service
appName="contosofashions$RANDOM"
appPlan="contosofashionsAppPlan"
resourceGroup=learn-73039af5-5f45-4665-837f-e4523655e6cd
storageAccount=sa$appName
appLocation=southeastasia
```

Deploy the webapp

```bash
az appservice plan create --name $appPlan --resource-group $resourceGroup --location $appLocation --sku FREE
az webapp create --name $appName --resource-group $resourceGroup --plan $appPlan --deployment-source-url $gitRepo
```

Create Storage Account

```bash
az storage account create -n $storageAccount -g $resourceGroup -l $appLocation --sku Standard_LRS
```

<br>

#### View live application logging with the log streaming service

To open the log stream, run the following command.

```bash
az webapp log tail --name <app name> --resource-group <resource group name>
```

Reset user-level credentials

```bash
az webapp deployment user set --user-name <name-of-user-to create> --password <new-password>
```

After you have created a set of credentials, run the following command to open the log stream. You're then prompted for the password.

```bash
# curl -u {username} https://{sitename}.scm.azurewebsites.net/api/logstream
```

<br>

### [View live application logging with the log streaming service using Azure CLI](https://learn.microsoft.com/en-us/training/modules/capture-application-logs-app-service/5-view-live-application-logging-activity-with-the-log-streaming-service-using-azure-cli)

Use Azure CLI to view the live log stream

```bash
# az webapp log tail  --resource-group learn-73039af5-5f45-4665-837f-e4523655e6cd --name contosofashions<NNNNNN>
az webapp log tail  --resource-group learn-73039af5-5f45-4665-837f-e4523655e6cd --name contosofashions10908
2023-12-06T08:34:47  Welcome, you are now connected to log-streaming service. The default timeout is 2 hours. Change the timeout with the App Setting SCM_LOGSTREAM_TIMEOUT (in seconds). 
2023-12-06T08:35:16  PID[8672] Error       Error message, in the Page_Load method for About.aspx
2023-12-06T08:35:34  PID[8672] Error       Error message, in the Page_Load method for Default.aspx

# expetect logs
```

<br>

### Retrieve application log files

- To download file system log files using the Azure CLI,

```bash
az webapp log download --log-file \<_filename_\>.zip  --resource-group \<_resource group name_\> --name \<_app name_\>
```

<br>

### [Exercise - Retrieve Application Log Files using Azure CLI and Kudu](https://learn.microsoft.com/en-us/training/modules/capture-application-logs-app-service/7-retrieve-application-log-files-from-an-application-using-azure-cli-and-kudu)

- In Cloud Shell, to download the logs to contosofashions.zip in the cloud share storage,

```bash
# az webapp log download --log-file contosofashions.zip  --resource-group learn-73039af5-5f45-4665-837f-e4523655e6cd --name contosofashions<your-number>
az webapp log download --log-file contosofashions.zip  --resource-group learn-73039af5-5f45-4665-837f-e4523655e6cd --name contosofashions10908
```

- In Cloud Shell, to show the log files contained in the downloaded contosofashions.zip file, run the following command.

```bash
zipinfo -1 contosofashions.zip
```

- In Cloud Shell, to extract just the app log file from the downloaded contosofashions.zip file, run the following command.

```bash
unzip -j contosofashions.zip LogFiles/Application/*.txt
```

- In Cloud Shell, to display the application log file, run the following command.

```bash
code *.txt
```

