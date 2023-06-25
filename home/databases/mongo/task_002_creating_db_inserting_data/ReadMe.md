### Creating new database


```
> show dbs
admin  0.000GB
local  2.576GB
> use newdb1
switched to db newdb1
> db.user.insert({name: "test", age: 205})
WriteResult({ "nInserted" : 1 })
> show dbs
admin   0.000GB
local   2.605GB
newdb1  0.000GB
```
