# Cloud Source Repositories Overview


**High Level Objectives**
- Create a new repository
- Clone the new repository into your Cloud Shell session
- Push to the Cloud Source Repository
- Browse files in the Google Cloud Source Repository
- View a file in the Google Cloud repository




**Skills**
- gcp
- cloud-shell
- cloud source repositories




## Create a new repository

```bash
gcloud source repos create REPO_DEMO
```



## Clone the new repository into your Cloud Shell session

```bash
gcloud source repos clone REPO_DEMO
```

## Push to the Cloud Source Repository

```bash
# Go into the local repository you created:
cd REPO_DEMO

# Run the following command to create a file myfile.txt in your local repository:
echo 'Hello World!' > myfile.txt

# Commit the file using the following Git commands:
git config --global user.email "you@example.com"

git config --global user.name "Your Name"

git add myfile.txt

git commit -m "First file using Cloud Source Repositories" myfile.txt

# Once you've committed code to the local repository, add its contents to Cloud Source Repositories using the git push command:
git push origin master
```

## Browse files in the Google Cloud Source Repository

```bash
gcloud source repos list
```

## View a file in the Google Cloud repository

- In the Console go to Navigation menu > Source Repositories.

- Click REPO_DEMO > myfile.txt to view the file's contents in the source code browser.

