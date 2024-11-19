
-- You can see that our speakers and sessions that have been inserted so far 
-- need embedding updates.
select title, CAST(embeddings as VARCHAR(MAX)) as embeddings_vector
from Sessions

select full_name, CAST(embeddings as  VARCHAR(MAX)) as embeddings_vector
from speakers


-- Update those embeddings
exec update_all_sessions

exec update_all_speakers


  -- now query again to see that the embeddings have been udpated
select title, CAST(embeddings as  VARCHAR(MAX)) as embeddings_vector
from Sessions

select full_name, CAST(embeddings as  VARCHAR(MAX)) as embeddings_vector
from speakers
