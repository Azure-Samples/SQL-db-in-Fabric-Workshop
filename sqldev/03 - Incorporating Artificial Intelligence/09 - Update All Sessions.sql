-- Update all sessions

create   procedure [update_all_sessions]

as
begin

set nocount on;

declare @id int, @abstract NVARCHAR(max),  @message NVARCHAR(max)

declare session_cursor cursor FAST_FORWARD READ_ONLY
for select id, abstract from sessions 
where require_embeddings_update = 1
order by id

open session_cursor

fetch next from session_cursor
INTO @id, @abstract

while @@FETCH_STATUS = 0
begin

  declare @retval int, @embedding Vector(1536);
  -- Call the get_embedding stored procedure to retrieve an abstract embedding
  exec @retval = get_embedding @abstract, @embedding OUTPUT

  -- Call the update_session_embeddings stored procedure to update the session embeddings
  exec @retval = update_session_embeddings @id, @embedding

fetch next from session_cursor
INTO @id, @abstract

end
close session_cursor
deallocate session_cursor

end
GO


