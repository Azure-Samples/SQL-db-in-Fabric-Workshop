
-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1014,
		'Harnessing Community Power for Environmental Change',
		'Amina El-Sayed will discuss the power of community engagement in driving environmental change. She will share her experiences leading grassroots campaigns to reduce plastic waste and highlight the importance of local action in addressing global environmental challenges. Attendees will learn practical strategies for mobilizing communities and fostering sustainable practices.',        
		'S14',        
		'2024-11-05 13:00:00',        
		'2024-11-05 14:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1014, 5001)
go

-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5008, 'Maria Gonzalez', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1008,
		'Fusion Cuisine: Blending Flavors from Around the World',
		'Maria Gonzalez will take attendees on a culinary journey, showcasing her expertise in fusion cuisine. She will explain the principles of combining diverse flavors and ingredients to create unique dishes, share some of her favorite recipes, and provide tips for aspiring chefs. The session will highlight the cultural significance of food and the joy of culinary experimentation.',
		'S8',        
		'2024-11-05 14:30:00',        
		'2024-11-05 15:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1008, 5008)
go

-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5007, 'Oliver Smith', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1007,
		'Capturing the Wild: A Wildlife Photographer''s Adventures',
		'Oliver Smith will take attendees on a visual journey through his experiences as a wildlife photographer. He will share stunning images from his travels to over 50 countries, discuss the challenges of photographing animals in their natural habitats, and emphasize the importance of wildlife conservation. The session will inspire a deeper appreciation for the natural world and the need to protect it.',        
		'S7',        
		'2024-11-05 8:30:00',        
		'2024-11-05 9:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1007, 5007)
go

-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5006, 'Zanele Mbeki', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1006,
		'Empowering Communities Through Education and Art',
		'Zanele Mbeki will discuss her journey as a social entrepreneur and founder of a non-profit organization that provides educational resources to underprivileged children. She will highlight the impact of education on community development and share how she uses her art to raise awareness about social issues. The talk will provide valuable insights into the power of education and creativity in driving social change.',        
		'S6',        
		'2024-11-05 11:30:00',        
		'2024-11-05 13:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1006, 5006)
go

-- Just insert a session with an existing speaker
insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1015,
		'The Future of Home Automation: Robotics and AI',
		'Hiroshi Tanaka will explore the intersection of robotics and artificial intelligence in home automation. He will present his latest projects, including robots designed to assist with household chores and support elderly individuals. The talk will cover the technological advancements, ethical considerations, and potential future developments in this rapidly evolving field.',        
		'S15',        
		'2024-11-05 14:30:00',        
		'2024-11-05 15:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1015, 5002)
go

-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5005, 'Jack Thompson', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1005,
		'Riding the Waves: The Life of a Professional Surfer',
		'Jack Thompson will share his experiences as a professional surfer, including the highs and lows of competing in international surfing competitions. He will discuss the skills and dedication required to excel in the sport, the importance of ocean conservation, and his work with organizations to protect marine life. The session will inspire attendees to pursue their passions and advocate for environmental sustainability',        
		'S5',        
		'2024-11-05 15:00:00',        
		'2024-11-05 16:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1005, 5005)
go


-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5009, 'Sofia Rossi', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1009,
		'Coral Reefs and Climate Change: A Marine Biologist''s Insights',
		'Sofia Rossi will present her research on the impact of climate change on coral reefs. She will discuss the current state of coral reefs, the threats they face, and the efforts being made to preserve these vital ecosystems. The talk will also cover the importance of marine conservation and the role of scientific research in informing policy and conservation strategies.',        
		'S9',        
		'2024-11-05 8:00:00',        
		'2024-11-05 9:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1009, 5009)
go

-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5010, 'Rajesh Kumar', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1010,
		'Innovative Solutions for Renewable Energy: An Entrepreneur''s Journey',
		'Rajesh Kumar will share his experiences as an entrepreneur in the renewable energy sector. He will discuss the innovative solutions developed by his tech startup, the challenges of building a successful business, and the importance of mentorship for aspiring entrepreneurs. The session will provide insights into the future of renewable energy and the role of entrepreneurship in driving technological advancements.',        
		'S10',        
		'2024-11-05 9:00:00',        
		'2024-11-05 10:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1010, 5010)
go

-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5011, 'Emily Johnson', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1011,
		'Inspiring Young Minds: The Power of Children''s Literature',
		'Emily Johnson will discuss her work as a children''s book author and advocate for literacy programs. She will explore the impact of storytelling on young readers, share her approach to writing engaging and educational stories, and highlight the importance of promoting literacy in underserved communities. The talk will inspire attendees to support literacy initiatives and the development of children''s literature.',        
		'S11',        
		'2024-11-05 10:00:00',        
		'2024-11-05 11:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1011, 5011)
go

-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5012, 'Carlos Mendes', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1012,
		'From the Field to the Community: A Soccer Player''s Impact',
		'Carlos Mendes will share his journey as a professional soccer player and his involvement in charitable activities. He will discuss the importance of sports in personal development, the role of athletes in giving back to the community, and his work with youth sports programs. The session will highlight the positive influence of sports on individuals and communities.',        
		'S12',        
		'2024-11-05 11:00:00',        
		'2024-11-05 12:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1012, 5012)
go


-- Insert a session with a new speaker
insert into speakers
    (id, full_name, require_embeddings_update)
values
    (5013, 'Fatima Al-Hassan', 1)
go

insert into sessions     (id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1013,
		'Fearless Journalism: Reporting on Social and Political Issues',
		'Fatima Al-Hassan will present her experiences as a journalist covering social and political issues in the Middle East. She will discuss the challenges of investigative reporting, the importance of journalistic integrity, and the impact of her work on raising awareness about critical issues. The talk will provide insights into the role of journalism in shaping public opinion and driving social change.',        
		'S13',        
		'2024-11-05 13:00:00',        
		'2024-11-05 14:00:00',        
		1    )
		go


insert into sessions_speakers
    (session_id, speaker_id)
values
    (1013, 5013)
go


-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1016,
		'Culinary Creativity: The Art of Fusion Cooking',
		'Maria Gonzalez will delve into the art of fusion cooking, where diverse culinary traditions meet to create innovative dishes. She will share her journey as a chef, discuss the creative process behind her recipes, and provide tips for blending flavors from different cultures. The session will inspire attendees to experiment in their own kitchens and appreciate the cultural richness of food.',        
		'S16',        
		'2024-11-05 14:00:00',        
		'2024-11-05 15:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1016, 5008)
go


-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1017,
		'Unveiling the Mysteries of Medieval Europe',
		'Liam O''Connor will take attendees on a journey through medieval Europe, uncovering the mysteries and marvels of this historical period. He will share insights from his research, discuss significant events and figures, and highlight the importance of preserving historical knowledge. The talk will provide a deeper understanding of medieval society and its lasting impact on the modern world.',        
		'S17',        
		'2024-11-05 14:00:00',        
		'2024-11-05 15:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1017, 5003)
go


-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1018,
		'Yoga and Biomedical Research: A Holistic Approach to Health',
		'Priya Patel will present a unique perspective on health by combining her expertise in biomedical research with her passion for yoga. She will discuss the latest advancements in cancer treatment, the benefits of yoga for physical and mental well-being, and the importance of a holistic approach to healthcare. The session will offer practical tips for integrating scientific and holistic practices in daily life.',        
		'S18',        
		'2024-11-05 15:00:00',        
		'2024-11-05 16:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1018, 5004)
go

-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1019,
		'Surfing and Sustainability: Protecting Our Oceans',
		'Jack Thompson will share his experiences as a professional surfer and advocate for ocean conservation. He will discuss the environmental challenges facing our oceans, the role of surfers in promoting sustainability, and his work with organizations dedicated to marine protection. The talk will inspire attendees to take action in preserving our oceans for future generations.',        
		'S19',        
		'2024-11-05 16:00:00',        
		'2024-11-05 17:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1019, 5005)
go


-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1020,
		'Art and Education: Tools for Social Change',
		'Zanele Mbeki will explore the powerful combination of art and education as tools for social change. She will discuss her work as a social entrepreneur, the impact of her non-profit organization on underprivileged children, and how she uses her art to raise awareness about social issues. The session will highlight the transformative potential of creativity and education in addressing societal challenges.',        
		'S20',        
		'2024-11-05 16:00:00',        
		'2024-11-05 17:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1020, 5006)
go


-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1021,
		'Wildlife Photography: Capturing Nature''s Beauty',
		'Oliver Smith will take attendees behind the lens of his wildlife photography adventures. He will share breathtaking images from his travels, discuss the techniques and challenges of photographing animals in their natural habitats, and emphasize the importance of wildlife conservation. The talk will inspire a deeper appreciation for the beauty of nature and the need to protect it.',        
		'S21',        
		'2024-11-05 16:00:00',        
		'2024-11-05 17:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1021, 5007)
go

-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1022,
		'Preserving Coral Reefs: A Marine Biologist''s Mission',
		'Sofia Rossi will present her mission to preserve coral reefs in the face of climate change. She will discuss the current state of coral reefs, the scientific research being conducted to understand and mitigate the impacts of climate change, and the importance of marine conservation. The session will provide valuable insights into the efforts to protect these vital ecosystems.',        
		'S22',        
		'2024-11-05 17:00:00',        
		'2024-11-05 18:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1022, 5009)
go

-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1023,
		'Entrepreneurship and Innovation in Renewable Energy',
		'Rajesh Kumar will share his journey as an entrepreneur in the renewable energy sector. He will discuss the innovative solutions developed by his tech startup, the challenges and opportunities in the renewable energy market, and the importance of mentorship for aspiring entrepreneurs. The talk will provide insights into the future of renewable energy and the role of entrepreneurship in driving technological advancements.',        
		'S23',        
		'2024-11-06 8:00:00',        
		'2024-11-06 9:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1023, 5010)
go

-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1024,
		'The Magic of Storytelling: Inspiring Young Readers',
		'Emily Johnson will explore the magic of storytelling and its impact on young readers. She will discuss her approach to writing engaging children''s books, the importance of promoting literacy, and her advocacy for literacy programs in underserved communities. The session will inspire attendees to support literacy initiatives and the development of children''s literature.',        
		'S24',        
		'2024-11-06 9:00:00',        
		'2024-11-06 10:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1024, 5011)
go

-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1025,
		'The Role of Sports in Community Development',
		'Carlos Mendes will discuss the role of sports in personal and community development. He will share his experiences as a professional soccer player, the positive influence of sports on individuals, and his involvement in charitable activities and youth sports programs. The talk will highlight the importance of sports in fostering community spirit and personal growth.',        
		'S25',        
		'2024-11-06 10:00:00',        
		'2024-11-06 11:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1025, 5012)
go

-- Insert a session with an existing speaker
insert into sessions     
	(id, title, abstract, external_id, start_time, end_time, require_embeddings_update)
values    (        
		1026,
		'Investigative Journalism: Uncovering the Truth',
		'Fatima Al-Hassan will present her experiences as an investigative journalist covering social and political issues in the Middle East. She will discuss the challenges and rewards of investigative reporting, the importance of journalistic integrity, and the impact of her work on raising awareness about critical issues. The session will provide insights into the role of journalism in shaping public opinion and driving social change.',        
		'S26',        
		'2024-11-06 11:00:00',        
		'2024-11-06 12:00:00',        
		1    )
		go

insert into sessions_speakers
    (session_id, speaker_id)
values
    (1026, 5013)
go
