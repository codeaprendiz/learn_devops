# Minimal NodeJS App - Dockerize - Google Artifact Registry 


[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Lab -  Introduction to Docker](https://www.cloudskillsboost.google/paths)


**High Level Objectives**
- Build a minimal NodeJS app
- Dockerize the app
- Run locally and debug using docker
- Push to Google Artifact Registry




**Skills**
- gcp
- docker
- nodejs
- artifact registry


## Build

```bash
mkdir test && cd test


cat > Dockerfile <<EOF
# Use an official Node runtime as the parent image
FROM node:lts
# Set the working directory in the container to /app
WORKDIR /app
# Copy the current directory contents into the container at /app
ADD . /app
# Make the container's port 80 available to the outside world
EXPOSE 80
# Run app.js using node when the container launches
CMD ["node", "app.js"]
EOF



cat > app.js <<EOF
const http = require('http');
const hostname = '0.0.0.0';
const port = 80;
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n');
});
server.listen(port, hostname, () => {
    console.log('Server running at http://%s:%s/', hostname, port);
});
process.on('SIGINT', function() {
    console.log('Caught interrupt signal and will exit');
    process.exit();
});
EOF
```

- Docker build

```bash
docker build -t node-app:0.1 .
```

- Now, run the following command to look at the images you built:

```bash
docker images
```

## Run

```bash
docker run -p 4000:80 --name my-app node-app:0.1
```

- Open another terminal (in Cloud Shell, click the + icon), and test the server:

```bash
curl http://localhost:4000
```

- Close the initial terminal and then run the following command to stop and remove the container:

```bash
docker stop my-app && docker rm my-app
```

- Now run the following command to start the container in the background:

```yaml
docker run -p 4000:80 --name my-app -d node-app:0.1
docker ps
```

- Notice the container is running in the output of docker ps. You can look at the logs by executing docker logs [container_id].

```bash
docker logs [container_id]
```

- In your Cloud Shell, open the test directory you created earlier in the lab:

```bash
cd test
```

- Edit app.js with a text editor of your choice (for example nano or vim) and replace "Hello World" with another string:

```bash
....
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Welcome to Cloud\n');
});
....
```

- Build this new image and tag it with 0.2:

```bash
docker build -t node-app:0.2 .
```

- Run another container with the new image version.  
  Notice how we map the host's port 8080 instead of 80. You can't use host port 4000 because it's already in use.

```bash
docker run -p 8080:80 --name my-app-2 -d node-app:0.2
docker ps
```

- Test the containers:

```bash
curl http://localhost:8080

## And now test the first container you made:
curl http://localhost:4000
```

## Debug

- You can look at the logs of a container using docker logs [container_id]. 
  If you want to follow the log's output as the container is running, use the -f option.

```bash
docker logs -f [container_id]
```

- You can use docker exec to do this.

```bash
docker exec -it [container_id] bash

## look at dir
ls
```

- You can examine a container's metadata in Docker by using Docker inspect:

```bash
docker inspect [container_id]
```

- Use --format to inspect specific fields from the returned JSON. For example:

```bash
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' [container_id]
```

## Publish

- Create the target Docker repository

- From the Navigation Menu, under CI/CD navigate to Artifact Registry > Repositories.
- Specify my-repository as the repository name.


- Configure authentication

```bash
# To set up authentication to Docker repositories in the region us-central1, run the following command in Cloud Shell:
gcloud auth configure-docker us-central1-docker.pkg.dev
```

- Push the container to Artifact Registry

```bash
export PROJECT_ID=$(gcloud config get-value project)
cd ~/test

# Run the command to tag node-app:0.2.
docker build -t us-central1-docker.pkg.dev/$PROJECT_ID/my-repository/node-app:0.2 .


docker images

# Push this image to Artifact Registry.
docker push us-central1-docker.pkg.dev/$PROJECT_ID/my-repository/node-app:0.2

```

- Verify the image was pushed in the Artifact Registry console.

- Test the image

```bash
# Stop and remove all containers:
docker stop $(docker ps -q)
docker rm $(docker ps -aq)
```

- Run the following command to remove all of the Docker images.

```bash
docker rmi us-central1-docker.pkg.dev/$PROJECT_ID/my-repository/node-app:0.2
docker rmi node:lts
docker rmi -f $(docker images -aq) # remove remaining images
docker images
```

- Pull the image and run it.

```bash
docker pull us-central1-docker.pkg.dev/$PROJECT_ID/my-repository/node-app:0.2
docker run -p 4000:80 -d us-central1-docker.pkg.dev/$PROJECT_ID/my-repository/node-app:0.2
curl http://localhost:4000
```





