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
