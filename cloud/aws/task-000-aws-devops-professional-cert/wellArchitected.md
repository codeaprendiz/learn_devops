# Well Architected

## Plan for Disaster Recovery (DR)

- Having backups and redundant workload components in place is the start of your DR strategy. RTO and RPO are your objectives for restoration of your workload.
    - Recovery Time Objective (RTO) is defined by the organization. RTO is the maximum acceptable delay between the interruption of service and restoration of service
    - Recovery Point Objective (RPO) is defined by the organization. RPO is the maximum acceptable amount of time since the last data recovery point. This determines what is considered an acceptable loss of data between the last recovery point and the interruption of service

- Backup and restore (RPO in hours, RTO in 24 hours or less): 
- Pilot light (RPO in minutes, RTO in hours)
- Warm standby (RPO in seconds, RTO in minutes)
- Multi-region (multi-site) active-active (RPO near zero, RTO potentially zero)


## Failure Management
### Use Fault Isolation to Protect Your Workload
