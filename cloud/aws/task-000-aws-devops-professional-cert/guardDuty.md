## AWS GuardDuty

[What is Amazon GuardDuty?](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html)

- Amazon GuardDuty is a continuous security monitoring service that analyzes and processes the following Data sources: VPC Flow Logs, AWS CloudTrail management event logs, CloudTrail S3 data event logs, and DNS logs. It uses threat intelligence feeds, such as lists of malicious IP addresses and domains, and machine learning to identify unexpected and potentially unauthorized and malicious activity within your AWS environment. This can include issues like escalations of privileges, uses of exposed credentials, or communication with malicious IP addresses, or domains. For example, GuardDuty can detect compromised EC2 instances serving malware or mining bitcoin.

[How to get started with security response automation on AWS](https://aws.amazon.com/blogs/security/how-get-started-security-response-automation-aws/)


### Finding Types

#### EC2 finding types

- Recon:EC2/Portscan
  - Data source: VPC Flow Logs : This finding informs you that the listed EC2 instance in your AWS environment is engaged in a possible port scan attack because it is trying to connect to multiple ports over a short period of time. 

