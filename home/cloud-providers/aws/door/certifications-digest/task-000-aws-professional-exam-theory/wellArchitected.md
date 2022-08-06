# Well-Architected

## Plan for Disaster Recovery (DR)

[Cheat Sheet - backup-and-restore-vs-pilot-light-vs-warm-standby-vs-multi-site](https://tutorialsdojo.com/backup-and-restore-vs-pilot-light-vs-warm-standby-vs-multi-site)

[Plan for Disaster Recovery (DR)](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/plan-for-disaster-recovery-dr.html)

- Having backups and redundant workload components in place is the start of your DR strategy. RTO and RPO are your objectives for restoration of your workload
  - Recovery Time Objective (RTO) is defined by the organization. RTO is the maximum acceptable delay between the interruption of service and restoration of service. This determines what is considered an acceptable time window when service is unavailable.
  - Recovery Point Objective (RPO) is defined by the organization. RPO is the maximum acceptable amount of time since the last data recovery point. This determines what is considered an acceptable loss of data between the last recovery point and the interruption of service.

When architecting a multi-region disaster recovery strategy for your workload, you should choose one of the following multi-region strategies.
- Backup and restore (RPO in hours, RTO in 24 hours or less): 
- Pilot light (RPO in minutes, RTO in hours)
- Warm standby (RPO in seconds, RTO in minutes)
- Multi-region (multi-site) active-active (RPO near zero, RTO potentially zero)
