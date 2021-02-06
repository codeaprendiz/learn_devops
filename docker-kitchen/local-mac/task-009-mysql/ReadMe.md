
[Link](https://medium.com/@crmcmullen/how-to-run-mysql-in-a-docker-container-on-macos-with-persistent-local-data-58b89aec496a)

- To stop the mysql process on mac OS
```bash
$ sudo launchctl unload -w /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist
/Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist: Operation now in progress
```


- Create persistent directory
```bash
$ mkdir /Users/[your_username]/Develop
$ mkdir /Users/[your_username]/Develop/mysql_data
$ mkdir /Users/[your_username]/Develop/mysql_data/8.0
```

- Create docker network
```bash
$ docker network create dev-network
```

- Starting the dcoker container on local
```bash
$ docker run --restart always --name mysql8.0 --net dev-network -v /Users/ankitsinghrathi/Develop/mysql_data/8.0:/var/lib/mysql -p 3306:3306 -d -e MYSQL_ROOT_PASSWORD=password mysql:8.0
```

- Connecting to mysql using python
```bash
$ pip3 install mysql-connector-python
```

```python
import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password"
)
mycursor = mydb.cursor()
mycursor.execute("CREATE DATABASE mydatabase")
mycursor.execute("show databases")
for x in mycursor:
    print(x)
...
('information_schema',)
('mydatabase',)
('mysql',)
('performance_schema',)
('sys',)
```
