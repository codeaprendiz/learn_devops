# Cloud Audit Logs

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)


**High Level Objectives**
- Enable data access logs on Cloud Storage.
- Generate admin and data access activity.
- View Audit logs.

**Skills**
- gcp
- gcp-logging
- access-logs
- audit-logs
- cloud-storage


### Enable data access logs on Cloud Storage


- Navigation Menu > IAM & Admin > Audit Logs.
- Scroll or use Filter to locate `Google Cloud Storage`, then check the box next to it. This should display the Info Panel with options on LOG TYPE.
- Select Admin Read, Data Read and Data Write, and then click SAVE.


### Generate some admin and data access activity

```bash
# Use gsutil to create a Cloud Storage bucket with the same name as your project:
gsutil mb gs://$DEVSHELL_PROJECT_ID

# Make sure the bucket successfully created:
gsutil ls

# Create a simple "Hello World" type of text file and upload it to your bucket:
echo "Hello World!" > sample.txt
gsutil cp sample.txt gs://$DEVSHELL_PROJECT_ID

# Verify the file is in the bucket:
gsutil ls gs://$DEVSHELL_PROJECT_ID

# Create a new auto mode network named mynetwork, then create a new virtual machine and place it on the new network:
gcloud compute networks create mynetwork --subnet-mode=auto
gcloud compute instances create default-us-vm \
--zone=us-west4-b --network=mynetwork

# Delete the storage bucket:
gsutil rm -r gs://$DEVSHELL_PROJECT_ID
```

### Viewing audit logs

- Navigation menu to navigate to Cloud overview > Activity.
- Filters pane, click the Activity types, select all, and click OK
- Click the Resource type > Select GCE Network > OK
- Navigation menu to navigate to Logging > Logs Explorer.
- Click the Log name dropdown and use the filter to locate the activity log under CLOUD AUDIT section and Apply it to the query.
- Log fields explorer to filter to GCS Bucket entries.
- Expand the delete entry, then drill into protoPayload > authenticationInfo field and notice you can see the email address of the user that performed this action.


```bash
gcloud logging read \
"logName=projects/$DEVSHELL_PROJECT_ID/logs/cloudaudit.googleapis.com%2Fdata_access"
```