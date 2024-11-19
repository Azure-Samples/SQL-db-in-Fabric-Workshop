-- Do three inserts to create a first session

insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5001, 'Amina El-Sayed', 1)
go

insert into sessions 
    (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values
    (
        1001,
        'Reducing Plastic Waste: Community-Led Initiatives', 
        'Amina El-Sayed will share her experiences leading successful campaigns to reduce plastic waste in her community. She will discuss the strategies used to engage local residents, the challenges faced, and the impact of these initiatives on the environment. Attendees will gain insights into how community-led efforts can drive significant environmental change.',
        'S1',
        '2024-11-05 10:00:00',
        '2024-11-05 11:00:00',
        1
    )
go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1001, 5001)
go

-- Insert another session

insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5002, 'Hiroshi Tanaka', 1)
go


insert into sessions
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1002,
		'Robotics for Everyday Life: Innovations and Applications',
		'Hiroshi Tanaka will present his work on developing robots that assist with household chores and support elderly individuals in their daily tasks. He will explore the latest advancements in robotics technology, the design and functionality of his robots, and the potential for these innovations to improve quality of life. The talk will include demonstrations and a discussion on future directions in robotics.',        
		'S2',        
		'2024-11-05 10:00:00',        
		'2024-11-05 11:30:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1002, 5002)
go

-- Insert a session
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5003, 'Liam O''Connor', 1)
go

insert into sessions 
    (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values
    (
        1003,
        'Medieval European History: Uncovering the Past', 
        'Liam O''Connor will delve into the fascinating world of medieval European history, sharing insights from his extensive research and publications. He will discuss key historical events, societal structures, and cultural developments of the medieval period. The talk will also cover the importance of historical preservation and the role of historians in uncovering and interpreting the past.',
        'S3',
        '2024-11-05 9:00:00',
        '2024-11-05 10:00:00',
        1
    )
go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1003, 5003)
go


-- Insert a session
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5004, 'Priya Patel', 1)
go

insert into sessions 
    (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values
    (
        1004,
        'Innovations in Cancer Treatment: A Biomedical Researcher''s Perspective', 
        'Priya Patel will present her groundbreaking work in developing new treatments for cancer. She will discuss the latest advancements in biomedical research, the challenges of translating research into clinical practice, and the potential impact of these treatments on patient outcomes. The talk will also emphasize the importance of maintaining a healthy mind and body through practices like yoga.',
        'S4',
        '2024-11-05 8:00:00',
        '2024-11-05 9:00:00',
        1
    )
go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1004, 5004)
go

