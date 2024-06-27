# Licence And Version

- [stackoverflow.com » How do I find out what License has been applied to my SQL Server installation?](https://stackoverflow.com/questions/4099453/how-do-i-find-out-what-license-has-been-applied-to-my-sql-server-installation)

```sql
SELECT
 SERVERPROPERTY('MachineName') AS ComputerName,
 SERVERPROPERTY('ServerName') AS InstanceName,
 SERVERPROPERTY('Edition') AS Edition,
 SERVERPROPERTY('ProductVersion') AS ProductVersion,
 SERVERPROPERTY('ProductLevel') AS ProductLevel;
GO
```


| ComputerName  | InstanceName  | Edition                     | ProductVersion | ProductLevel |
|---------------|---------------|-----------------------------|----------------|--------------|
| sqlEnterprise | sqlEnterprise | Enterprise Edition (64-bit) | 16.0.4075.1    | RTM          |

---

# MSSQL

- [Quickstart: Run SQL Server Linux container images with Docker](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&pivots=cs1-bash)
- [SQL Server on Linux Frequently Asked Questions (FAQ)](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-faq?view=sql-server-ver16#licensing)
- [Installation guidance for SQL Server on Linux](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup?view=sql-server-ver16)
- [Configure SQL Server settings with environment variables on Linux](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables?view=sql-server-ver16)
- [Deploy and connect to SQL Server Linux containers](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment?view=sql-server-ver16&pivots=cs1-bash)
- [Sample: Unattended SQL Server installation script for SUSE Linux Enterprise Server](https://learn.microsoft.com/en-us/sql/linux/sample-unattended-install-suse?view=sql-server-ver16)
- [microsoft.com » 2019 » product-licencing/sql-server » Go to the bottom resources section to download the pdf guide](https://www.microsoft.com/en-us/licensing/product-licensing/sql-server)
- [serverfault.com » How can I check if SQL Server 2019 Standard is activated on Server Core?](https://serverfault.com/questions/1060095/how-can-i-check-if-sql-server-2019-standard-is-activated-on-server-core)
- [serverfault.com » Can you help me with my software licensing issue?](https://serverfault.com/questions/215405/can-you-help-me-with-my-software-licensing-issue)
- [reddit.com » Is there a way to verify the number of CALs on my SQL Server Standard 2019?](https://www.reddit.com/r/SQLServer/comments/tzvudl/is_there_a_way_to_verify_the_number_of_cals_on_my/)

<br>

## Reddit Threads

- [reddit.com » SQL Server Developer Edition Question](https://www.reddit.com/r/SQLServer/comments/f58ppw/sql_server_developer_edition_question/)
- [www.brentozar.com » Microsoft SQL Server Licensing Simplified into 7 Rules](https://www.brentozar.com/archive/2015/04/microsoft-sql-server-licensing-simplified-into-7-rules/)
- [reddit.com » Developer Edition using Prod domain/vlan](https://www.reddit.com/r/SQLServer/comments/vxhdg4/developer_edition_using_prod_domainvlan/)
- [reddit.com » MS Sql Server - What is "production" data?](https://www.reddit.com/r/SQLServer/comments/15ncbns/ms_sql_server_what_is_production_data/)
- [reddit.com » Developer Edition Time Limit?](https://www.reddit.com/r/SQLServer/comments/i9hcvo/developer_edition_time_limit/)

<br>

## Other Threads

- [learn.microsoft.com » How To Check SQL Server Activation With Valid Key](https://learn.microsoft.com/en-us/answers/questions/1151391/how-to-check-sql-server-activation-with-valid-key)
- [quora.com » How do I check if the MS SQL server licenses are valid?](https://www.quora.com/How-do-I-check-if-the-MS-SQL-server-licenses-are-valid)


<br>

## Docker Commands

The Docker run command for SQL Server involves specifying the edition you want to use through the `MSSQL_PID` environment variable. Below are the Docker run commands for various editions of SQL Server:

<br>

## 1. Enterprise Edition

```bash
docker run --rm \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_SA_PASSWORD=Password12345" \
-e "MSSQL_PID=Enterprise" \
-e "MSSQL_AGENT_ENABLED=1" \
-p 1433:1433 --name sqlEnterprise --hostname sqlEnterprise \
-d mcr.microsoft.com/mssql/server:2022-latest
```

<br>

## 2. Standard Edition

```bash
docker run --rm \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_SA_PASSWORD=Password12345" \
-e "MSSQL_PID=Standard" \
-e "MSSQL_AGENT_ENABLED=1" \
-p 1433:1433 --name sqlStandard --hostname sqlStandard \
-d mcr.microsoft.com/mssql/server:2022-latest
```

<br>

## 3. Express Edition

```bash
docker run --rm \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_SA_PASSWORD=Password12345" \
-e "MSSQL_PID=Express" \
-e "MSSQL_AGENT_ENABLED=1" \
-p 1433:1433 --name sqlExpress --hostname sqlExpress \
-d mcr.microsoft.com/mssql/server:2022-latest
```

<br>

## 4. Developer Edition

```bash
docker run --rm \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_SA_PASSWORD=Password12345" \
-e "MSSQL_PID=Developer" \
-e "MSSQL_AGENT_ENABLED=1" \
-p 1433:1433 --name sqlDeveloper --hostname sqlDeveloper \
-d mcr.microsoft.com/mssql/server:2022-latest
```

<br>

### Notes

- Ensure to replace `"Password12345"` with a strong password as per your security guidelines.
- The `MSSQL_PID` environment variable is used to specify the edition of SQL Server to run.
- Ensure that you comply with licensing terms for the edition you are using, especially for production use.
- Always store sensitive data like passwords securely, consider using Docker secrets or environment variable files instead of hard-coding them into your commands or scripts.
- Ensure that the port `1433` is not being used by another service on your host machine.
- For production deployments, consider additional configuration for security, data persistence, and performance tuning.

Always refer to the [official Microsoft documentation](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker) for the most accurate and up-to-date information.
