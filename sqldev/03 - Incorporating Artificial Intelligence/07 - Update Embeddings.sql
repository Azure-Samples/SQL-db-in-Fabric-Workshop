-- Simply updates the session embedding with the embedding passed in.
create or alter procedure [update_session_embeddings]
@id int,
/** 
    Due to a bug, we are currently using Varchar(MAX).
    Once the bug is fixed, use Vector(1536) like you would expect.
**/  
@in_embeddings Varchar(MAX) /** Vector(1536) **/
as

update 
    sessions 
set 
    embeddings = @embeddings,
    require_embeddings_update = 0
where   
    id = @id

GO

-- Simply updates speaker embedding with embedding passed in
create or alter procedure [update_speaker_embeddings]
@id int,
/** 
    Due to a bug, we are currently using Varchar(MAX).
    Once the bug is fixed, use Vector(1536) like you would expect.
**/  
@in_embeddings Varchar(MAX) /** Vector(1536) **/
as

update 
    speakers 
set 
    embeddings = @embeddings,
    require_embeddings_update = 0
where   
    id = @id
    
GO
