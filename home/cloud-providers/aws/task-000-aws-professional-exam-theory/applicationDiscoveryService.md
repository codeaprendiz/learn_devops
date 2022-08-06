# AWS Application Discovery Service

[What Is AWS Application Discovery Service?](https://docs.aws.amazon.com/application-discovery/latest/userguide/what-is-appdiscovery.html)

- AWS Application Discovery Service helps you plan your migration to the AWS cloud by collecting usage and configuration data about your on-premises servers.
- Application Discovery Service is integrated with AWS Migration Hub, which simplifies your migration tracking as it aggregates your migration status information into a single console. 
- You can view the discovered servers, group them into applications, and then track the migration status of each application from the Migration Hub console in your home region.
- All discovered data is stored in your AWS Migration Hub home region. 
- Therefore, you must set your home region in the Migration Hub console or with CLI commands before performing any discovery and migration activities. 
- Your data can be exported for analysis in Microsoft Excel or AWS analysis tools such as Amazon Athena and Amazon QuickSight.
- Application Discovery Service offers two ways of performing discovery and collecting data about your on-premises servers:
  - Agentless discovery can be performed by deploying the AWS Agentless Discovery Connector (OVA file) through your VMware vCenter
  - Agent-based discovery can be performed by deploying the AWS Application Discovery Agent on each of your VMs and physical servers.
