
### To create a nodejs app which can connect to docker-mongo locally

[docs](https://www.digitalocean.com/community/tutorials/how-to-integrate-mongodb-with-your-node-application)

- Start docker-mongo on your local

```bash
$ docker run -d --name mongo-on-docker -p 27888:27017 -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret mongo
19f594ceb71a6518c98e172f0ab38e45d5c330e99bc5b615b91f08e74587c196
```

- Check if its running

```bash
$ docker ps | egrep -v "k8s"                                                                                                             
CONTAINER ID   IMAGE                            COMMAND                  CREATED              STATUS              PORTS                      NAMES
19f594ceb71a   mongo                            "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:27888->27017/tcp   mongo-on-docker
```

- Connect to mongo and run the following

> NOTE: Use after creation is unable to update database. So we have used admin user itself in database connection. Feel free to raise PR if you figure out the issue.

```bash
$ mongo --username mongoadmin --password  secret --host localhost --port 27888
> use admin
switched to db admin
>
> > db.createUser(
  ...   {
  ...     user: "sammy",
  ...     pwd: "your_password",
  ...     roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  ...   }
  ... )
  Successfully added user: {
          "user" : "sammy",
          "roles" : [
                  {
                          "role" : "userAdminAnyDatabase",
                          "db" : "admin"
                  }
          ]
  }
> exit
bye
```

- Let's add mongoose package

```bash
$ cd node_project                
$ npm install mongoose
added 31 packages, and audited 82 packages in 5s
found 0 vulnerabilities
```


- Create models

```bash
$ mkdir models
$ touch models/sharks.js    
```

- Create controllers

```bash
$ mkdir controllers
$ controllers/sharks.js
```

- Using EJS and Express Middleware to Collect and Render Data

- Install EJS module first

```bash
$ npm install ejs
```

- Create routes

```bash
$ mkdir routes
```


- Running the application

```bash
$ node app.js
(node:48367) Warning: Accessing non-existent property 'count' of module exports inside circular dependency
(Use `node --trace-warnings ...` to show where the warning was created)
(node:48367) Warning: Accessing non-existent property 'findOne' of module exports inside circular dependency
(node:48367) Warning: Accessing non-existent property 'remove' of module exports inside circular dependency
(node:48367) Warning: Accessing non-existent property 'updateOne' of module exports inside circular dependency
Example app listening on port 8080!
{ name: 'Ankit', character: 'Light Yagami' }

```

- Add shark screen

![](../../images/coding-tasks/task-002-nodejs-mongo-docker/add-shark-screen.png)

- After adding shark

![](../../images/coding-tasks/task-002-nodejs-mongo-docker/after-adding-shark.png)