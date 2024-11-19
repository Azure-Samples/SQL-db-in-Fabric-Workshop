Declare @retval int, @embedding vector(1536);

-- With this call, you are generating an embedding for the word "nature".  
-- The embedding is passed out into the @embedding variable
EXEC @retval = get_embedding 'nature', @embedding OUTPUT;

/** In order for the embedding to appear meaningful, you
    must convert it from the raw binary to a data
    array.  
**/
select CAST(@embedding as VARCHAR(MAX))
