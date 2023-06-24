# Monitoring Applications in GCP

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

**High Level Objectives**
- Deploy and test the python app locally on gcp console 
- Deploy an application to App Engine and examine the Cloud logs
- View the Profiler Information
- Explore Cloud Trace
- Monitor resources using Dashboards
- Create uptime checks and alerts

**Skills**
- gcp
- python
- docker
- app engine
- cloud build
- cloud profiler
- cloud trace
- cloud monitoring
- cloud logging
- cloud uptime checks
- cloud alerting
- cloud dashboards


### Deploy and test the python app locally on gcp console


- Run the following in google cloud shell

```bash
# confirm that you are authenticated
gcloud auth list

# to confirm that you are using the correct project for this lab
gcloud config list project
```

- Create folder

```bash
mkdir gcp-logging
cd gcp-logging

# Create the required files over here 
```

- Enable API

```bash
# Profiler has to be enabled in the project
gcloud services enable cloudprofiler.googleapis.com
```

- Build and test locally

```bash
docker build -t test-python .

docker run --rm -p 8080:8080 test-python

# Check the web Preview now
```


### Deploy an application to App Engine and examine the Cloud logs


```bash
# Create app engine
gcloud app create --region=us-central

# deploy your app
gcloud app deploy --version=one --quiet
```

- Check the App Engine URL
- Go to `Tools` and check the `Logs`. Logs should indicate that Profiler has started and profiles are being generated


### View the Profiler Information

- Go the `Profiler`. Check the current insights.
- Start compute instance in any region other than `us-central1`
- SSH

```bash
sudo apt update
sudo apt install apache2-utils -y
nohup ab -n 1000 -c 10 https://<your-project-id>.appspot.com/ > nohup1.out &
nohup ab -n 1000 -c 10 https://<your-project-id>.appspot.com/ > nohup2.out &
nohup ab -n 1000 -c 10 https://<your-project-id>.appspot.com/ > nohup3.out &
```

- Now go back to `Profiler` and check again

### Explore Cloud Trace

- Go to `Trace`
- SSH

```bash
nohup ab -n 1000 -c 10 https://<your-project-id>.appspot.com/ > nohup4.out &
nohup ab -n 1000 -c 10 https://<your-project-id>.appspot.com/ > nohup5.out &
nohup ab -n 1000 -c 10 https://<your-project-id>.appspot.com/ > nohup6.out &
```

### Monitor resources using Dashboards

- Go to `Monitoring` -> `Dashboards`
- Check `App Engine` dashboard
- Check `VM Instances` dashboard
- Click on `Create Dashboard`

### Create uptime checks and alerts

- Select `Uptime Checks`

| Property                | Value                         |
|-------------------------|-------------------------------|
| Title                   | App Engine Uptime Check       |
| App Engine Uptime Check | HTTPS                         |
| Hostname                | <your-project-id>.appspot.com |
| Resource Type           | URL                           |
| Path                    | /                             |
| Check Frequency         | 1 minute                      |


- `Test`
- Alert and Notification `Uptime Check Alert`
- Create `Notification channels`
- Create one with `temp-email` [https://temp-mail.org/en/](https://temp-mail.org/en)
- Save
- Navigate to `App Engine` and `Disable application`. Check URL, it should work anymore
- Return to `Monitoring` and click `Uptime checks`. It should be `Failing`
- Click `Alerting`, An incident should be fired. Check your email.
- Now enable application in `AppEngine`. Everything should be resolved. Check your email.