![](https://raw.githubusercontent.com/microsoft/sqlworkshops/master/graphics/microsoftlogo.png)
# Workshop: SQL database in Microsoft Fabric

## Application Lifecycle Management

#### A Microsoft Workshop from the SQL Server Team

In this module, you will learn about managing the lifecycle of your application using source control. You will also learn how to monitor and maintain your SQL database in Fabric.

You'll cover these topics in this module:

1. [Checking our database into source control.](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/05%20-%20Application%20Lifecycle%20Management/05%20-%20Application%20Lifecycle%20Management.md#51-source-control-for-your-database-and-other-fabric-objects)
2. [Deployments for SQL database in Fabric](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/05%20-%20Application%20Lifecycle%20Management/05%20-%20Application%20Lifecycle%20Management.md#52-deployments-for-sql-database-in-fabric)

### 5.1 Source control for your database (and other Fabric objects)

Make sure that you have a Git repository set up in Azure DevOps or GitHub as mentioned in the [pre-requisites](../00%20-%20Pre-Requisites/00%20-%20Pre-Requisites.md).

Once you have completed these prerequisites, you can keep your workspace synced with the Git branch through the bi-directional actions available with the Fabric git integration. This allows you to commit changes from your database to source control, edit database objects in VS Code, and update your database from the contents of source control.

Before we can exchange contents between our Fabric workspace and source control, we need to set up a connection between the two. This is done by updating the settings on our workspace in Fabric to connect it to a specific branch on a Git repository. If you get stumped during this setup, check out the walkthrough in the [Fabric documentation](https://learn.microsoft.com/en-us/fabric/cicd/git-integration/git-get-started).

1. In your Fabric workspace, select **Workspace settings** in the top right corner.
1. In the **Workspace settings** pane, select the **git integration** tab.
1. Attach your account to the source control provider you want to use under **Connect git provider and account**. For Azure DevOps, this requires you to sign in to your Azure DevOps account. For GitHub, you will need to sign in to your GitHub account with a personal access token.
1. Associate the workspace with a repository and branch under **Connect git repository and branch**. For Azure DevOps, you will have to select the organization, project, repository, and branch. For GitHub, you will have to select the repository and branch.
1. Optionally, you can nest your Fabric objects under a specific folder in the repository by selecting a folder under **Repository folder**. This option is helpful if you want to combine objects from multiple workspaces or objects from Azure in the same repository.
1. Select **Connect and sync** to complete the setup.

Once setup, the initial sync will commit the contents of your workspace to the Git repository. This includes all the source control integration compatible objects in your workspace, such as databases and notebooks. The process may take a few minutes. Once this completes, the source control repository will contain a copy of the definition of the objects. For your SQL database, this includes the schema, tables, views, and stored procedures - but not the data.

#### Activity: Commit changes from your database to source control

When we synced our workspace with source control, we committed the initial state of the database to the repository. Now we will make a change to the database and commit it to source control.

1. From your Fabric workspace, select your SQL database and open it to launch the Fabric query editor.
1. From the query editor, run the following T-SQL code to create a new table in the database:

```sql
CREATE TABLE [sessions_feedback]
(
    [id] INT DEFAULT (NEXT VALUE FOR [global_id]) NOT NULL,
    [session_id] INT NOT NULL,
    [session_score] INT NOT NULL,
    [speaker_score] INT NOT NULL,
    [comment] NVARCHAR(500) NULL,

    PRIMARY KEY CLUSTERED ([id] ASC)
);
GO;
```

1. In your Fabric workspace, select the ellipsis menu next to the SQL database name and select **Refresh git sync status** If this menu item is not available, your database is automatically reporting changes.
1. In your Fabric workspace, select the **Source control** button in the top right corner to open the source control panel. The default view, **Changes**, shows the changes that have been made to the workspace since the last commit. Your database object should be listed here.
1. Select the checkbox for the database object and enter a commit message in the text box at the bottom of the panel. Click **Commit** to commit the changes to the repository.
1. After a few minutes when the commit is complete, select the branch name link at the top of the **Source control** panel to open the repository in Azure DevOps or GitHub. 
1. Navigate through the file structure in GitHub or Azure DevOps to `<yourdatabase>/dbo/Tables/sessions_feedback.sql`. You should see the new table definition in the repository.

#### Activity: Edit database objects in VS Code

Database development can take place in a variety of tools, but for this workshop, we will use Visual Studio Code (VS Code) with the SQL Database Projects extension. This extension provides a lightweight database development environment for SQL databases, allowing you to manage database objects and interact with source control. Offline development of database objects is complementary to the Fabric query editor, which provides a live connection to the database and changes are immediately applied. With offline development, you can make changes to the database schema, tables, views, and stored procedures and use source control to review and collaborate on the changes.

1. From your source control repository in Azure DevOps or GitHub, clone the repository to your local machine.
    1. If you're using Azure DevOps, select the `...` context menu for the source control project. Select **Clone** to copy your Azure DevOps repository to your local machine. If you're new to Azure DevOps, see the [Code with git](/azure/devops/user-guide/code-with-git) guide for Azure DevOps.
    1. If you're using GitHub, select the **Code** button in the repository and copy the URL to clone the repository to your local machine. If you're new to GitHub, see the [cloning a repository](https://docs.github.com/repositories/creating-and-managing-repositories/cloning-a-repository) guide.
1. Open the cloned folder in VS Code. The branch associated with your workspace may not be the default. You should see a folder named `<yourdatabase>.SQLDatabase` as well as other Fabric object folders in VS Code and may need to switch the branch.
1. Locate and open the `sessions_feedback.sql` file in the `dbo/Tables` folder. This file contains the definition of the table you created in the Fabric query editor.
1. Modify the table definition by changing the `comment` column to `NVARCHAR(MAX)`, adding a column for `review_time`, and adding a foreign key on `session_id`. The modified table definition should look like this:

```sql
CREATE TABLE [sessions_feedback]
(
    [id] INT DEFAULT (NEXT VALUE FOR [global_id]) NOT NULL,
    [session_id] INT NOT NULL,
    [session_score] INT NOT NULL,
    [speaker_score] INT NOT NULL,
    [comment] NVARCHAR(MAX) NULL,
    [review_time] DATETIME2 NOT NULL,

    PRIMARY KEY CLUSTERED ([id] ASC),
    FOREIGN KEY ([session_id]) REFERENCES [sessions] ([id])
);
GO;
```

1. Save the file. Before we commit our changes to source control, we will use the SQL Database Projects extension to validate the database model. Running the build action with SQL projects not only validates the SQL syntax, is also creates a DACPAC file from the database project. This file contains the schema of the database and can be used to deploy the database to other environments. To build the project, switch to the **Database Projects** view in VS Code. Right-click the project and select **Build**.
1. Once the successful build completes, you can commit the changes to source control. Switch back to the **Source control** view in VS Code. You should see the changes you made to the `sessions_feedback.sql` file. Enter a commit message and click the **Commit** button.
1. To copy your local changes to the remote repository in Azure DevOps or GitHub, we will push the changes from VS Code. Click the **...** context menu in the **Source control** view and select **Push**. This action will copy your local changes to the remote repository.
1. From the Azure DevOps or GitHub repository, you can see the changes you made to the `sessions_feedback.sql` file. Source control repository hosting services like Azure DevOps and GitHub provide a history of changes to the file, allowing you to review the changes made by you and others.

#### Activity: Update your database from the contents of source control

In the previous activity we updated the database schema in VS Code and committed the changes to source control. This modified the SQL project database definition, but it did not modify the database in Fabric. Now we will update the database in Fabric from the contents of source control.

1. In the Fabric workspace, select the **Source control** button in the top right corner to open the source control panel.
1. The view may automatically switch to **Updates**, where you can see that the SQL database has an update pending. If it does not, select the **Updates** view. Click the **Update all** button at the bottom of the view to apply the changes from source control to the database. This update will automatically calculate and execute the T-SQL script to bring the database schema in line with the source control definition.
1. After a few minutes the deployment of changes from source control will have completed. The Source control panel will show pending changes from the database to be committed to source control. These changes are a result of the source control comparison being an exact string comparison between the source control integration and the SQL project we modified in source control. **Commit** these changes to source control to complete the round trip with a commit message noting that these are sync back changes.
1. From the Fabric workspace, open the SQL query editor for the SQL database. Locate the `sessions_feedback` table in the object explorer and select **Script as Create** from the context menu. This will generate the T-SQL script to create the table that will contain the foreign key, `review_time` column, and the `comment` column as `NVARCHAR(MAX)`.

### 5.2 Deployments for SQL database in Fabric

When development processes are centered on a single database, the deployment process can be straightforward. However, when multiple developers are working on the same database, or when the database is part of a larger application, the importance of creating multiple environments for development/testing/production increases. With more complex environment arrangements, it is important to have a repeatable and reliable deployment process that can be automated.

SQL database in Fabric is part of the larger Fabric platform, which includes deployment pipelines for deploying changes between workspaces. In addition, because the native format for a SQL database in Fabric is a SQL database project, you can leverage the SqlPackage command-line utility to extract and publish `.dacpac` files.  These files can be used to deploy changes to between environments and are part of a shared ecosystem of DevOps tooling for SQL Server and Azure SQL Database.

#### Activity: Compare and update your database with Fabric deployment pipelines

The workspace we've been working in is our development environment, and we'd like to create a test environment to validate changes before they are deployed to production. We might be inviting additional team members to have access to the test environment for assistance in reviewing or validating changes. We will use Fabric deployment pipelines to apply changes from our development workspace to a new test workspace.

1. Create a new Fabric workspace with the name `<yourusername> Sessions Finder Test`. See [section 1.1](../01%20-%20Introduction%20and%20Getting%20Started/01%20-%20Introduction%20and%20Getting%20Started.md#11-creating-a-workspace) for instructions on creating a new workspace.
1. From your original workspace, `<yourusername> Sessions Finder`, select the **Create deployment pipeline** button in the upper right corner.
1. Name the deployment pipeline `<yourusername> Sessions Finder`.
1. In the following step you are presented with the default deployment pipeline layout, which includes `Development`, `Test`, and `Production` stages. Each stage can be associated with a workspace, and the deployment pipeline will automatically deploy changes between the workspaces. We will focus on the `Development` and `Test` stages in this activity but we don't have to modify this template. Click **Create and continue**.
1. We will assign our two workspaces to the `Development` and `Test` stages. Select the `Development` stage and assign the `<yourusername> Sessions Finder` workspace. Select the `Test` stage and assign the `<yourusername> Sessions Finder Test` workspace. During this process you will receive a warning that the workspace includes unsupported items, which is expected and will not impact the ability to test our application in the test workspace.
1. With the `Test` stage of the deployment pipeline selected, multiple objects will be listed as "Only in source" including our SQL database. Select all objects in the list and click **Deploy** from Development to Test.
1. In the **Deploy to this stage** dialog, provide a note about the deployment such as "creating test environment". Select **Deploy** to start the deployment of the objects to the test workspace. When this process completes after a few minutes multiple objects will have been created in the test workspace with a copy of their definition from the development workspace.
1. Open the test workspace in Fabric and select the SQL database to open the Fabric query editor. Expand the object explorer to verify that the tables and stored procedures from our development environment were created. The data in this database is separate from the data in the development environment and the tables will start empty.
1. One of the challenges of having multiple environments is quickly moving changes from development environments over to test/staging environments for further review. We're going to make a change in the original workspace and easily apply it to our test workspace database. From the Fabric query editor in the original (`<yourusername> Sessions Finder`) workspace, open a new query window. Add a column to the `speaker_profiles` table for capturing DietaryRestrictions by executing the following T-SQL.

```sql
ALTER TABLE speaker_profiles ADD DietaryRestrictions NVARCHAR(MAX)
```

1. Now that we have modified our development environment, we will use the deployment pipeline to review the differences between the development and test workspaces.
1. With the Test environment selected in the deployment pipeline, the SQL database is listed as having differences. Select the checkbox for the SQL database and click **Deploy** from Development to Test.
1. When the deployment completes, navigate to the Fabric workspace `<yourusername> Sessions Finder Test`  (test workspace) and open the table definition for `speaker_profiles`. The table should include the `DietaryRestrictions` column that you recently added.

With deployment pipelines in place, you can review and apply changes between workspaces. Use of deployment pipelines easily coexists with use of the source control integration. For example, we will commit the new column to our git repository from the development workspace.

1. In your development Fabric workspace (`<yourusername> Sessions Finder`), select the ellipsis menu next to the SQL database name and select **Refresh git sync status** If this menu item is not available, your database is automatically reporting changes.
1. In your development Fabric workspace (`<yourusername> Sessions Finder`), select the **Source control** button in the top right corner to open the source control panel. The default view, **Changes**, shows the changes that have been made to the workspace since the last commit. Your database object should be listed here.
1. Select the checkbox for the database object and enter a commit message for the DietaryRestrictions column in the text box at the bottom of the panel. Click **Commit** to commit the changes to the repository.

#### Activity: Publish a dacpac with SqlPackage

Use of SqlPackage with SQL database in Fabric does not conflict with using the Fabric deployment pipelines or source control integration. In this activity, we will use VS Code to modify our database code before deploying changes to each workspace.

1. Open VS Code and the source control folder we cloned in [Edit database objects in VS Code](#activity-edit-database-objects-in-vs-code). Update the code on your workstation by pulling the latest in source control. From VS Code click the **...** context menu in the **Source control** view and select **Pull**. This action will update your local files with any changes available in the source control repository in Azure DevOps or GitHub.
1. The database change we want to make is to remove the unique constraint from the `full_name` column and add a named non-clustered index on the column. Open the `speakers.sql` file and modify the contents to match the following:

```sql
CREATE TABLE [dbo].[speakers] (
    [id]                        INT              DEFAULT (NEXT VALUE FOR [global_id]) NOT NULL,
    [external_id]               VARCHAR (100)    COLLATE Latin1_General_100_BIN2 NULL,
    [full_name]                 NVARCHAR (100)   NOT NULL,
    [require_embeddings_update] BIT              DEFAULT ((0)) NOT NULL,
    [embeddings]                VARBINARY (8000) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IX_speakers_full_name]
    ON [dbo].[speakers]([full_name] ASC);


GO

;

-- Create a trigger for speakers
create   trigger GetSpeakerEmbeddingsOnInsert
on speakers
after insert
as

declare speaker_cursor cursor FAST_FORWARD READ_ONLY

for select id, full_name from inserted
order by id

set nocount on;

declare @id int, @full_name NVARCHAR(100),  @message NVARCHAR(max)

open speaker_cursor

fetch next from speaker_cursor
INTO @id, @full_name

while @@FETCH_STATUS = 0
begin

   declare @retval int, @embedding VARBINARY(8000);
  -- Call the get_embedding stored procedure to retrieve an abstract embedding
  exec @retval = get_embedding @full_name, @embedding OUTPUT

  -- Call the update_speaker_embeddings stored procedure to update the session embeddings
  exec @retval = update_speaker_embeddings @id, @embedding

  fetch next from speaker_cursor
INTO @id, @full_name

end
close speaker_cursor
deallocate speaker_cursor;

GO

```

1. Build the SQL project from the **Database Projects** view in VS Code, a step that both validates the SQL syntax and creates the `.dacpac` artifact for deploying our changes.
1. To use the SqlPackage dotnet tool we will install it from the terminal in VS Code. In the **View** menu of VS Code, select **Terminal** to open the terminal view. Enter into the terminal `dotnet tool install -g microsoft.sqlpackage`.
1. In the file explorer view in VS Code, navigate to the SQL database folder and locate the `.dacpac` file under the `bin/Debug` folders. Right-click the **Debug** folder and select **Open in Integrated Terminal**.
1. In the development Fabric workspace (`<yourusername> Sessions Finder`), open the SQL database context menu and select **Settings**. Under **Connection strings** locate and copy the *ADO.NET* connection string. The connection string would appear similar to `Data Source=reallylonguniquestring.database.fabric.microsoft.com,1433;Initial Catalog="Sessions_database-really-long-string";Multiple Active Result Sets=False;Connect Timeout=30;Encrypt=True;Trust Server Certificate=False;Authentication=Active Directory Interactive`.
1. From the newly opened terminal instance, type in the SqlPackage CLI command to run a `.dacpac` deployment with the connection string pasted in as the `TargetConnectionString`. Hit enter after closing the quotation marks to begin the deployment.

```bash
sqlpackage /Action:Publish /SourceFile:Sessions_database.dacpac /TargetConnectionString:"pasteconnectionstringhere"
```

1. When the deployment begins, a browser window will prompt for your Azure AD login. Select the account that is associated with the Fabric workspace. After authenticating, the deployment will begin and the terminal will show the progress of the deployment including summarized deployment steps. The two steps in the deployment are `Dropping Unique Constraint unnamed constraint on [dbo].[speakers]` and `Creating Index [dbo].[speakers].[IX_speakers_full_name]`.
1. After about 30 seconds, your deployment to the development database will have completed. If you visit the Fabric query editor for the SQL database, you can see the changes to the `speakers` table. The unique constraint on the `full_name` column has been removed and a named non-clustered index has been added to the column.
1. Repeat the deployment for the test database by changing the `TargetConnectionString` to the connection string for the test database. The deployment will be similar to the development deployment.
1. For completeness, commit the changes to source control. We are checking in the altered `speakers.sql` file but not the `.dacpac` file. The `.dacpac` file is a build artifact and can be regenerated from the `.sql` files. In the **Source control** view in VS Code, select the plus sign for the `speakers.sql` file and enter a commit message. Click **Commit** to commit the changes to the repository. Push the changes to the remote repository by selecting the **...** context menu in the **Source control** view and selecting **Push**.


---

Congratulations! You have completed this module on application lifecycle management for SQL database in Microsoft Fabric.  Finally, take a peek at how SQL database in Microsoft Fabric supports [developer-friendly performance investigations.](https://github.com/akatesmith/SQL-database-in-Fabric-Workshop/blob/main/sqldev/06%20-%20Performance%20Monitoring/06%20-%20Performance%20Monitoring.md)

---
