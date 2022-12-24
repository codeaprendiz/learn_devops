# Analyzing Network Traffic With VPC Flow Logs

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

## High Level Objectives

- Configure a custom network with VPC flow logs
- Create an Apache web server
- Verify that network traffic is logged
- Export the network traffic to BigQuery to further analyze the logs
- Add VPC flow log aggregation

### Configure a custom network with VPC flow logs

- In the Cloud Console, in the Navigation menu (Navigation menu icon), select VPC network > VPC networks.  `vpc-net`


| Property    | Value           |
|-------------|-----------------|
| Name        | vpc-net         |


- Subnet creation mode, click Custom

| Property         | Value       |
|------------------|-------------|
| Name             | vpc-subnet  |
| Region           | us-central1 |
| IP address range | 10.1.3.0/24 |
| Flow Logs        | On          |


- Create Firewall Rule

| Property            | Value                                                           |
|---------------------|-----------------------------------------------------------------|
| Name                | allow-http-ssh                                                  |
| Network             | vpc-net                                                         |
| Targets             | Specified target tags                                           |
| Target tags         | http-server                                                     |
| Source filter       | IPv4 Ranges                                                     |
| Source IPv4 ranges  | 0.0.0.0/0                                                       |
| Protocols and ports | Specified protocols and ports, and then check tcp, type: 80, 22 |

### Create an Apache web server

- In the Navigation menu, select Compute Engine > VM instances.

| Property     | Value         |
|--------------|---------------|
| Name         | web-server    |
| Region       | us-central1   |
| Zone         | us-central1-c |
| Series       | N1            |
| Machine type | f1-micro      |

- Click Networking, Disks, Security, Management, Sole-tenancy.
- For Network tags, type http-server.
- Specify the following and leave the remaining settings as their defaults:

| Property   | Value                    |
|------------|--------------------------|
| Network    | vpc-net                  |
| Subnetwork | vpc-subnet (10.1.3.0/24) |


- Install Apache

```bash
# In the web-server SSH terminal, update the package index:
sudo apt-get update

# Install the apache2 package:
sudo apt-get install apache2 -y

# To create a new default web page by overwriting the default, run the following:
echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html
```

### Verify that network traffic is logged

- Find your IP address
- In the Cloud Console, go to Navigation menu > Logging > Logs Explorer.


### Export the network traffic to BigQuery to further analyze the logs

- Create an export sink
- Generate log traffic for BigQuery
- Note the External IP address for the web-server instance. It will be referred to as EXTERNAL_IP.

```bash
# Store the EXTERNAL_IP in an environment variable in Cloud Shell:
export MY_SERVER=<Enter the EXTERNAL_IP here>

# Access the web-server 50 times from Cloud Shell:
for ((i=1;i<=50;i++)); do curl $MY_SERVER; done
```

- Visualize the VPC flow logs in BigQuery

- Add the following to the BigQuery Editor and replace your_table_id with TABLE_ID while retaining the accents (`) on both sides:

```roomsql
#standardSQL
SELECT
jsonPayload.src_vpc.vpc_name,
SUM(CAST(jsonPayload.bytes_sent AS INT64)) AS bytes,
jsonPayload.src_vpc.subnetwork_name,
jsonPayload.connection.src_ip,
jsonPayload.connection.src_port,
jsonPayload.connection.dest_ip,
jsonPayload.connection.dest_port,
jsonPayload.connection.protocol
FROM
`your_table_id`
GROUP BY
jsonPayload.src_vpc.vpc_name,
jsonPayload.src_vpc.subnetwork_name,
jsonPayload.connection.src_ip,
jsonPayload.connection.src_port,
jsonPayload.connection.dest_ip,
jsonPayload.connection.dest_port,
jsonPayload.connection.protocol
ORDER BY
bytes DESC
LIMIT
15
```

- Analyze the VPC flow logs in BigQuery
- Create a new query in the BigQuery Editor with the following and replace your_table_id with TABLE_ID while retaining the accents (`) on both sides:

```roomsql
#standardSQL
SELECT
jsonPayload.connection.src_ip,
jsonPayload.connection.dest_ip,
SUM(CAST(jsonPayload.bytes_sent AS INT64)) AS bytes,
jsonPayload.connection.dest_port,
jsonPayload.connection.protocol
FROM
`your_table_id`
WHERE jsonPayload.reporter = 'DEST'
GROUP BY
jsonPayload.connection.src_ip,
jsonPayload.connection.dest_ip,
jsonPayload.connection.dest_port,
jsonPayload.connection.protocol
ORDER BY
bytes DESC
LIMIT
15
```



### Add VPC flow log aggregation

- In the Console, navigate to the Navigation menu (Navigation menu icon) and select VPC network > VPC networks.


