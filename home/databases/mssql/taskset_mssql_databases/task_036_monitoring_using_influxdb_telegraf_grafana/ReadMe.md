# Near real-time monitoring of SQL Server Linux/containers using Telegraf-InfluxDB and Grafana

- [techcommunity.microsoft.com » Near real-time monitoring of SQL Server Linux/containers using Telegraf-InfluxDB and Grafana](https://techcommunity.microsoft.com/t5/sql-server-blog/near-real-time-monitoring-of-sql-server-linux-containers-using/ba-p/2620050)

```bash
sudo docker exec -it influxdb bash
#then run beow commands inside the container
influx
create database telegraf;
use telegraf; 
show retention policies; 
create retention policy retain30days on telegraf duration 30d replication 1 default; 
quit
```
