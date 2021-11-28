# EC2

## EC2 Spot

### Getting Started with Amazon EC2 Spot Instances

[Getting Started with Amazon EC2 Spot Instances](https://aws.amazon.com/ec2/spot/getting-started/)


## Fleets

### Example 5: Launch a Spot Fleet using the diversified allocation strategy

[Example 5: Launch a Spot Fleet using the diversified allocation strategy](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-examples.html#fleet-config5)

- A best practice to increase the chance that a spot request can be fulfilled by EC2 capacity in the event of an outage in one of the Availability Zones is to diversify across zones.
- For this scenario, include each Availability Zone available to you in the launch specification. And, instead of using the same subnet each time, use three unique subnets (each mapping to a different zone).


## Storage

### Amazon EBS volume types

[Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html)

- Solid state drives (SSD) — Optimized for transactional workloads involving frequent read/write operations with small I/O size, where the dominant performance attribute is IOPS.
- Hard disk drives (HDD) — Optimized for large streaming workloads where the dominant performance attribute is throughput.
- Previous generation — Hard disk drives that can be used for workloads with small datasets where data is accessed infrequently and performance is not of primary importance

There are several factors that can affect the performance of EBS volumes, such as instance configuration, I/O characteristics, and workload demand

