
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
