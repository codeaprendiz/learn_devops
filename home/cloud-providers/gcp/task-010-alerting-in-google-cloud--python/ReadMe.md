# Deploying same Python app to AppEngine, GKE, CloudRun

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

## Objective

- Run the app locally on gcp console
- Deploy to App Engine
- Examine the App Engine Logs
- Create an App Engine latency alert
- Creating an Alerting Policy with the CLI




### Run the app locally on gcp console

```bash
sudo pip3 install -r requirements.txt
python3 main.py
```

- Web Preview

### Deploy to App Engine

- Create file app.yaml

```bash
# create App Engine application 
gcloud app create --region=us-central

# Deploy the app using
gcloud app deploy --version=one --quiet
```

- Navigate to App Engine dashboard
- Click on the URL


### Examine the App Engine Logs

- `Tools` -> `Logs`

### Create an App Engine latency alert

#### Check current application latency in Metrics explorer


- `Monitoring` > `Metrics explorer` 
- `Resource & Metric` > `GAE Application` > `Http` > `Response latency`    (Wait and hard refresh the page if required)
- `Aggregator` to `mean`
- Advanced options : `Aligner` to `99th percentile`

This show the average time it took our application to return a response to the fastest 99% of requests, cutting off 1% of anomalies.


#### Create an alert based on the same metric

- `Monitoring` > `Alerting`
- Add new notification channel. Give temporary email [temp-mail.org](https://temp-mail.org/en/)
- `Alerting` > `Create Policy`
- `Select a metric` > `Resource & Metric` > `GAE Application` > `Http` > `Response latency`    (Wait and hard refresh the page if required)
- `Apply` > Set `rolling window` to `1 min`
- `Any time series violates` the `Condition` `is above` a Threshold of `8000`ms, it should trigger an alert.
- Set `condition name` to `Response latency [MEAN] for 99th% over 8s`
- Next and select notification channel
- Name the alert `Hello too slow` > `Next` > `Create Policy`

- Run this on the gcp console

```bash
while true; do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/sleepy200 | grep -e "<title>" -e "sleep";sleep .$[( $RANDOM % 10 )]s;done
```
- Check after 5 mins - `Monitoring` > `Alerting`
- Check temp email. 
- `Acknowledge Incident` and see the difference


### Creating an Alerting Policy with the CLI

- Run on gcp console

```bash
gcloud alpha monitoring policies create --policy-from-file="app-engine-error-percent-policy.json"
```
- Check the new policy created in console
- Run 

```bash
while true; do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/random500error | grep -e "<title>" -e "error";sleep .$[( $RANDOM % 10 )]s;done
```

- `Monitoring` > `Alerting`, wait another few minutes.
- Check your temp email agin