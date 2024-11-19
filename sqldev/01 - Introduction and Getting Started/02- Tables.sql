-- Creates a table to log the text that has been searched.
CREATE TABLE [searched_text]
(
    [id] INT IDENTITY (1, 1) NOT NULL,
    [searched_text] NVARCHAR (MAX) NOT NULL,
    [search_datetime] DATETIME2 (7) DEFAULT (sysdatetime()) NOT NULL,
    [ms_rest_call] INT NULL,
    [ms_vector_search] INT NULL,
    [found_sessions] INT NULL,

    PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- The sessions table will hold the titles and abstract information about each session.
-- We also include an embeddings column which will be used later for AI-integration.
CREATE TABLE [sessions]
(
    [id] INT DEFAULT (NEXT VALUE FOR [global_id]) NOT NULL,
    [title] NVARCHAR (200) NOT NULL,
    [abstract] NVARCHAR (MAX) NOT NULL,
    [external_id] VARCHAR (100) COLLATE Latin1_General_100_BIN2 NOT NULL,
    [last_fetched] DATETIME2 (7) NULL,
    [start_time] DATETIME2 (0) NOT NULL,
    [end_time] DATETIME2 (0) NOT NULL,
    [tags] NVARCHAR (MAX) NULL,
    [recording_url] VARCHAR (1000) NULL,
    [require_embeddings_update] BIT DEFAULT ((0)) NOT NULL,
    [embeddings] Vector(1536) NULL,

    PRIMARY KEY CLUSTERED ([id] ASC),
    CHECK (isjson([tags])=(1)),
    UNIQUE NONCLUSTERED ([title] ASC)
);
GO

-- The speakers table will hold the name information about each speaker.
-- We also include an embeddings column which will be used later for AI-integration.
CREATE TABLE [speakers]
(
    [id] INT DEFAULT (NEXT VALUE FOR [global_id]) NOT NULL,
    [external_id] VARCHAR (100) COLLATE Latin1_General_100_BIN2 NULL,
    [full_name] NVARCHAR (100) NOT NULL,
    [require_embeddings_update] BIT DEFAULT ((0)) NOT NULL,
    [embeddings] Vector(1536) NULL,

    PRIMARY KEY CLUSTERED ([id] ASC),
    UNIQUE NONCLUSTERED ([full_name] ASC)    
);
GO

-- sessions_speakers links speakers to individual sessions.
CREATE TABLE [sessions_speakers] (
    [session_id] INT NOT NULL,
    [speaker_id] INT NOT NULL,

    PRIMARY KEY CLUSTERED ([session_id] ASC, [speaker_id] ASC),
    CONSTRAINT fk__sessions_speakers__sessions FOREIGN KEY ([session_id]) REFERENCES [sessions] ([id]),
    CONSTRAINT fk__sessions_speakers__speakers FOREIGN KEY ([speaker_id]) REFERENCES [speakers] ([id])
);
GO

CREATE NONCLUSTERED INDEX [ix2]
    ON [sessions_speakers]([speaker_id] ASC);
GO



