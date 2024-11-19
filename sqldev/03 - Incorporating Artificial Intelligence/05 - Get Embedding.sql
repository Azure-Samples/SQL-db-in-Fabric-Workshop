create or alter procedure [get_embedding]
@inputText nvarchar(max),
@embedding Vector(1536) output
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
set @embedding = CAST(@re AS VECTOR(1536));

return @retval
go
