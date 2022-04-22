IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[fld_name_stats]'))
CREATE FULLTEXT INDEX ON [dbo].[fld_name_stats](
[searchable] LANGUAGE [English])
KEY INDEX [UK_fld_name_stats__id]ON ([ftc_fld_name_stats], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO

IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[drl_connection_stats]'))
CREATE FULLTEXT INDEX ON [dbo].[drl_connection_stats](
[searchable] LANGUAGE [English])
KEY INDEX [UK_drl_connection_stats__id]ON ([ftc_fld_name_stats], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO

IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[drl_available_for_campaign_stats]'))
CREATE FULLTEXT INDEX ON [dbo].[drl_available_for_campaign_stats](
[searchable] LANGUAGE [English])
KEY INDEX [UK_drl_available_for_campaign_stats__id_result]ON ([ftc_drl_available_for_campaign_stats], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO

IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[stat_search_result]'))
CREATE FULLTEXT INDEX ON [dbo].[stat_search_result](
[companysize] LANGUAGE [English], 
[companysize_standard] LANGUAGE [English], 
[headline] LANGUAGE [English], 
[industry] LANGUAGE [English], 
[industry_standard] LANGUAGE [English], 
[location] LANGUAGE [English], 
[location_standard] LANGUAGE [English], 
[name] LANGUAGE [English], 
[stat_address_appended] LANGUAGE [English], 
[stat_email_appended] LANGUAGE [English], 
[stat_phone_appended] LANGUAGE [English], 
[title] LANGUAGE [English])
KEY INDEX [UK_stat_search_result_2]ON ([stat_search_result_FTS], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO

