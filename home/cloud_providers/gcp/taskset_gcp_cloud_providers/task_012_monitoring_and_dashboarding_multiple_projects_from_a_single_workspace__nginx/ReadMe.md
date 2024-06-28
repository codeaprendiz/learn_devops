# Monitoring and Dashboarding Multiple Projects from a Single Workspace

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

**High Level Objectives**
- Configure Resource Projects
- Create a Monitoring Workspace and link the two worker projects into it
- Create and configure Monitoring groups
- Create and test an uptime check


**Skills**
- gcp
- monitoring
- dashboarding
- multiple projects
- monitoring groups
- uptime check


We need to have 3 different Projects.
The first project (ID 1) will be the monitoring workspace host project. 
Projects ID 2 and ID 3 will be the monitored/resource projects. 
Per Google's recommended best practices, the project we use to host the monitoring workspace will not be one of the projects actually housing monitored resources.


### Configure Resource Projects

- Label Project ID 1 as Monitoring Project.
- Label Project ID 2 as Worker 1.
- Label Project ID 3 as Worker 2.

- Launch `NGINX Open Source Packaged by Bitnami` from `Marketplace` in `Worker 1` and `Worker 2` projects

### Create a Monitoring Workspace and link the two worker projects into it

- Go to `Monitoring Project`
- `Monitoring` > `Overview` > `Settings`
- Add `Worker 1` and `Worker 2`
- Choose `Use this project as the scoping project`
- Save and go to `Dashboards`. Take few minutes for explore.

### Create and configure Monitoring groups
- Go to each `Worker` Project
- Assign labels to both VMs in `Worker 1` and `Worker 2`
  - `component:frontend`
  - `stage:dev/test`

- Create Resource Group
- `Monitoring` > `Groups` > `Create` > Name : Frontend Servers
- Give `component` = `frontend` criteria. You should see 2 instances
- Create a `Sub Group`, Keep the first criteria as same. Give second as `stage` = `dev`
- Check the UI when done

### Create and test an uptime check

- Create an uptime check for the Frontend Servers group
- Check out how an uptime check handles failure
- What can Cloud Monitoring, Logging, and Alerting tell us?

### Create a custom dashboard

- Create a developer dashboard and add an uptime chart to it
- Add and test a CPU utilization chart to the dashboard

