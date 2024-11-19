
-- Query the two tables after insert, and 
-- we can see the embeddings were udpated
select Cast(embeddings as VARCHAR(max))
from sessions

select Cast(embeddings as VARCHAR(max))
from speakers
