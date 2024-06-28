# Application Performance Management

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

**High Level Objectives**
- Download a pair of sample apps from GitHub
- Deploy the converter application to App Engine
- Debug the application
- Adding log data
- Fix the bug and deploy a new version
- Examine an error report coming out of Cloud Run in Error Reporting
- Examine a default and custom trace span

**Skills**
- gcp
- gcp-cloud-run
- gcp-app-engine
- debug apps
- python
- nodejs
- custom traces
- trace span


### Download a pair of sample apps from GitHub

- Enable APIs

```bash
gcloud services enable cloudbuild.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud services enable run.googleapis.com

## Clone
cd ~/
git clone https://github.com/haggman/HelloLoggingNodeJS.git

# Change into the HelloLoggingNodeJS folder and use the rebuildService.sh script to deploy the application into Cloud Run:
cd ~/HelloLoggingNodeJS
sh rebuildService.sh

# New terminal session
git clone https://github.com/haggman/gcp-debugging

cd ~/gcp-debugging

# Install req and run
sudo pip3 install -r requirements.txt
python3 main.py
```

- Web Preview (Web preview button) in the Cloud Shell toolbar, and then select Preview on port 8080.

### Deploy the converter application to App Engine

- App Engine needs an application created before it can be used. This is done just once using the gcloud app create command and specifying the region where you want the app to be created. This command takes a minute or so. Please wait for it to complete before moving on:

```bash
gcloud app create --region=us-central
```

- Deploy the Flask application into App Engine. This command takes a minute or three to complete. Please wait for it before moving on:

```bash
gcloud app deploy --version=one --quiet
```

- Visit App Engine URL


### Debug the application

- Navigation menu to navigate to Debugger.
- Authorize
- CREATE SNAPSHOT

### Adding log data

- Logpoint


### Fix the bug and deploy a new version

- main.py
- replace the if-else block on lines 24 through 29 with the following try-catch block. This is Python, so make sure you get the spacing correct:
```python
        try:
            fahrenheit = float(input)
            celsius = int((fahrenheit - 32.0) * 5.0 / 9.0)
        except ValueError:
            fahrenheit = 'Enter a number'
            celsius = 'Invalid Input'
```

- Deploy

```bash
cd ~/gcp-debugging
gcloud app deploy --version=two --quiet
```

### Examine an error report coming out of Cloud Run in Error Reporting


```bash
cd ~/HelloLoggingNodeJS
edit index.js
```

- Hit `/uncaught`
- Navigation menu to view Error Reporting.

```bash
# Create a new Google Cloud Source Repository git repo named hello-world:
cd ~/HelloLoggingNodeJS
gcloud source repos create hello-world
```

- Push a copy of the code into the project Git repository:

```bash
git push --mirror \
https://source.developers.google.com/p/$GOOGLE_CLOUD_PROJECT/r/hello-world
```

### Examine a default and custom trace span

- Navigation menu to select Trace.
- Scroll down to the /slow route. Edit or replace the method so it resembles the following:

```
//Generates a slow request
app.get('/slow', (req, res) => {
    const span1 = tracer.createChildSpan({name: 'slowPi'});
    let pi1=slowPi();
    span1.endSpan();
    const span2 = tracer.createChildSpan({name: 'slowPi2'});
    let pi2=slowPi2();
    span2.endSpan();
    res.send(`Took it's time. pi to 1,000 places: ${pi1}, pi to 100,000 places: ${pi2}`);
});
```

- Rebuild and deploy

```bash
sh rebuildService.sh
```




