![](https://raw.githubusercontent.com/microsoft/sqlworkshops/master/graphics/microsoftlogo.png)
# Workshop: SQL database in Microsoft Fabric

## Create a Simple Application Using GraphQL API Builder

#### A Microsoft Workshop from the SQL Server Team

In this module, you will learn how to create a simple application on top of a stored procedure using the GraphQL API builder within Fabric.

You'll cover these topics in this module:

1. [Create a Stored Procedure that Leverages Embedding Generation for Similarity Search](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/04%20-%20Create%20a%20simple%20application/04%20-%20Create%20a%20simple%20application.md#41-create-a-stored-procedure-that-leverages-embedding-generation-for-similarity-search)
2. [Create a Simple JavaScript Application to Search for Sessions on a Given Theme Using the GraphQL API Builder](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/04%20-%20Create%20a%20simple%20application/04%20-%20Create%20a%20simple%20application.md#42-generate-an-application-using-fabrics-graphql-api-builder)

### 4.1 Create a Stored Procedure that Leverages Embedding Generation for Similarity Search

SQL database now supports vector similarity search functionality. This means it can compare embeddings to determine the distance between two strings using cosine similarity. You will leverage that functionality to create a function that, given a string, will search the existing sessions and return the most similar.

#### Activity: Create Find_sessions Stored Procedure

1. Open up and examine [`Find Sessions.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/04%20-%20Create%20a%20simple%20application/14%20-%20Find%20Sessions.sql). This stored procedure takes as an input whatever string you give it and searches the database for sessions similar to the provided search string.
2. Go ahead and create the stored procedure.
3. Now, try running it with a few things to see what kind of results you get:

```sql
exec find_sessions 'ecology'
```

```sql
exec find_sessions 'technology and community'
```

### 4.2 Generate an Application Using Fabric's GraphQL API Builder

One thing to note is that you could write a C# application that directly calls `find_sessions` and parse the results appropriately for output. However, for GraphQL, you need to do something different. This is because GraphQL does not support extended stored procedures - either called directly or indirectly - when generating GraphQL endpoints. The `invoke-external_rest_endpoint` call in `get_embedding` disqualifies `find_sessions` for direct GraphQL support.

To accommodate this, you will create a wrapper around `find_sessions` that defines the result set. Go ahead and run [`Find Sessions Wrapper.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/04%20-%20Create%20a%20simple%20application/15%20-%20Find%20Sessions%20Wrapper.sql) to create this GraphQL-compatible stored procedure.
```sql
-- Calling find_sessions and defining the result set
-- This is needed for GraphQL API because 
-- Find_sessions calls an extended stored procedure
-- and so you need to define what the results will look like.
create or alter   procedure [find_sessions_wrapper]
@text nvarchar(max)

as 

exec find_sessions @text

with RESULT SETS
(
(id INT,
title NVARCHAR(200),
abstract NVARCHAR(MAX),
external_id VARCHAR(100),
start_time datetime2(0),
end_time datetime2(0),
recording_url varchar(1000),
speakers nvarchar(max),
distance float)
)
```

#### Next step: Use GraphQL API Builder to create an application

Now that you have defined `Find_sessions_wrapper`, you can generate some code and build our application.

1. Go back to your Fabric workspace. Select **New Item** and select **API for GraphQL**.
2. Name it `find_sessions_wrapper`.
3. Select a data source - **connect to Fabric data sources.**
4. Select your SQL database - not the analytics endpoint.
5. Expand the stored procedures folder, select `find_sessions_wrapper`, check the checkbox, and click **Load**.
6. In the schema explorer, expand queries. You should see find_sessions_wrapper.
7. Now copy-paste the following into the editor on the right:

```
query{
    executefind_sessions_wrapper (text: "artificial intelligence") {
       title,
       abstract
    }
}
```

and click **Run** to execute the query.

9. Now, enter a sample text - something you'd like to find sessions about - into the input string, and run the query to see sample results. I also have cleaned up what I want returned - just looking for the titles of sessions is enough for me.
10. At the top of the screen, select **Generate code**. In this window, select Node.js, and select **Copy**.
11. On your machine, create a folder called `FindSessionsProgram` and create a new file called `findsessions.mjs`. Paste the code into this file and save it.
13. You can see that this program requires authentication via `@azure/identity`. So, you need to create a project and install that dependency.

    1. In the command line in this folder, type:

    ```console
    npm init
    ```

    This will create a new `package.json` file.

    2. Type:

    ```console
    npm add @azure/identity
    ```

    to install the authentication package.

14. Edit the `package.json` file to add a script named `app` which maps to `node findsessions.mjs`.

15. Run the app with:

    ```console
    npm run app
    ```

    This will search for sessions using the hardcoded string.

The sample I have included has two other modifications:

1. JSON printer formatting.
2. I also used the `prompt-sync` package to request and use the input from the console for what you are searching to find. Make sure you:

    ```console
    npm add prompt-sync
    ```

    to install that as well.

With these modifications, you now have a program that asks what kind of sessions it should find, and then returns the matching sessions as appropriate. Try all kinds of inputs - technical sessions, inspiring sessions, sessions about underwater basket weaving - see what comes back!


---

Congratulations! You have now created a simple console application that connects to your SQL database via GraphQL and returns the results of `find_sessions` - allowing you and others to find sessions on topics that interest them.  Now, it is time to productize what you have built by incoporating best practices for [Application Lifecyle Management](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/05%20-%20Application%20Lifecycle%20Management/05%20-%20Application%20Lifecycle%20Management.md).

---
