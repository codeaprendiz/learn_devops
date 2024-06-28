# Service Monitoring


[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

[haggman/HelloLoggingNodeJS.git](https://github.com/haggman/HelloLoggingNodeJS.git)

**High Level Objectives**
- Deploy the test nodejs app 
- Use Service Monitoring to create an availability SLO
- Create an alert tied to your SLO
- Trigger the alert

**Skills**
- gcp
- nodejs
- app engine
- app engine logs
- alerting
- service monitoring
- service level objective
- error budget
- error reporting
- monitoring


### Deploy the test nodejs app

- Clone the repo

```bash
git clone https://github.com/haggman/HelloLoggingNodeJS.git

cd HelloLoggingNodeJS
```

- Create new App Engine app

```bash
gcloud app create --region=us-central
```
- Deploy the Hello Logging app to App Engine

```bash
gcloud app deploy
```

- Test the URL

### Use Service Monitoring to create an availability SLO, Create an alert tied to your SLO

- Place some load on application

```bash
# The loop generates ten requests per second. 
# The URL is to the /random-error route, which generates an error about every 1000 requests, 
# so you should see approximately 1 error every 100s.
while true; \
do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/random-error \
-w '\n' ;sleep .1s;done
```

- `App Engine` > `Dashboard`
- Check `Server Errors`
- Navigation menu to go to `Error Reporting`. Notice the error is also being caught here
- Navigation menu to go to `Monitoring` > `Services` > `default` > `+Create SLO` 
  - `Availability` to `Request based`
  - `Period type` to `Rolling` and `Period Length` to `7 days`
  - Set `Goal` to `99.5%`
  - Create



### Create an alert tied to your SLO

- Expand the new SLO and investigate the information it displays
- Check three tabs, `Service level indicator`, `Error budget`, and `Alerts firing`
- `Alerts firing` > `CREATE SLO ALERT`
- `Display Name` to `Really short window test`
- `Lookback duration` to `10` minutes and `burn rate threshold` to `1.5`
- Create notification channel and select it
- Next and create



### Trigger the alert

- In the `index.js` file
  - Scroll to the /random-error route found at approximately line 126 and modify the value next to Math.random from 1000 to 20
- Run

```bash
gcloud app deploy

while true; \
do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/random-error \
-w '\n' ;sleep .1s;done
```

- Wait for sometime and notice the new alert triggered.