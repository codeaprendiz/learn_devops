# Create migration manager
gcloud iam service-accounts create "migration-manager" --display-name "migration-manager"

# Assign roles to migration manager
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member \
  serviceAccount:"migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/cloudmigration.inframanager" \
  --no-user-output-enabled --quiet

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member \
  serviceAccount:"migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/cloudmigration.storageaccess" \
  --no-user-output-enabled --quiet

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member \
  serviceAccount:"migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/iam.serviceAccountUser" \
  --no-user-output-enabled --quiet

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member \
  serviceAccount:"migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/logging.logWriter" \
  --no-user-output-enabled --quiet

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member \
  serviceAccount:"migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/monitoring.metricWriter" \
  --no-user-output-enabled --quiet

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member \
  serviceAccount:"migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/monitoring.viewer" \
  --no-user-output-enabled --quiet

gcloud iam service-accounts add-iam-policy-binding \
  "migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --member=serviceAccount:"migration-manager@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role=roles/iam.serviceAccountTokenCreator --project $DEVSHELL_PROJECT_ID

# Create cloud extension account
gcloud iam service-accounts create "migration-cloud-extension" \
--display-name "migration-cloud-extension"

# Assign roles to cloud extension account
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
  --member serviceAccount:"migration-cloud-extension@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/cloudmigration.storageaccess" \
  --no-user-output-enabled --quiet

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
  --member serviceAccount:"migration-cloud-extension@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/logging.logWriter" \
  --no-user-output-enabled --quiet

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
  --member serviceAccount:"migration-cloud-extension@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com" \
  --role "roles/monitoring.metricWriter" \
  --no-user-output-enabled --quiet