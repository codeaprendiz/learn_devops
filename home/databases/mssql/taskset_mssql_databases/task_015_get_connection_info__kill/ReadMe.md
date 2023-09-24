# Get Connection Information

## 1. The `SELECT` Statement

```sql
SELECT spid, [status], [loginame], hostname, blocked, db_name(dbid) as database_name
FROM sys.sysprocesses
WHERE dbid = DB_ID('SQLTestDB');
```

**Purpose**: This query retrieves information about all the processes (or sessions) that are currently connected to the `SQLTestDB` database.

**Columns**:

- `spid`: System process ID. It's a unique identifier for each active process in SQL Server.
- `[status]`: The status of the process (e.g., "running", "sleeping", etc.).
- `[loginame]`: The name of the user who initiated the process.
- `hostname`: The name of the computer from which the user is connecting.
- `blocked`: If this process is being blocked by another process, this column will show the `spid` of the blocking process. If it's not blocked, it will show `0`.
- `db_name(dbid) as database_name`: This translates the database ID (`dbid`) into the actual database name. In this case, it will always show `SQLTestDB` because of the `WHERE` clause.

## 2. The `KILL` Statements

```sql
KILL 58;
KILL 69;
```

**Purpose**: These commands terminate the processes with the specified `spid` values. In this case, it's terminating the processes with `spid` values of `58` and `69`.

### Explanation

The script is used to first identify all the processes connected to the `SQLTestDB` database. Once you have that list, you can decide which processes to terminate. The `KILL` commands are then used to forcefully terminate specific processes. This can be useful in scenarios where you need to perform maintenance on a database and want to ensure no active connections are using it, or if there are problematic or long-running queries that you need to stop.

### Sample Table Output

Imagine the `SELECT` query returned the following table:

| spid | status  | loginame | hostname      | blocked | database_name |
|------|---------|----------|---------------|---------|---------------|
| 58   | running | sa       | X-MacBook-Pro | 0       | SQLTestDB     |
| 69   | running | user2    | PC2           | 58      | SQLTestDB     |

From the table:

- The process with `spid` `58` is running, initiated by `sa` from `X-MacBook-Pro`, and is not being blocked by any other process.
- The process with `spid` `69` is running, initiated by `user2` from `PC2`, and is being blocked by the process with `spid` `58`.

The `KILL` commands then terminate these two processes.
