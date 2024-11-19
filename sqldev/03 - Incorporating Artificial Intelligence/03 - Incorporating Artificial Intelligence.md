![](https://raw.githubusercontent.com/microsoft/sqlworkshops/master/graphics/microsoftlogo.png)
# Workshop: SQL database in Microsoft Fabric

## Incorporating Artificial Intelligence

#### A Microsoft Workshop from the SQL Server Team

### Native Integration with Other Services

In this module, you will deploy an instance of Azure OpenAI with the appropriate model, connect your database to it, and use that to generate embeddings that can be used for similarity search.

You'll cover these topics in this module:

1. [Create an Instance of Azure OpenAI and Deploy the Appropriate Model](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/03%20-%20Incorporating%20Artificial%20Intelligence.md#31-deploy-azure-openai)
2. [Configure Your SQL Database to Leverage Your Azure OpenAI Endpoint to Generate Embeddings](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/03%20-%20Incorporating%20Artificial%20Intelligence.md#32-configure-your-sql-database-in-fabric-to-connect-to-azure-openai)
3. [See SQL's Vector Database Support in Action, as You Generate Embeddings to Be Used for Similarity Search](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/03%20-%20Incorporating%20Artificial%20Intelligence.md#33-generate-embeddings-for-existing-data-and-set-up-triggers-for-new-inserts)

#### References
You may find the material in [this blog](https://devblogs.microsoft.com/azure-sql/whats-a-vector-anyway/) to be a useful explaination of vector databases.

### 3.1 Deploy Azure OpenAI

#### Activity: Deploy Azure OpenAI with the Appropriate Model

To integrate our application with Azure OpenAI, you have to deploy and configure it for our application.

**Description**

1. Go to your Azure portal and create a new resource group called **<YourName>_SessionsAI**.  (*Replace YourName with your name or user name.*)

2. Select the create button at the top, search for "OpenAI" and select **Azure OpenAI**.
3. Select **Create**.
4. On this screen, configure the subscription and your resource group, as well as your region. Select your region based on the availability of `text-embedding-ada-002`. [Consult the documentation](https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models?tabs=python-secure%2Cglobal-standard%2Cstandard-chat-completions#global-standard-model-availability) to find available regions.
   Then, set the **Name** to be **OpenAIForSessionsDatabase**. Select your pricing tier, and hit **Next**.
5. Allow all networks and the internet to use this resource.
6. Select **Next** until you validate, and then hit **Create**. It will take some time for this item to be created.
7. Once created, you can navigate to this from your resource group.
8. You can see your endpoints and keys. Copy your end point and one of your keys into Notepad.  You will use these later.
9. Navigate back to the overview, and select **Go to Azure OpenAI Studio**. Continue to the Studio.
10. In **Model catalog** you should select **Text-embedding-ada-002**.
11. On the next screen, select **Deploy**, then **Deploy**.

You have now deployed the appropriate model for OpenAI for us to use with our database.

### 3.2 Configure Your SQL Database in Fabric to Connect to Azure OpenAI

In order to leverage Azure OpenAI with your SQL database, you will need to create a credential so that the database can authenticate. Then, it's as simple as making a few calls to get appropriate embeddings.

1. Open the query editor window, and copy-paste the text from [`04 Create Credential.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/04%20-%20Create%20Credential.sql) into the window. Insert the endpoint and keys that you set aside in the previous step into the endpoint and key values in the T-SQL script, then run it.
   ```sql
   -- To create a credential, you need to create a master key.
   if not exists(select * from sys.symmetric_keys where [name] = '##MS_DatabaseMasterKey##')
   begin
    create master key encryption by password = N'V3RYStr0NGP@ssw0rd!';
    end
    go

    -- Copy and paste the endpoint into this credential. 
    -- A sample endpoint would look like: "https://<something goes here>.openai.auzre.com"
    create database scoped credential [<ENDPOINT>]
    -- Copy and paste the key from the open ai manager and paste it directly here.
    with identity = 'HTTPEndpointHeaders', secret = '{"api-key":"<KEY>"}';
    go

    CLOSE Master key;
    ```
2. Next, let's create a function that calls into OpenAI to get an embedding.
Copy and paste the text from [`05 Get Embedding.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/05%20-%20Get%20Embedding.sql) into an editor window and, again, copy/paste your endpoint into the URL and credential fields.

   ```sql
   
   create or alter procedure [get_embedding]
   @inputText nvarchar(max),
   @embedding varbinary(8000) output
   as
   begin try
      declare @retval int;
      declare @payload nvarchar(max) = json_object('input': @inputText);
      declare @response nvarchar(max)
      exec @retval = sp_invoke_external_rest_endpoint

       -- Endpoint like: https://<something>.openai.azure.com
       @url = '<ENDPOINT>/openai/deployments/text-embedding-ada-002/embeddings?api-version=2023-05-15',
       @method = 'POST',

       -- The name of the credential you already created
       @credential = [<ENDPOINT>],
       @payload = @payload,
       @response = @response output;
   end try
   begin catch
       select 
         'SQL' as error_source, 
          error_number() as error_code,
          error_message() as error_message
    return;
    end catch

     if (@retval != 0) begin
        select 
        'OPENAI' as error_source, 
        json_value(@response, '$.result.error.code') as error_code,
        json_value(@response, '$.result.error.message') as error_message,
        @response as error_response
       return;
     end;

      declare @re nvarchar(max) = json_query(@response, '$.result.data[0].embedding')
      set @embedding = json_array_to_vector(@re);

       return @retval
      go
   ```

3. You can test it by running the code in [`06 Get Embedding Sample.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/06%20-%20Get%20Embedding%20Sample.sql).

   ```sql
   Declare @retval int, @embedding varbinary(8000);

   -- With this call, you are generating an embedding for the word "nature".  
   -- The embedding is passed out into the @embedding variable   
   EXEC @retval = get_embedding 'nature', @embedding OUTPUT;

   -- The embedding is just raw binary - but you can see that you got something.
   select @embedding
   ```

### 3.3 Generate Embeddings for Existing Data, and Set Up Triggers for New Inserts

1. The following table outlines the next set of SQL scripts and what they do. You can run one at a time, and you can also reference [`this notebook`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/Create%20Vector%20Supported%20Objects.ipynb) to see them laid out nicely. For reference on notebooks in VS Code, you can also see [`this blog`](https://devblogs.microsoft.com/dotnet/net-interactive-with-sql-net-notebooks-in-visual-studio-code/).

| Script | Function |
|--------|----------|
| [`07 - Update embeddings.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/07%20-%20Update%20Embeddings.sql) | Creates procedures to update session and speaker embeddings, respectively. |
| [`08 - Update All Speakers.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/08%20-%20Update%20All%20Speakers.sql) | Generates and stores embeddings for all speakers requiring an embeddings update. |
| [`09 - Update All Sessions.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/09%20-%20Update%20All%20Sessions.sql) | Generates and stores embeddings for all sessions requiring an embeddings update. |
| [`10 - Generate Initial Embeddings.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/10%20-%20Generate%20Initial%20Embeddings.sql) | Updates all speakers and sessions currently in the database requiring session updates. |
| [`11a - Create Sessions Trigger.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/11a%20-%20Create%20Sessions%20Trigger.sql) | Creates a trigger that will cause all newly inserted rows in the `sessions` table to get automatically updated with embeddings. |
| [`11b - Create Speakers Trigger.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/11b%20-%20Create%20Speakers%20Trigger.sql) | Creates a trigger that will cause all newly inserted rows in the `speakers` to get automatically updated with embeddings. |

2. Having done this, you can select rows from either table to see that embeddings have been generated.
3. Next, insert some new sessions into the database by executing [`12 - Insert More Sessions.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/12%20-%20Insert%20More%20Sessions.sql). Embeddings should automatically be updated for these new rows. (*Note: this data was generated by AI*)
4. Finally, you can check this by running [`13 - Confirm Embedding Updates.sql`](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/03%20-%20Incorporating%20Artificial%20Intelligence/13%20-%20Confirm%20Embedding%20Updates.sql).

---

Congratulations! You have completed this module on creating and integrating artificial intelligence within your SQL database in Fabric. Now that you have these objects created, it is time to move on to the next section - [Building a simple application with GraphQL](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/04%20-%20Create%20a%20simple%20application/04%20-%20Create%20a%20simple%20application.md).

---
