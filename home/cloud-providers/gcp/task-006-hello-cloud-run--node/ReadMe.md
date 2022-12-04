# Hello Cloud Run

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)


## Enable the Cloud Run API and configure your Shell environment

- Run the following in cloud shell

```bash
gcloud services enable run.googleapis.com

## Set the compute region
gcloud config set compute/region us-central1

## Set the LOCATION ENV variable
LOCATION="us-central1"
```


## Write the sample node application

- Run the following in cloud shell

```bash
mkdir helloworld && cd helloworld
touch package.json
```

- package.json

```json
{
  "name": "helloworld",
  "description": "Simple hello world sample in Node",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
```

- Create file `index.js`

```bash
touch index.js
```

- index.js

```
const express = require('express');
const app = express();
const port = process.env.PORT || 8080;
app.get('/', (req, res) => {
  const name = process.env.NAME || 'World';
  res.send(`Hello ${name}!`);
});
app.listen(port, () => {
  console.log(`helloworld: listening on port ${port}`);
});
```

## Containerize your app using CloudBuild and upload it to Artifact Registry

- Create a docker file

- Dockerfile

```
# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
FROM node:12-slim
# Create and change to the app directory.
WORKDIR /usr/src/app
# Copy application dependency manifests to the container image.
# A wildcard is used to ensure copying both package.json AND package-lock.json (when available).
# Copying this first prevents re-running npm install on every code change.
COPY package*.json ./
# Install production dependencies.
# If you add a package-lock.json, speed your build by switching to 'npm ci'.
# RUN npm ci --only=production
RUN npm install --only=production
# Copy local code to the container image.
COPY . ./
# Run the web service on container startup.
CMD [ "npm", "start" ]
```


- Let's build the container using `CloudBuild` 

```bash
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld

## List the images
gcloud container images list
```

- You can go to `CloudBuild` on the console as well and check

- Run the image locally

```bash
docker run -d -p 8080:8080 gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
```

- Preview the same in the WebPreview

## Deploy to Cloud Run

- Run the following in cloud shell

```bash
# allow-unauthenticated flag in the command above makes your service publicly accessible.
# When prompted confirm the service name by pressing Enter
gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld --allow-unauthenticated --region=$LOCATION

# On success, the command line displays the service URL
```

- You can now visit your deployed container by opening the service URL in any browser window.


## Clean up

```bash
# Delete the helloworld container image
gcloud container images delete gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld

# delete the cloudrun service
gcloud run services delete helloworld --region=us-central1
```