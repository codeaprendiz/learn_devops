# Stored Procedures

- [learn.microsoft.com » Stored Procedures](https://learn.microsoft.com/en-us/sql/relational-databases/stored-procedures/stored-procedures-database-engine?view=sql-server-ver16)

A **Stored Procedure** in SQL is a precompiled collection of one or more SQL statements that can be executed as a single unit of work. Stored procedures are stored in the database data dictionary and can be invoked by applications or users to encapsulate logic, perform an action, and optionally return a value.

<br>

## Key Characteristics of Stored Procedures

1. **Precompiled**: Once created, stored procedures are compiled and stored in the database, which can reduce the overhead of compiling the SQL code every time it is executed.

2. **Parameterized**: Stored procedures can accept parameters, allowing them to be dynamic and adaptable to various scenarios and inputs.

3. **Encapsulation**: They encapsulate a series of SQL statements, abstracting the complexity from the end-user or application and ensuring that the logic is executed consistently.

4. **Reusable**: Stored procedures can be called multiple times with different parameters, promoting code reusability.

5. **Security**: They can be used to provide an additional layer of security by restricting direct access to the underlying data tables. Users can be granted permission to execute a stored procedure without having direct access to the underlying tables.

6. **Transactional**: Stored procedures can utilize transactions, ensuring data consistency by committing or rolling back changes in the event of errors.

<br>

## Basic Syntax

Here's a basic syntax example of a stored procedure in SQL Server:

```sql
CREATE PROCEDURE [SchemaName].[ProcedureName]
    @Parameter1 DataType,
    @Parameter2 DataType
AS
BEGIN
    -- SQL statements to be executed
END;
```

<br>

### Example:

Here's a simple example of a stored procedure that retrieves data based on a parameter:

```sql
CREATE PROCEDURE dbo.GetEmployeeDetails
    @EmployeeID INT
AS
BEGIN
    SELECT * FROM Employees WHERE EmployeeID = @EmployeeID;
END;
```

To call this stored procedure and retrieve data for a specific employee, you would use the following SQL:

```sql
EXEC dbo.GetEmployeeDetails @EmployeeID = 123;
```

<br>

### Use Cases

- **Data Validation**: Ensure data consistency and accuracy by using stored procedures to validate and process data before it is inserted or updated in the database.

- **Business Logic**: Implement and centralize business logic in the database layer, ensuring consistency across all applications that access the data.

- **Data Retrieval**: Create stored procedures to retrieve data in a specific format or based on particular criteria, abstracting query complexity from the application layer.

- **Security**: Use stored procedures to provide controlled, secure access to data by limiting direct table access and exposing only necessary operations.

Stored procedures can be a powerful tool in database management, helping to streamline data operations, enhance security, and simplify application development by centralizing database logic.

---

<br>

## Example with Employees Table

Let's create an example following best practices:

<br>

### Step 1: Create a Database

We create a new database named `CompanyDB`.

```sql
-- check default schema
SELECT SCHEMA_NAME()

--- switch to master
PRINT '...Switching to master';
USE [master];
GO

-- Create a new database named 'CompanyDB'
CREATE DATABASE CompanyDB;
GO  -- Execute the previous batch.
```

<br>

### Step 2: Use the Created Database

We switch to using the `CompanyDB` database for subsequent SQL statements.

```sql
-- Switch to using the 'CompanyDB' database
USE CompanyDB;
GO  -- Execute the previous batch.
```

<br>

### Step 3: Create the `Employees` Table

We create a table named `Employees` in the `dbo` schema of the `CompanyDB` database.

```sql
-- Create a new table named 'Employees' in the 'dbo' schema
CREATE TABLE dbo.Employees (
    EmployeeID INT PRIMARY KEY,  -- Primary key column
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Position NVARCHAR(50)
);
```

<br>

### Step 4: Insert Sample Data into the `Employees` Table

We insert some sample data into the `Employees` table to work with.

```sql
-- Insert sample data into the 'Employees' table
INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, DateOfBirth, Position)
VALUES 
    (1, N'John', N'Doe', '1990-01-01', N'Developer'),
    (2, N'Jane', N'Doe', '1992-02-02', N'Analyst'),
    (3, N'Jim', N'Beam', '1985-03-03', N'Manager');
```

<br>

### Step 5: Create the Stored Procedure

We create a stored procedure named `GetEmployeeDetails` in the `dbo` schema. This stored procedure retrieves data from the `Employees` table based on the `@EmployeeID` parameter.

```sql
-- Create a new stored procedure named 'GetEmployeeDetails' in the 'dbo' schema
CREATE PROCEDURE dbo.GetEmployeeDetails
    @EmployeeID INT
AS
BEGIN
    -- Retrieve data from the 'Employees' table based on the input parameter
    SELECT * FROM dbo.Employees WHERE EmployeeID = @EmployeeID;
END;
```

<br>

### Usage Example

To use the stored procedure to retrieve details for a specific employee, you would execute the stored procedure with the desired parameter:

```sql
-- Use the 'CompanyDB' database
USE CompanyDB;
GO  -- Execute the previous batch.

-- Execute the stored procedure with 'EmployeeID' set to 1
EXEC dbo.GetEmployeeDetails @EmployeeID = 1;
```

<br>

### Note

Ensure that you have the necessary permissions to create databases, tables, and stored procedures in your SQL Server environment. Always test scripts in a safe and recoverable environment before applying them to production databases.
