USE [master]
GO
/****** Object:  Database [%database_name%]    Script Date: 04/19/2022 15:05:28 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'%database_name%')
BEGIN
CREATE DATABASE [%database_name%] ON  PRIMARY 
( NAME = N'%database_name%_Data', FILENAME = N'%path%\%database_name%.mdf' , SIZE = %size%MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'%database_name%_Log', FILENAME = N'%path%\%database_name%.ldf' , SIZE = %size%MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 COLLATE Traditional_Spanish_CI_AS
END
GO
ALTER DATABASE [%database_name%] SET COMPATIBILITY_LEVEL = 80
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [%database_name%].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [%database_name%] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [%database_name%] SET ANSI_NULLS OFF
GO
ALTER DATABASE [%database_name%] SET ANSI_PADDING OFF
GO
ALTER DATABASE [%database_name%] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [%database_name%] SET ARITHABORT OFF
GO
ALTER DATABASE [%database_name%] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [%database_name%] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [%database_name%] SET AUTO_SHRINK ON
GO
ALTER DATABASE [%database_name%] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [%database_name%] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [%database_name%] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [%database_name%] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [%database_name%] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [%database_name%] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [%database_name%] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [%database_name%] SET  DISABLE_BROKER
GO
ALTER DATABASE [%database_name%] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [%database_name%] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [%database_name%] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [%database_name%] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [%database_name%] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [%database_name%] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [%database_name%] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [%database_name%] SET  READ_WRITE
GO
ALTER DATABASE [%database_name%] SET RECOVERY SIMPLE
GO
ALTER DATABASE [%database_name%] SET  MULTI_USER
GO
ALTER DATABASE [%database_name%] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [%database_name%] SET DB_CHAINING OFF
GO
use [%database_name%];
GO
/****** Object:  FullTextCatalog [stat_search_result_FTS]    Script Date: 04/19/2022 15:05:40 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'stat_search_result_FTS')
CREATE FULLTEXT CATALOG [stat_search_result_FTS]WITH ACCENT_SENSITIVITY = OFF
AUTHORIZATION [dbo]
GO
/****** Object:  FullTextCatalog [ftc_fld_name_stats]    Script Date: 04/19/2022 15:05:40 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ftc_fld_name_stats')
CREATE FULLTEXT CATALOG [ftc_fld_name_stats]WITH ACCENT_SENSITIVITY = ON
AS DEFAULT
AUTHORIZATION [dbo]
GO
/****** Object:  FullTextCatalog [ftc_drl_minutely_stats]    Script Date: 04/19/2022 15:05:41 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ftc_drl_minutely_stats')
CREATE FULLTEXT CATALOG [ftc_drl_minutely_stats]WITH ACCENT_SENSITIVITY = ON
AUTHORIZATION [dbo]
GO
/****** Object:  FullTextCatalog [ftc_drl_connection_stats]    Script Date: 04/19/2022 15:05:41 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ftc_drl_connection_stats')
CREATE FULLTEXT CATALOG [ftc_drl_connection_stats]WITH ACCENT_SENSITIVITY = ON
AUTHORIZATION [dbo]
GO
/****** Object:  FullTextCatalog [ftc_drl_available_for_campaign_stats]    Script Date: 04/19/2022 15:05:41 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ftc_drl_available_for_campaign_stats')
CREATE FULLTEXT CATALOG [ftc_drl_available_for_campaign_stats]WITH ACCENT_SENSITIVITY = ON
AUTHORIZATION [dbo]
GO
/****** Object:  Table [dbo].[domain]    Script Date: 04/19/2022 15:40:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[domain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[domain](
	[id] [uniqueidentifier] NOT NULL,
	[protocol] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__domain__3213E83F4275DA91] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_domain__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lnindustry]    Script Date: 04/19/2022 15:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnindustry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnindustry](
	[id] [uniqueidentifier] NOT NULL,
	[code] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[relevance] [numeric](18, 0) NULL,
	[relevance_backup] [numeric](18, 0) NULL,
	[name_spanish] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_lnindustry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnindustry]') AND name = N'IX_lnindustry__relevance_desc')
CREATE NONCLUSTERED INDEX [IX_lnindustry__relevance_desc] ON [dbo].[lnindustry] 
(
	[relevance] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnindustry', N'COLUMN',N'code'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key value by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnindustry', @level2type=N'COLUMN',@level2name=N'code'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnindustry', N'COLUMN',N'name'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Industry name by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnindustry', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnindustry', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Industries supported by LinkedIn. More information: https://developer.linkedin.com/docs/reference/industry-codes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnindustry'
GO
/****** Object:  Table [dbo].[lncountry]    Script Date: 04/19/2022 15:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lncountry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lncountry](
	[id] [uniqueidentifier] NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name_spanish] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__lncountr__3213E83F3CF40B7E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[template]    Script Date: 04/19/2022 15:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[template]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[template](
	[id] [uniqueidentifier] NOT NULL,
	[number] [numeric](18, 0) NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[description] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[sentence] [bit] NULL,
	[trigger_type] [int] NULL,
	[template_number] [int] NULL,
 CONSTRAINT [PK__template__3213E83F2683A759] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lnusertemplate]    Script Date: 04/19/2022 15:25:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnusertemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnusertemplate](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[headline] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_lncountry] [uniqueidentifier] NOT NULL,
	[id_lnindustry] [uniqueidentifier] NULL,
	[zipcode] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[summary] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[allowed_for_ssm_wizard_template] [bit] NULL,
	[id_template_headline] [uniqueidentifier] NULL,
	[id_template_summary] [uniqueidentifier] NULL,
 CONSTRAINT [PK__lnuserte__3213E83F37D2279F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[timezone]    Script Date: 04/19/2022 15:43:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[timezone]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[timezone](
	[id] [uniqueidentifier] NOT NULL,
	[offset] [float] NOT NULL,
	[large_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[short_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__timezone__3213E83F1FEBB863] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user]    Script Date: 04/19/2022 15:06:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[user]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[user](
	[id] [uniqueidentifier] NOT NULL,
	[id_client] [uniqueidentifier] NOT NULL,
	[email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[password] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[verified] [bit] NULL,
	[division_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[allow_notification_drl_when_a_lead_accept_an_invitation_to_connect] [bit] NULL,
	[allow_notification_drl_when_a_lead_write_a_message_to_your_sales_rep] [bit] NULL,
	[ssm_wizard_configuration] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[edb_search_configuration] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[allow_notification_em5_when_a_subscriber_open_an_email_at_the_first_time] [bit] NULL,
	[dont_ask_before_unlink_invitation_message_to_search] [bit] NULL,
	[dont_ask_before_unlink_welcome_message_to_search] [bit] NULL,
	[dont_ask_before_pause_invitation_message] [bit] NULL,
	[dont_ask_before_delete_invitation_message] [bit] NULL,
	[linkedin_profile_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[allowed_for_linkedin_group_chat_transfers] [bit] NULL,
	[max_lnusers_for_linkedin_group_chat_transfers] [int] NULL,
	[max_linkedin_group_chat_transfers_per_day] [int] NULL,
	[linkedin_profile_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[linkedin_profile_headline] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_search] [uniqueidentifier] NULL,
	[phone] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_user__email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[user]') AND name = N'IX_user__delete_time__allow_notification_drl_when_a_lead_write_a_message_to_your_sales_rep__id')
CREATE NONCLUSTERED INDEX [IX_user__delete_time__allow_notification_drl_when_a_lead_write_a_message_to_your_sales_rep__id] ON [dbo].[user] 
(
	[delete_time] ASC,
	[allow_notification_drl_when_a_lead_write_a_message_to_your_sales_rep] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[user]') AND name = N'IX_user__id_client__id')
CREATE NONCLUSTERED INDEX [IX_user__id_client__id] ON [dbo].[user] 
(
	[id_client] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client]    Script Date: 04/19/2022 15:12:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[client]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[client](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[paypal_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_timezone] [uniqueidentifier] NULL,
	[active] [bit] NULL,
	[domain_for_ssm] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[from_email_for_ssm] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[from_name_for_ssm] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[domain_for_ssm_verified] [bit] NULL,
	[id_user_to_contact] [uniqueidentifier] NULL,
	[billing_address] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[billing_city] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[billing_state] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[billing_zipcode] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[billing_id_lncountry] [uniqueidentifier] NULL,
	[disabled_for_trial_ssm] [bit] NULL,
	[api_key] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[avoid_heijunka] [bit] NULL,
	[last_heijunka_time] [datetime] NULL,
	[allowed_to_write_emails_into_drl_messages] [bit] NULL,
	[allowed_to_write_urls_into_drl_messages] [bit] NULL,
	[shm_threshold_cpu] [numeric](2, 0) NULL,
	[shm_threshold_mem] [numeric](2, 0) NULL,
	[shm_threshold_disk] [numeric](2, 0) NULL,
	[shm_alerts_id_user_1] [uniqueidentifier] NULL,
	[shm_alerts_id_user_2] [uniqueidentifier] NULL,
	[shm_alerts_id_user_3] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
	[create_time] [datetime] NULL,
	[drx_max_logins_per_hour] [int] NULL,
	[drx_max_logins_per_day] [int] NULL,
	[drx_max_searches_per_hour] [int] NULL,
	[drx_max_searches_per_day] [int] NULL,
	[drx_max_invitations_per_hour] [int] NULL,
	[drx_max_invitations_per_day] [int] NULL,
	[drx_max_messages_per_hour] [int] NULL,
	[drx_max_messages_per_day] [int] NULL,
	[last_stat_balance_update_time] [datetime] NULL,
	[issues_check_last_time] [datetime] NULL,
	[stat_first_lead_notification_time] [datetime] NULL,
	[sis_max_linkedin_directory_of_companies_entries_scraping_per_day] [int] NULL,
	[gct_on_introduction_message] [bit] NULL,
	[welcome_email_sent_time] [datetime] NULL,
	[confirm_email_sent_time] [datetime] NULL,
	[create_storage_time] [datetime] NULL,
	[crowdtrust_first_comment_datetime] [datetime] NULL,
	[crowdtrust_first_sharecomment_datetime] [datetime] NULL,
	[next_comment_number] [bigint] NULL,
	[last_comment_datetime] [datetime] NULL,
	[next_sharecomment_number] [bigint] NULL,
	[last_sharecomment_datetime] [datetime] NULL,
	[next_comment_datetime] [datetime] NULL,
	[next_sharecomment_datetime] [datetime] NULL,
	[prospecting_sharing_my_network] [bit] NULL,
	[planning_prospecting_invitations_reservation_id] [uniqueidentifier] NULL,
	[stat_update_drl_minutely_stats_mirror_time] [datetime] NULL,
	[stat_update_drl_minutely_stats_table_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_update_drl_minutely_stats_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[remove_data_start_time] [datetime] NULL,
	[remove_data_end_time] [datetime] NULL,
	[remove_data_result] [bit] NULL,
	[remove_data_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_client] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[proxy]    Script Date: 04/19/2022 15:15:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proxy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[proxy](
	[id] [uniqueidentifier] NOT NULL,
	[ip] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[port] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[user] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[password] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[delete_time] [datetime] NULL,
	[process] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[reservation_id] [uniqueidentifier] NULL,
	[reservation_time] [datetime] NULL,
	[reservation_start_time] [datetime] NULL,
	[reservation_end_time] [datetime] NULL,
	[reservation_result] [int] NULL,
	[reservation_description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[time_reached_max_records_before_long_sleep] [datetime] NULL,
	[last_ping_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NULL,
	[cosmos_id_client] [uniqueidentifier] NULL,
	[cosmos_hostname] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[cosmos_external_ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[cosmos_country] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[cosmos_city] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[cosmos_lattitude] [float] NULL,
	[cosmos_longitude] [float] NULL,
	[cosmos_ip_type] [int] NULL,
	[cosmos_asn] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[cosmos_isp] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[rotating_minutes] [int] NULL,
	[disabled_for_heijunka] [bit] NULL,
	[test_reservation_id] [uniqueidentifier] NULL,
	[test_reservation_time] [datetime] NULL,
	[test_start_time] [datetime] NULL,
	[test_end_time] [datetime] NULL,
	[test_error_description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_proxy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lnuser]    Script Date: 04/19/2022 15:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnuser](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[username] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[status] [int] NULL,
	[status_time] [datetime] NULL,
	[last_signal_time] [datetime] NULL,
	[incrawl_reservation_id] [uniqueidentifier] NULL,
	[incrawl_reservation_time] [datetime] NULL,
	[has_sales_navigator] [bit] NULL,
	[picture_filename] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[first_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[last_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[summary] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[headline] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[create_reservation_id] [uniqueidentifier] NULL,
	[create_reservation_time] [datetime] NULL,
	[create_reservation_times] [int] NULL,
	[create_start_time] [datetime] NULL,
	[create_end_time] [datetime] NULL,
	[create_urgency] [bit] NULL,
	[ininvite_reservation_times] [int] NULL,
	[ininvite_start_time] [datetime] NULL,
	[ininvite_end_time] [datetime] NULL,
	[id_proxy] [uniqueidentifier] NULL,
	[allowed_for_incrawl_lnsearchvariation] [bit] NULL,
	[allowed_for_ininvite_result] [bit] NULL,
	[inmessage_reservation_times] [int] NULL,
	[inmessage_start_time] [datetime] NULL,
	[inmessage_end_time] [datetime] NULL,
	[login_failure_times] [int] NULL,
	[delete_time] [datetime] NULL,
	[status_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[status_screenshot_filename] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[edit_profile_reservation_id] [uniqueidentifier] NULL,
	[edit_profile_reservation_time] [datetime] NULL,
	[edit_profile_reservation_times] [numeric](18, 0) NULL,
	[edit_profile_start_time] [datetime] NULL,
	[edit_profile_end_time] [datetime] NULL,
	[confirm_email_start_time] [datetime] NULL,
	[confirm_email_end_time] [datetime] NULL,
	[setup_hide_connections_start_time] [datetime] NULL,
	[setup_hide_connections_end_time] [datetime] NULL,
	[setup_emails_frequency_start_time] [datetime] NULL,
	[setup_emails_frequency_end_time] [datetime] NULL,
	[signup_start_time] [datetime] NULL,
	[signup_end_time] [datetime] NULL,
	[id_lncountry] [uniqueidentifier] NULL,
	[id_lnindustry] [uniqueidentifier] NULL,
	[zipcode] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_lnusertemplate] [uniqueidentifier] NULL,
	[url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[repair_reservation_times] [numeric](18, 0) NULL,
	[repair_start_time] [datetime] NULL,
	[repair_end_time] [datetime] NULL,
	[repair_new_email_address] [varchar](50) COLLATE Traditional_Spanish_CI_AS NULL,
	[disabled_for_heijunka] [bit] NULL,
	[type] [int] NULL,
	[incrawl_start_time] [datetime] NULL,
	[incrawl_end_time] [datetime] NULL,
	[recover_start_time] [datetime] NULL,
	[recover_end_time] [datetime] NULL,
	[incrawl_reservation_times] [int] NULL,
	[recover_reservation_times] [int] NULL,
	[email_signup_start_time] [datetime] NULL,
	[email_signup_end_time] [datetime] NULL,
	[email_forward_start_time] [datetime] NULL,
	[email_forward_end_time] [datetime] NULL,
	[id_proxy_for_email] [uniqueidentifier] NULL,
	[email_setup_forward_start_time] [datetime] NULL,
	[email_setup_forward_end_time] [datetime] NULL,
	[email_forward_to] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[email_setup_recover_start_time] [datetime] NULL,
	[email_setup_recover_end_time] [datetime] NULL,
	[email_recover_address] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[test_reservation_id] [uniqueidentifier] NULL,
	[test_reservation_time] [datetime] NULL,
	[test_reservation_times] [int] NULL,
	[test_start_time] [datetime] NULL,
	[test_end_time] [datetime] NULL,
	[id_mimic_profile] [uniqueidentifier] NULL,
	[user_agent] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_worker] [uniqueidentifier] NULL,
	[id_client_allocated] [uniqueidentifier] NULL,
	[email_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mla_profile_modification_request_time] [datetime] NULL,
	[stat_network_connections] [numeric](18, 0) NULL,
	[stat_purchase_price] [numeric](18, 0) NULL,
	[stat_last_update] [datetime] NULL,
	[repair_forward_email_address_creation_time] [datetime] NULL,
	[repair_forward_email_address_creation_tries] [int] NULL,
	[id_worker_for_botting] [uniqueidentifier] NULL,
	[edit_profile_content_update_time] [datetime] NULL,
	[drx_max_logins_per_hour] [int] NULL,
	[drx_max_logins_per_day] [int] NULL,
	[drx_max_searches_per_hour] [int] NULL,
	[drx_max_searches_per_day] [int] NULL,
	[drx_max_invitations_per_hour] [int] NULL,
	[drx_max_invitations_per_day] [int] NULL,
	[drx_max_messages_per_hour] [int] NULL,
	[drx_max_messages_per_day] [int] NULL,
	[allowed_for_scraping_linkedin_directory_of_companies_entries] [bit] NULL,
	[sis_max_linkedin_directory_of_companies_entries_scraping_per_day] [int] NULL,
	[stat_dispatch_message_result_last_time] [datetime] NULL,
	[smspva_country_code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[allowed_for_crowdtrust] [bit] NULL,
	[id_client_allocated_for_crowdtrust] [uniqueidentifier] NULL,
	[stat_last_signal_incoming_message] [datetime] NULL,
	[stat_last_signal_accepted_connection_request] [datetime] NULL,
	[stealth_browser_technology_code] [varchar](50) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_last_update_of_drl_available_for_campaign_stats] [datetime] NULL,
	[mac_smspva_country_code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[prospecting_reservation_id] [uniqueidentifier] NULL,
	[prospecting_reservation_time] [datetime] NULL,
	[prospecting_start_time] [datetime] NULL,
	[prospecting_end_time] [datetime] NULL,
	[stat_wlt_messages] [int] NULL,
	[stat_manual_messages] [int] NULL,
	[repair_old_email_address] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_last_update_of_drl_connection_stats] [datetime] NULL,
	[stat_last_update_of_drl_performance_stats] [datetime] NULL,
	[drx_min_hour_to_login] [int] NULL,
	[drx_max_hour_to_login] [int] NULL,
	[emailaddresses_creation_request_time] [datetime] NULL,
	[allow_mixed_up_headline] [bit] NULL,
	[allow_mixed_up_summary] [bit] NULL,
	[disabled_for_add_message_on_invitations] [bit] NULL,
	[picture_assignation_request_time] [datetime] NULL,
	[schedule_signup_date] [date] NULL,
 CONSTRAINT [PK__lnuser__3213E83F7E22B05D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__delete_time__disabled_for_heijunka__allowed_for_crowdtrust')
CREATE NONCLUSTERED INDEX [IX_lnuser__delete_time__disabled_for_heijunka__allowed_for_crowdtrust] ON [dbo].[lnuser] 
(
	[delete_time] ASC,
	[disabled_for_heijunka] ASC,
	[allowed_for_crowdtrust] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__delete_time__stat_dispatch_message_result_last_time')
CREATE NONCLUSTERED INDEX [IX_lnuser__delete_time__stat_dispatch_message_result_last_time] ON [dbo].[lnuser] 
(
	[delete_time] ASC,
	[stat_dispatch_message_result_last_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__delete_time__status__id')
CREATE NONCLUSTERED INDEX [IX_lnuser__delete_time__status__id] ON [dbo].[lnuser] 
(
	[delete_time] ASC,
	[status] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__disabled_for_heijunka')
CREATE NONCLUSTERED INDEX [IX_lnuser__disabled_for_heijunka] ON [dbo].[lnuser] 
(
	[disabled_for_heijunka] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__for_farming_dispatcher')
CREATE NONCLUSTERED INDEX [IX_lnuser__for_farming_dispatcher] ON [dbo].[lnuser] 
(
	[status] ASC,
	[stealth_browser_technology_code] ASC,
	[delete_time] ASC,
	[mla_profile_modification_request_time] ASC,
	[emailaddresses_creation_request_time] ASC,
	[create_reservation_id] ASC,
	[id_mimic_profile] ASC,
	[create_reservation_times] ASC,
	[signup_end_time] ASC,
	[confirm_email_end_time] ASC,
	[edit_profile_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__for_prospecting_dispatcher')
CREATE NONCLUSTERED INDEX [IX_lnuser__for_prospecting_dispatcher] ON [dbo].[lnuser] 
(
	[stealth_browser_technology_code] ASC,
	[delete_time] ASC,
	[mla_profile_modification_request_time] ASC,
	[emailaddresses_creation_request_time] ASC,
	[prospecting_reservation_id] ASC,
	[id_mimic_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__id_proxy')
CREATE NONCLUSTERED INDEX [IX_lnuser__id_proxy] ON [dbo].[lnuser] 
(
	[id_proxy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__prospecting_reservation_id')
CREATE NONCLUSTERED INDEX [IX_lnuser__prospecting_reservation_id] ON [dbo].[lnuser] 
(
	[prospecting_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuser]') AND name = N'IX_lnuser__username__repair_new_email_address')
CREATE NONCLUSTERED INDEX [IX_lnuser__username__repair_new_email_address] ON [dbo].[lnuser] 
(
	[username] ASC,
	[repair_new_email_address] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sis_directory_entry]    Script Date: 04/19/2022 15:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sis_directory_entry](
	[id] [uniqueidentifier] NOT NULL,
	[id_parent] [uniqueidentifier] NULL,
	[url] [varchar](900) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NOT NULL,
	[disabled_for_scraping] [bit] NOT NULL,
	[last_scrape_time] [datetime] NULL,
	[id_domain] [uniqueidentifier] NULL,
	[type] [int] NULL,
	[scrape_reservation_id] [uniqueidentifier] NULL,
	[scrape_reservation_time] [datetime] NULL,
 CONSTRAINT [PK__sis_link__3213E83F39F26511] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_sis_linkedin_directory_of_companies_page__url] UNIQUE NONCLUSTERED 
(
	[url] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]') AND name = N'IX_sis_directory_entry__scrape_reservation_id')
CREATE NONCLUSTERED INDEX [IX_sis_directory_entry__scrape_reservation_id] ON [dbo].[sis_directory_entry] 
(
	[scrape_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]') AND name = N'IX_sis_directory_entry__scrape_reservation_id__id_domain__disabled_for_scraping__last_scrape_time')
CREATE NONCLUSTERED INDEX [IX_sis_directory_entry__scrape_reservation_id__id_domain__disabled_for_scraping__last_scrape_time] ON [dbo].[sis_directory_entry] 
(
	[scrape_reservation_id] ASC,
	[id_domain] ASC,
	[disabled_for_scraping] ASC,
	[last_scrape_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sis_linkedin_directory_of_companies_entry_scraping_history]    Script Date: 04/19/2022 15:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sis_linkedin_directory_of_companies_entry_scraping_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sis_linkedin_directory_of_companies_entry_scraping_history](
	[id] [uniqueidentifier] NOT NULL,
	[id_sis_linkedin_directory_of_companies_entry] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
 CONSTRAINT [PK__sis_link__3213E83F456417BD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnyearsincurrentposition]    Script Date: 04/19/2022 15:42:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnyearsincurrentposition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnyearsincurrentposition](
	[id] [uniqueidentifier] NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[min] [numeric](18, 0) NOT NULL,
	[max] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK__lnyearsi__3213E83F0F11064F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lncompanysize]    Script Date: 04/19/2022 15:35:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lncompanysize]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lncompanysize](
	[id] [uniqueidentifier] NOT NULL,
	[code] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name_spanish] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[min] [numeric](18, 0) NOT NULL,
	[max] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_lncompanysize] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lncompanysize', N'COLUMN',N'code'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key value by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lncompanysize', @level2type=N'COLUMN',@level2name=N'code'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lncompanysize', N'COLUMN',N'name'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Company size  name by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lncompanysize', @level2type=N'COLUMN',@level2name=N'name'
GO
/****** Object:  Table [dbo].[lncompanytype]    Script Date: 04/19/2022 15:35:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lncompanytype]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lncompanytype](
	[id] [uniqueidentifier] NOT NULL,
	[code] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name_spanish] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_lncompanytype] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lncompanytype', N'COLUMN',N'code'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key value by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lncompanytype', @level2type=N'COLUMN',@level2name=N'code'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lncompanytype', N'COLUMN',N'name'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Company size  name by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lncompanytype', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lncompanytype', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'More Information: https://developer.linkedin.com/docs/fields/company-profile' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lncompanytype'
GO
/****** Object:  Table [dbo].[lngroupdirectoryentry]    Script Date: 04/19/2022 15:42:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lngroupdirectoryentry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lngroupdirectoryentry](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_lngroupdirectoryentry_parent] [uniqueidentifier] NULL,
	[url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[crawl_reservation_time] [datetime] NULL,
	[crawl_reservation_times] [numeric](18, 0) NULL,
	[crawl_start_time] [datetime] NULL,
	[crawl_end_time] [datetime] NULL,
	[crawl_denied] [bit] NULL,
 CONSTRAINT [PK__lngroupd__3213E83F1CA7377D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lngroupdirectoryentry]') AND name = N'IX_lngroupdirectoryentry__crawl_denied__crawl_reservation_id')
CREATE NONCLUSTERED INDEX [IX_lngroupdirectoryentry__crawl_denied__crawl_reservation_id] ON [dbo].[lngroupdirectoryentry] 
(
	[crawl_denied] ASC,
	[crawl_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lngroupdirectoryentry]') AND name = N'IX_lngroupdirectoryentry__crawl_denied__crawl_reservation_id__crawl_end_time__crawl_reservation_time')
CREATE NONCLUSTERED INDEX [IX_lngroupdirectoryentry__crawl_denied__crawl_reservation_id__crawl_end_time__crawl_reservation_time] ON [dbo].[lngroupdirectoryentry] 
(
	[crawl_denied] ASC,
	[crawl_reservation_id] ASC,
	[crawl_end_time] ASC,
	[crawl_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lngroup]    Script Date: 04/19/2022 15:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lngroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lngroup](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[crawl_reservation_time] [datetime] NULL,
	[crawl_start_time] [datetime] NULL,
	[crawl_end_time] [datetime] NULL,
	[crawl_reservation_times] [numeric](18, 0) NULL,
	[create_time] [datetime] NULL,
	[stat_members] [numeric](18, 0) NULL,
	[id_lngroupdirectoryentry] [uniqueidentifier] NULL,
	[crawl_denied] [bit] NULL,
	[create_date] [date] NULL,
	[website] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__lngroup__3213E83F1975C517] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lngroup]') AND name = N'IX_lngroup__code')
CREATE NONCLUSTERED INDEX [IX_lngroup__code] ON [dbo].[lngroup] 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lngroup]') AND name = N'IX_lngroup__crawl_denied__id')
CREATE NONCLUSTERED INDEX [IX_lngroup__crawl_denied__id] ON [dbo].[lngroup] 
(
	[crawl_denied] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lngroup]') AND name = N'IX_lngroup__crawl_reservation_id__crawl_denied')
CREATE NONCLUSTERED INDEX [IX_lngroup__crawl_reservation_id__crawl_denied] ON [dbo].[lngroup] 
(
	[crawl_reservation_id] ASC,
	[crawl_denied] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lngroup]') AND name = N'IX_lngroup__crawl_reservation_id__crawl_denied__create_time')
CREATE NONCLUSTERED INDEX [IX_lngroup__crawl_reservation_id__crawl_denied__create_time] ON [dbo].[lngroup] 
(
	[crawl_reservation_id] ASC,
	[crawl_denied] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pipeline]    Script Date: 04/19/2022 15:14:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pipeline]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pipeline](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[sync_stats_last_time] [datetime] NULL,
	[stat_ssm_pending_results] [numeric](18, 0) NULL,
	[stat_ssm_pending_premium_results] [numeric](18, 0) NULL,
	[id_lnusertemplate] [uniqueidentifier] NULL,
	[issues_check_last_time] [datetime] NULL,
	[workload] [int] NULL,
	[update_lnusertemplate_for_all_lnusers_request_time] [datetime] NULL,
	[gct_on_introduction_message] [bit] NULL,
	[last_notification_summary_time] [datetime] NULL,
	[disable_operators_to_manage_responses] [bit] NULL,
	[type] [int] NULL,
	[blast_planning_start_time] [datetime] NULL,
	[blast_planning_end_time] [datetime] NULL,
	[blast_planning_tries] [int] NULL,
	[blast_flood_start_time] [datetime] NULL,
	[blast_flood_end_time] [datetime] NULL,
	[blast_flood_tries] [int] NULL,
	[ats_tracking_mode] [int] NULL,
 CONSTRAINT [PK__pipeline__3213E83F48249246] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[message]    Script Date: 04/19/2022 15:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[message]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[message](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_lngroup] [uniqueidentifier] NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[trigger_type] [int] NULL,
	[trigger_param] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[status] [int] NULL,
	[delete_time] [datetime] NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_pipeline] [uniqueidentifier] NULL,
	[trigger_delay_days] [int] NULL,
	[stat_ssm_pending_results] [numeric](18, 0) NULL,
	[stat_ssm_pending_premium_results] [numeric](18, 0) NULL,
	[body_back_to_20190424] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[disabled_for_edition] [bit] NULL,
	[id_template] [uniqueidentifier] NULL,
	[gct] [bit] NULL,
 CONSTRAINT [PK__message__3213E83F6F0EB2D4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[message]') AND name = N'IX_message__id_pipeline__trigger_type__id')
CREATE NONCLUSTERED INDEX [IX_message__id_pipeline__trigger_type__id] ON [dbo].[message] 
(
	[id_pipeline] ASC,
	[trigger_type] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[message]') AND name = N'IX_message__trigger_type__id')
CREATE NONCLUSTERED INDEX [IX_message__trigger_type__id] ON [dbo].[message] 
(
	[trigger_type] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[message]') AND name = N'IX_message__trigger_type__id_pipeline__id')
CREATE NONCLUSTERED INDEX [IX_message__trigger_type__id_pipeline__id] ON [dbo].[message] 
(
	[trigger_type] ASC,
	[id_pipeline] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emlist]    Script Date: 04/19/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emlist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emlist](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[reminder] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[contact_information] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[stat_deliveries] [numeric](18, 0) NULL,
	[stat_opens] [numeric](18, 0) NULL,
	[stat_clicks] [numeric](18, 0) NULL,
	[stat_unsubscribes] [numeric](18, 0) NULL,
	[stat_bounces] [numeric](18, 0) NULL,
	[stat_complaints] [numeric](18, 0) NULL,
	[stat_subscribers] [numeric](18, 0) NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__emlist__3213E83F19FFD4FC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[campaign]    Script Date: 04/19/2022 15:26:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[campaign]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[campaign](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[subject] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[create_time] [datetime] NULL,
	[status] [numeric](18, 0) NULL,
	[approved] [numeric](18, 0) NULL,
	[id_lngroup] [uniqueidentifier] NULL,
	[sender_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[sender_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_deliveries] [numeric](18, 0) NULL,
	[smtp_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_user] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_sender_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__campaign__3213E83F0FEC5ADD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crmlist]    Script Date: 04/19/2022 15:21:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmlist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmlist](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__crmlist__3213E83F231F2AE2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[search]    Script Date: 04/19/2022 15:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search](
	[id] [uniqueidentifier] NOT NULL,
	[keyword] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_lnindustry_drop_me] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[status] [numeric](18, 0) NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_campaign] [uniqueidentifier] NULL,
	[stat_allocations] [numeric](18, 0) NULL,
	[avoid_variations_by_industry] [bit] NULL,
	[avoid_variations_by_firstname] [bit] NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[gender] [numeric](1, 0) NULL,
	[id_crmlist] [uniqueidentifier] NULL,
	[stat_results] [numeric](18, 0) NULL,
	[stat_linkedinresults] [numeric](18, 0) NULL,
	[stat_last_allocate_liappend4_to_em_time] [datetime] NULL,
	[stat_last_allocate_liappend4_to_crm_time] [datetime] NULL,
	[id_message] [uniqueidentifier] NULL,
	[id_lncompanysize_drop_me] [uniqueidentifier] NULL,
	[flood_reservation_id] [uniqueidentifier] NULL,
	[flood_reservation_time] [datetime] NULL,
	[flood_reservation_times] [numeric](18, 0) NULL,
	[flood_start_time] [datetime] NULL,
	[flood_end_time] [datetime] NULL,
	[id_lncompanytype_drop_me] [uniqueidentifier] NULL,
	[id_lnyearsincurrentposition_drop_me] [uniqueidentifier] NULL,
	[sync_stats_last_time] [datetime] NULL,
	[stat_ssm_pending_results] [numeric](18, 0) NULL,
	[stat_ssm_pending_premium_results] [numeric](18, 0) NULL,
	[ttipiskka_start_time] [datetime] NULL,
	[ttipiskka_end_time] [datetime] NULL,
	[ttipiskka_reservation_times] [numeric](18, 0) NULL,
	[ttipiskka_description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_linkedinscope] [numeric](18, 0) NULL,
	[stat_sls_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_sns_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[recently_posted_on_linkedin] [bit] NULL,
	[type] [int] NULL,
	[flood_scope] [varchar](50) COLLATE Traditional_Spanish_CI_AS NULL,
	[flood_id_pipeline] [uniqueidentifier] NULL,
	[flood_volume] [bigint] NULL,
 CONSTRAINT [PK_lnsearch] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[search]') AND name = N'IX_search__delete_time__status__id__id_user')
CREATE NONCLUSTERED INDEX [IX_search__delete_time__status__id__id_user] ON [dbo].[search] 
(
	[delete_time] ASC,
	[status] ASC,
	[id] ASC,
	[id_user] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[search]') AND name = N'IX_search__id_user')
CREATE NONCLUSTERED INDEX [IX_search__id_user] ON [dbo].[search] 
(
	[id_user] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[search]') AND name = N'IX_search__id_user__id')
CREATE NONCLUSTERED INDEX [IX_search__id_user__id] ON [dbo].[search] 
(
	[id_user] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'search', N'COLUMN',N'keyword'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Keyword which must appear in the LinkedIn profiles found by this search.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'search', @level2type=N'COLUMN',@level2name=N'keyword'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'search', N'COLUMN',N'id_lnindustry_drop_me'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Industry which must be assigned to the LinkedIn profiles found by this search.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'search', @level2type=N'COLUMN',@level2name=N'id_lnindustry_drop_me'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'search', N'COLUMN',N'create_time'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time when this search was created.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'search', @level2type=N'COLUMN',@level2name=N'create_time'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'search', N'COLUMN',N'delete_time'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Data and time when this search was deleted. Deleted searches cannot run.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'search', @level2type=N'COLUMN',@level2name=N'delete_time'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'search', N'COLUMN',N'id_user'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User who created this search.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'search', @level2type=N'COLUMN',@level2name=N'id_user'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'search', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Search of Linkedin Public profiles. It doesn''t represent the search action. It''s a template of many searches will be made.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'search'
GO
/****** Object:  Table [dbo].[signaljob]    Script Date: 04/19/2022 15:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[signaljob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[signaljob](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[job_type] [int] NOT NULL,
	[incrawl_start_time] [datetime] NULL,
	[incrawl_end_time] [datetime] NULL,
	[incrawl_tries] [int] NULL,
	[incrawl_success] [bit] NULL,
	[incrawl_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[total_pages] [int] NULL,
	[scraped_pages] [int] NULL,
	[scraped_results] [bigint] NULL,
 CONSTRAINT [PK__signaljo__3213E83F34690255] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[searchkeyword]    Script Date: 04/19/2022 15:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[searchkeyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[searchkeyword](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[keyword] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[apply_to_whole_profile] [bit] NOT NULL,
	[apply_to_current_job_title] [bit] NOT NULL,
	[apply_to_past_job_title] [bit] NOT NULL,
	[is_negative] [bit] NOT NULL,
	[is_extra_keyword] [bit] NULL,
	[apply_to_current_company_name] [bit] NULL,
	[apply_to_past_company_name] [bit] NULL,
 CONSTRAINT [PK__lnsearch__3213E83F5006DFF2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_search]    Script Date: 04/19/2022 15:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_search]'))
EXEC dbo.sp_executesql @statement = N'
create view [dbo].[v_search] as
select [id], create_time, delete_time, id_user, status
from search;
'
GO
/****** Object:  View [dbo].[v_user]    Script Date: 04/19/2022 15:06:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_user]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_user] as
select [id], id_client, create_time, delete_time
from [user];

'
GO
/****** Object:  Table [dbo].[user_feedback]    Script Date: 04/19/2022 15:06:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[user_feedback]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[user_feedback](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user_from] [uniqueidentifier] NOT NULL,
	[id_user_to] [uniqueidentifier] NOT NULL,
	[rate] [int] NOT NULL,
	[feedback] [text] COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__user_fee__3213E83F4550C93E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[user_config_history]    Script Date: 04/19/2022 15:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[user_config_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[user_config_history](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[value_string] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[value_int] [int] NULL,
	[value_float] [float] NULL,
	[value_bool] [bit] NULL,
	[type] [int] NULL,
 CONSTRAINT [PK__user_con__3213E83F2D578402] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_config]    Script Date: 04/19/2022 15:06:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[user_config]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[user_config](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[value_string] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[value_int] [int] NULL,
	[value_float] [float] NULL,
	[value_bool] [bit] NULL,
	[type] [int] NULL,
 CONSTRAINT [PK__user_con__3213E83F279EAAAC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_user_config__id__name] UNIQUE NONCLUSTERED 
(
	[id] ASC,
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[thread]    Script Date: 04/19/2022 15:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[thread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[thread](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[id_user_from] [uniqueidentifier] NULL,
	[subject] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[regarding_class_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[regarding_object_id] [uniqueidentifier] NOT NULL,
	[status] [int] NULL,
	[alert_code] [int] NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__thread__3213E83F61413C5C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[thread_status_change]    Script Date: 04/19/2022 15:07:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[thread_status_change]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[thread_status_change](
	[id] [uniqueidentifier] NOT NULL,
	[id_thread] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[status_from] [int] NULL,
	[status_to] [int] NULL,
	[description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__thread_s__3213E83F6BBECACF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[thread_recipient]    Script Date: 04/19/2022 15:07:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[thread_recipient]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[thread_recipient](
	[id] [uniqueidentifier] NOT NULL,
	[id_thread] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
 CONSTRAINT [PK__thread_r__3213E83F6605F179] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[thread_post]    Script Date: 04/19/2022 15:07:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[thread_post]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[thread_post](
	[id] [uniqueidentifier] NOT NULL,
	[id_thread] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__thread_p__3213E83F7177A425] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sample_search]    Script Date: 04/19/2022 15:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sample_search]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sample_search](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[industry_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[positions] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[location_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__sample_s__3213E83F1A68DA9F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sample_get_data]    Script Date: 04/19/2022 15:07:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sample_get_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sample_get_data](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_liprofile] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__sample_g__3213E83F1F2D8FBC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[resultreminderhistory]    Script Date: 04/19/2022 15:07:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[resultreminderhistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[resultreminderhistory](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_resultreminder] [uniqueidentifier] NOT NULL,
	[done_time] [datetime] NULL,
	[done_by_id_user] [uniqueidentifier] NULL,
 CONSTRAINT [PK__resultre__3213E83F4F4287B2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnlocation]    Script Date: 04/19/2022 15:49:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnlocation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnlocation](
	[id] [uniqueidentifier] NOT NULL,
	[code] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[relevance] [numeric](18, 0) NULL,
	[name_spanish] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_lncountry] [uniqueidentifier] NULL,
	[allowed_for_incrawl] [bit] NULL,
	[allowed_for_incrawl_lnsearchvariation] [bit] NULL,
	[new_codification] [bit] NULL,
	[old_code] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[type] [int] NULL,
 CONSTRAINT [PK_lnlocation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnlocation]') AND name = N'IX_lnlocation__relevance')
CREATE NONCLUSTERED INDEX [IX_lnlocation__relevance] ON [dbo].[lnlocation] 
(
	[relevance] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnlocation]') AND name = N'IX_lnlocation__relevance_desc')
CREATE NONCLUSTERED INDEX [IX_lnlocation__relevance_desc] ON [dbo].[lnlocation] 
(
	[relevance] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnlocation', N'COLUMN',N'code'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key value by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnlocation', @level2type=N'COLUMN',@level2name=N'code'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnlocation', N'COLUMN',N'name'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Location name by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnlocation', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnlocation', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Locations supported by LinkedIn. More information: https://developer.linkedin.com/docs/reference/geography-codes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnlocation'
GO
/****** Object:  Table [dbo].[lnsearchvariationblock]    Script Date: 04/19/2022 15:49:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnsearchvariationblock](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lnlocation] [uniqueidentifier] NOT NULL,
	[id_lnindustry] [uniqueidentifier] NULL,
	[incrawl_reservation_id] [uniqueidentifier] NULL,
	[incrawl_reservation_time] [datetime] NULL,
	[incrawl_reservation_times] [numeric](18, 0) NULL,
	[incrawl_start_time] [datetime] NULL,
	[incrawl_end_time] [datetime] NULL,
	[page] [numeric](18, 0) NULL,
	[results] [numeric](18, 0) NULL,
	[id_lnsearchvariationblock_parent] [uniqueidentifier] NULL,
	[incrawl_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[create_time] [datetime] NULL,
	[id_lnuser] [uniqueidentifier] NULL,
	[urgency] [bit] NULL,
	[split_start_time] [datetime] NULL,
	[split_end_time] [datetime] NULL,
	[ttipiskka_start_time] [datetime] NULL,
	[ttipiskka_end_time] [datetime] NULL,
	[ttipiskka_reservation_times] [numeric](18, 0) NULL,
	[ttipiskka_description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_sls_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_sns_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_expected_results] [numeric](18, 0) NULL,
	[stat_last_update_time] [datetime] NULL,
 CONSTRAINT [PK__lnsearch__3213E83F21A0DD40] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX__lnsearchvariationblock__id_lnindustry__id')
CREATE NONCLUSTERED INDEX [IX__lnsearchvariationblock__id_lnindustry__id] ON [dbo].[lnsearchvariationblock] 
(
	[id_lnindustry] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
ALTER INDEX [IX__lnsearchvariationblock__id_lnindustry__id] ON [dbo].[lnsearchvariationblock] DISABLE
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_lnsearch')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_lnsearch] ON [dbo].[lnsearchvariationblock] 
(
	[id_search] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_lnsearchvariationblock_parent')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_lnsearchvariationblock_parent] ON [dbo].[lnsearchvariationblock] 
(
	[id_lnsearchvariationblock_parent] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_search')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_search] ON [dbo].[lnsearchvariationblock] 
(
	[id_search] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_search__id_lnlocation__id_lnindustry')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_search__id_lnlocation__id_lnindustry] ON [dbo].[lnsearchvariationblock] 
(
	[id_search] ASC,
	[id_lnlocation] ASC,
	[id_lnindustry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_search__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_search__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times] ON [dbo].[lnsearchvariationblock] 
(
	[id_search] ASC,
	[incrawl_reservation_id] ASC,
	[incrawl_end_time] ASC,
	[incrawl_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_search__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times__results')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_search__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times__results] ON [dbo].[lnsearchvariationblock] 
(
	[id_search] ASC,
	[incrawl_reservation_id] ASC,
	[incrawl_end_time] ASC,
	[incrawl_reservation_times] ASC,
	[results] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_search__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times__urgency')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_search__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times__urgency] ON [dbo].[lnsearchvariationblock] 
(
	[id_search] ASC,
	[incrawl_reservation_id] ASC,
	[incrawl_end_time] ASC,
	[incrawl_reservation_times] ASC,
	[urgency] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__id_search__incrawl_reservation_id__urgency__id')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__id_search__incrawl_reservation_id__urgency__id] ON [dbo].[lnsearchvariationblock] 
(
	[id_search] ASC,
	[incrawl_reservation_id] ASC,
	[urgency] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__incrawl_reservation_id__incrawl_end_time__incrawl_reservation_times] ON [dbo].[lnsearchvariationblock] 
(
	[incrawl_reservation_id] ASC,
	[incrawl_end_time] ASC,
	[incrawl_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__results__ttipiskka_reservation_times__ttipiskka_end_time__id_lnlocation__id_lnindustry')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__results__ttipiskka_reservation_times__ttipiskka_end_time__id_lnlocation__id_lnindustry] ON [dbo].[lnsearchvariationblock] 
(
	[results] ASC,
	[ttipiskka_reservation_times] ASC,
	[ttipiskka_end_time] ASC,
	[id_lnlocation] ASC,
	[id_lnindustry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__stat_expected_results__stat_last_update_time')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__stat_expected_results__stat_last_update_time] ON [dbo].[lnsearchvariationblock] 
(
	[stat_expected_results] ASC,
	[stat_last_update_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]') AND name = N'IX_lnsearchvariationblock__stat_last_update_time')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock__stat_last_update_time] ON [dbo].[lnsearchvariationblock] 
(
	[stat_last_update_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[result]    Script Date: 04/19/2022 15:19:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[result](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NULL,
	[append4_allocation_to_em_time] [datetime] NULL,
	[stat_company_has_website] [bit] NULL,
	[stat_profile_append4_initialized] [bit] NULL,
	[stat_lncompany_has_website_initialized] [bit] NULL,
	[issue689_delete_me] [bit] NULL,
	[id_lnsearchvariationblock] [uniqueidentifier] NULL,
	[stat_profile_append7_urgency] [bit] NULL,
	[ininvite_reservation_id] [uniqueidentifier] NULL,
	[ininvite_reservation_time] [datetime] NULL,
	[ininvite_reservation_times] [int] NULL,
	[ininvite_start_time] [datetime] NULL,
	[ininvite_end_time] [datetime] NULL,
	[ininvite_result] [int] NULL,
	[ininvite_hit] [int] NULL,
	[inmessage_reservation_id] [uniqueidentifier] NULL,
	[inmessage_reservation_time] [datetime] NULL,
	[inmessage_reservation_times] [int] NULL,
	[inmessage_start_time] [datetime] NULL,
	[inmessage_end_time] [datetime] NULL,
	[ininvite_hit_time] [datetime] NULL,
	[append4_allocation_to_crm_time] [datetime] NULL,
	[processing_997_1_end_time] [datetime] NULL,
	[processing_997_2_end_time] [datetime] NULL,
	[processing_997_3_end_time] [datetime] NULL,
	[processing_997_4_end_time] [datetime] NULL,
	[premium] [int] NULL,
	[open_profile] [int] NULL,
	[aux_add_to_movement] [bit] NULL,
	[processed] [bit] NULL,
	[blast_id_lnuser] [uniqueidentifier] NULL,
	[crowdtrust_id_lnuser] [uniqueidentifier] NULL,
 CONSTRAINT [PK__lisearch__3213E83F7740A8A4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__id_liprofile')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__id_liprofile] ON [dbo].[result] 
(
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__id_liprofile__id_lnsearch')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__id_liprofile__id_lnsearch] ON [dbo].[result] 
(
	[id_profile] ASC,
	[id_search] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__id_lnsearch__id_liprofile')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__id_lnsearch__id_liprofile] ON [dbo].[result] 
(
	[id_search] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__ininvite_reservation_id')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__ininvite_reservation_id] ON [dbo].[result] 
(
	[ininvite_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__ininvite_reservation_id__ininvite_reservation_times')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__ininvite_reservation_id__ininvite_reservation_times] ON [dbo].[result] 
(
	[ininvite_reservation_id] ASC,
	[ininvite_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__inmessage_end_time__desc')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__inmessage_end_time__desc] ON [dbo].[result] 
(
	[inmessage_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__inmessage_end_time__inmessage_reservation_id')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__inmessage_end_time__inmessage_reservation_id] ON [dbo].[result] 
(
	[inmessage_end_time] ASC,
	[inmessage_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__stat_liprofile_append4_initialized')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__stat_liprofile_append4_initialized] ON [dbo].[result] 
(
	[stat_profile_append4_initialized] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_lisearchresult__stat_lncompany_has_website_initialized')
CREATE NONCLUSTERED INDEX [IX_lisearchresult__stat_lncompany_has_website_initialized] ON [dbo].[result] 
(
	[stat_lncompany_has_website_initialized] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__aux_add_to_movement')
CREATE NONCLUSTERED INDEX [IX_result__aux_add_to_movement] ON [dbo].[result] 
(
	[aux_add_to_movement] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_lnsearch__id_profile')
CREATE NONCLUSTERED INDEX [IX_result__id_lnsearch__id_profile] ON [dbo].[result] 
(
	[id_search] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_profile')
CREATE NONCLUSTERED INDEX [IX_result__id_profile] ON [dbo].[result] 
(
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search')
CREATE NONCLUSTERED INDEX [IX_result__id_search] ON [dbo].[result] 
(
	[id_search] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__create_time')
CREATE NONCLUSTERED INDEX [IX_result__id_search__create_time] ON [dbo].[result] 
(
	[id_search] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__create_time__id')
CREATE NONCLUSTERED INDEX [IX_result__id_search__create_time__id] ON [dbo].[result] 
(
	[id_search] ASC,
	[create_time] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_result__id_search__create_time_desc] ON [dbo].[result] 
(
	[id_search] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__id')
CREATE NONCLUSTERED INDEX [IX_result__id_search__id] ON [dbo].[result] 
(
	[id_search] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__id__create_time')
CREATE NONCLUSTERED INDEX [IX_result__id_search__id__create_time] ON [dbo].[result] 
(
	[id_search] ASC,
	[id] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__id_profile')
CREATE NONCLUSTERED INDEX [IX_result__id_search__id_profile] ON [dbo].[result] 
(
	[id_search] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__id_profile__ininvite_reservation_id')
CREATE NONCLUSTERED INDEX [IX_result__id_search__id_profile__ininvite_reservation_id] ON [dbo].[result] 
(
	[id_search] ASC,
	[id_profile] ASC,
	[ininvite_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_result__id_search__ininvite_end_time] ON [dbo].[result] 
(
	[id_search] ASC,
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__ininvite_end_time__ininvite_reservation_time')
CREATE NONCLUSTERED INDEX [IX_result__id_search__ininvite_end_time__ininvite_reservation_time] ON [dbo].[result] 
(
	[id_search] ASC,
	[ininvite_end_time] ASC,
	[ininvite_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__ininvite_end_time__ininvite_reservation_time__open_profile')
CREATE NONCLUSTERED INDEX [IX_result__id_search__ininvite_end_time__ininvite_reservation_time__open_profile] ON [dbo].[result] 
(
	[id_search] ASC,
	[ininvite_end_time] ASC,
	[ininvite_reservation_time] ASC,
	[open_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__ininvite_end_time__ininvite_reservation_time__premium')
CREATE NONCLUSTERED INDEX [IX_result__id_search__ininvite_end_time__ininvite_reservation_time__premium] ON [dbo].[result] 
(
	[id_search] ASC,
	[ininvite_end_time] ASC,
	[ininvite_reservation_time] ASC,
	[premium] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__ininvite_reservation_id__ininvite_reservation_times')
CREATE NONCLUSTERED INDEX [IX_result__id_search__ininvite_reservation_id__ininvite_reservation_times] ON [dbo].[result] 
(
	[id_search] ASC,
	[ininvite_reservation_id] ASC,
	[ininvite_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__id_search__ininvite_reservation_times')
CREATE NONCLUSTERED INDEX [IX_result__id_search__ininvite_reservation_times] ON [dbo].[result] 
(
	[id_search] ASC,
	[ininvite_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_result__ininvite_end_time] ON [dbo].[result] 
(
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__ininvite_reservation_id__ininvite_end_time__id_profile')
CREATE NONCLUSTERED INDEX [IX_result__ininvite_reservation_id__ininvite_end_time__id_profile] ON [dbo].[result] 
(
	[ininvite_reservation_id] ASC,
	[ininvite_end_time] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__ininvite_reservation_id__ininvite_end_time__ininvite_reservation_time')
CREATE NONCLUSTERED INDEX [IX_result__ininvite_reservation_id__ininvite_end_time__ininvite_reservation_time] ON [dbo].[result] 
(
	[ininvite_reservation_id] ASC,
	[ininvite_end_time] ASC,
	[ininvite_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__processed')
CREATE NONCLUSTERED INDEX [IX_result__processed] ON [dbo].[result] 
(
	[processed] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__processing_997_1_end_time')
CREATE NONCLUSTERED INDEX [IX_result__processing_997_1_end_time] ON [dbo].[result] 
(
	[processing_997_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__processing_997_2_end_time')
CREATE NONCLUSTERED INDEX [IX_result__processing_997_2_end_time] ON [dbo].[result] 
(
	[processing_997_2_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__processing_997_3_end_time')
CREATE NONCLUSTERED INDEX [IX_result__processing_997_3_end_time] ON [dbo].[result] 
(
	[processing_997_3_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[result]') AND name = N'IX_result__processing_997_4_end_time')
CREATE NONCLUSTERED INDEX [IX_result__processing_997_4_end_time] ON [dbo].[result] 
(
	[processing_997_4_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resultreminder]    Script Date: 04/19/2022 15:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[resultreminder]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[resultreminder](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_result] [uniqueidentifier] NOT NULL,
	[reminder_time] [datetime] NOT NULL,
	[comment] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[done_time] [datetime] NULL,
	[done_by_id_user] [uniqueidentifier] NULL,
	[notification_start_time] [datetime] NULL,
	[notification_end_time] [datetime] NULL,
	[notification_tries] [int] NULL,
	[notification_result] [bit] NULL,
	[notification_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__resultre__3213E83F48958A23] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[uploadedpicture]    Script Date: 04/19/2022 15:07:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uploadedpicture]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[uploadedpicture](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[upload_time] [datetime] NOT NULL,
	[filename] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[new_filename] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tracking_pixel]    Script Date: 04/19/2022 15:08:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tracking_pixel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tracking_pixel](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[delete_time] [datetime] NULL,
	[stat_visits] [bigint] NULL,
	[stat_signups] [bigint] NULL,
	[stat_revenue] [numeric](32, 6) NULL,
	[stat_unique_visits] [bigint] NULL,
	[stat_unique_signups] [bigint] NULL,
	[commission] [float] NOT NULL,
 CONSTRAINT [PK__tracking__3213E83F690259B5] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tracking_pixel_stats]    Script Date: 04/19/2022 15:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tracking_pixel_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tracking_pixel_stats](
	[id] [uniqueidentifier] NOT NULL,
	[id_tracking_pixel] [uniqueidentifier] NOT NULL,
	[id_affiliate] [uniqueidentifier] NULL,
	[tag] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[visits] [bigint] NULL,
	[signups] [bigint] NULL,
	[revenue] [numeric](32, 6) NULL,
	[unique_visits] [bigint] NULL,
	[unique_signups] [bigint] NULL,
 CONSTRAINT [PK__tracking__3213E83F74740C61] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_id_tracking_pixel] UNIQUE NONCLUSTERED 
(
	[id_tracking_pixel] ASC,
	[id_affiliate] ASC,
	[tag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tracking_pixel_stats]') AND name = N'IX_tracking_pixel_stats__id_tracking_pixel')
CREATE NONCLUSTERED INDEX [IX_tracking_pixel_stats__id_tracking_pixel] ON [dbo].[tracking_pixel_stats] 
(
	[id_tracking_pixel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tracking_pixel_stats]') AND name = N'IX_tracking_pixel_stats__id_tracking_pixel__id_affiliate__tag')
CREATE NONCLUSTERED INDEX [IX_tracking_pixel_stats__id_tracking_pixel__id_affiliate__tag] ON [dbo].[tracking_pixel_stats] 
(
	[id_tracking_pixel] ASC,
	[id_affiliate] ASC,
	[tag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tracking_pixel_visit]    Script Date: 04/19/2022 15:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tracking_pixel_visit](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_tracking_pixel] [uniqueidentifier] NOT NULL,
	[visitor_public_ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_result] [uniqueidentifier] NULL,
	[id_affiliate] [uniqueidentifier] NULL,
	[tag] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[signup_email] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[revenue] [numeric](32, 6) NULL,
	[visitor_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__tracking__3213E83F6DC70ED2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]') AND name = N'IX_tracking_pixel_visit__id_affiliate__signup_email')
CREATE NONCLUSTERED INDEX [IX_tracking_pixel_visit__id_affiliate__signup_email] ON [dbo].[tracking_pixel_visit] 
(
	[id_affiliate] ASC,
	[signup_email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [tr_tracking_pixel_before_insert]    Script Date: 04/19/2022 15:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_tracking_pixel_before_insert]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_tracking_pixel_before_insert] ON [dbo].[tracking_pixel_visit] FOR INSERT
AS 
BEGIN
	--
	declare @n as integer;
	declare @id_tracking_pixel uniqueidentifier;
	declare @id_affiliate uniqueidentifier;
	declare @tag varchar(500);
	declare @signup_email varchar(8000);
	declare @visitor_id varchar(500);
	declare @new_visitor_id bigint;
	declare @new_signup_email bigint;

	declare @signups bigint;
	declare @revenue numeric(32, 6);

	-- valido que solo se inserte un registro a la vez
	select @n=count(*) from inserted;
	if @n>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot insert more than 1 record at once in the table tracking_pixel.'', 16, 1)
	end

	-- check if (id_tracking_pixel, id_affiliate, visitor_id) already exists in the snapshot
	select @n = count(*)
	from inserted i 
	join tracking_pixel_stats j with (nolock index(IX_tracking_pixel_stats__id_tracking_pixel__id_affiliate__tag)) ON (
		i.id_tracking_pixel=j.id_tracking_pixel and
		isnull(i.id_affiliate,i.id)=isnull(j.id_affiliate,i.id) and 
		isnull(i.tag,'''')=isnull(j.tag,'''')
	);

	-- map keys id_tracking_pixel
	select @id_tracking_pixel=i.id_tracking_pixel, @id_affiliate=i.id_affiliate, @tag=i.tag, @signup_email=i.signup_email, @visitor_id=i.visitor_id
	from inserted i;

	-- @singups will be 0 or 1, if there was a signup or not.
	select @signups=count(*)
	from inserted i
	where signup_email is not null;

	-- get the @revenue of the viist
	select @revenue=isnull(i.revenue, 0)
	from inserted i;

	-- @new_visitor_id will be 1 or 0, if it is a new visitor or not
	select @new_visitor_id=1-count(distinct i.visitor_id)
	from tracking_pixel_visit x with (nolock)
	join inserted i on (x.id_tracking_pixel=i.id_tracking_pixel and x.id<>i.id)
	where x.visitor_id=i.visitor_id;

	-- @new_signup_email will be 1 or 0, if it is a new signup_email
	set @new_signup_email = 0;
	if (@signup_email is not null)
	begin
		select @new_signup_email=1-count(distinct i.signup_email)
		from tracking_pixel_visit x with (nolock)
		join inserted i on (x.id_tracking_pixel=i.id_tracking_pixel and x.id<>i.id)
		where isnull(x.signup_email,'''')=isnull(i.signup_email,'''');
	end

	update tracking_pixel set 
		stat_visits=isnull(stat_visits,0)+1, 
		stat_signups=isnull(stat_signups,0)+@signups, 
		stat_revenue=isnull(stat_revenue,0)+@revenue,
		stat_unique_visits=isnull(stat_unique_visits,0)+@new_visitor_id, 
		stat_unique_signups=isnull(stat_unique_signups,0)+@new_signup_email
	where 
		id=@id_tracking_pixel;

	if (@n > 0)
	begin
		update tracking_pixel_stats set 
			visits=isnull(visits,0)+1, 
			signups=isnull(signups,0)+@signups, 
			revenue=isnull(revenue,0)+@revenue,
			unique_visits=isnull(unique_visits,0)+@new_visitor_id, 
			unique_signups=isnull(unique_signups,0)+@new_signup_email
		where 
			id_tracking_pixel=@id_tracking_pixel and
			isnull(id_affiliate,id)=isnull(@id_affiliate,id) and
			isnull(tag,'''')=isnull(@tag,'''');		
	end
	else
	begin
		insert into tracking_pixel_stats(id, id_tracking_pixel, id_affiliate, tag, visits, signups, revenue, unique_visits, unique_signups) 
		values 
		(newid(), @id_tracking_pixel, @id_affiliate, @tag, 1, @signups, @revenue, 1, @signups);
	end	
END;
'
GO
/****** Object:  Trigger [tr_resultreminder_before_update]    Script Date: 04/19/2022 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_resultreminder_before_update]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_resultreminder_before_update] ON [dbo].[resultreminder] FOR UPDATE
AS 
BEGIN
	--
	declare @n as integer;

	-- valido que solo se actualice un registro a la vez
	select @n=count(*) from inserted;
	if @n>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot update more than 1 record at once in the table resultreminder.'', 16, 1)
	end

	-- inserto en la table resultreminderhistory
	insert into resultreminderhistory 
	(id, create_time, id_resultreminder, done_time, done_by_id_user)
	select newid(), getdate(), i.id, i.done_time, i.done_by_id_user
	from inserted i;
END;
'
GO
/****** Object:  Trigger [tr_on_update_user_config]    Script Date: 04/19/2022 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_update_user_config]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_on_update_user_config] ON [dbo].[user_config]
AFTER UPDATE
AS
BEGIN
	INSERT INTO user_config_history(id, id_user, create_time, name, value_string, value_int, value_float, value_bool, [type])
	SELECT newid(), i.id_user, getdate(), i.name, i.value_string, i.value_int, i.value_float, i.value_bool, i.[type]
	FROM inserted i;
END;
'
GO
/****** Object:  Trigger [tr_on_insert_user_config]    Script Date: 04/19/2022 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_insert_user_config]'))
EXEC dbo.sp_executesql @statement = N'
/*
drop trigger tr_on_insert_user_config;
drop trigger tr_on_update_user_config;
*/

CREATE TRIGGER [dbo].[tr_on_insert_user_config] ON [dbo].[user_config]
AFTER INSERT
AS
BEGIN
	INSERT INTO user_config_history(id, id_user, create_time, name, value_string, value_int, value_float, value_bool, [type])
	SELECT newid(), i.id_user, getdate(), i.name, i.value_string, i.value_int, i.value_float, i.value_bool, i.[type]
	FROM inserted i;
END;
'
GO
/****** Object:  Table [dbo].[crmlead]    Script Date: 04/19/2022 15:21:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmlead]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmlead](
	[id] [uniqueidentifier] NOT NULL,
	[id_crmlist] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[first_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[last_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[comments] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[url_picture] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[source_table] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[source_id] [uniqueidentifier] NULL,
	[interested] [bit] NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__crmlead__3213E83F3A02903A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crmtask]    Script Date: 04/19/2022 15:21:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmtask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmtask](
	[id] [uniqueidentifier] NOT NULL,
	[id_crmlead] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[scheduled_time] [datetime] NOT NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[type] [numeric](18, 0) NOT NULL,
	[status] [numeric](18, 0) NOT NULL,
	[comment] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__crmtask__3213E83F77D17EC9] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[crmtaskcomment]    Script Date: 04/19/2022 15:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmtaskcomment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmtaskcomment](
	[id] [uniqueidentifier] NOT NULL,
	[id_crmtask] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[comment] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__crmtaskc__3213E83F409F0CD7] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[crmlistfilejob]    Script Date: 04/19/2022 15:21:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmlistfilejob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmlistfilejob](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NOT NULL,
	[generation_reservation_id] [uniqueidentifier] NULL,
	[generation_reservation_time] [datetime] NULL,
	[generation_reservation_times] [numeric](18, 0) NULL,
	[generation_last_ping_time] [datetime] NULL,
	[generation_start_time] [datetime] NULL,
	[generation_end_time] [datetime] NULL,
	[generation_success] [bit] NULL,
	[generation_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[generation_filename] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_leads_exported] [numeric](18, 0) NULL,
 CONSTRAINT [PK__crmlistf__3213E83F24B06D80] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crmdata]    Script Date: 04/19/2022 15:21:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmdata]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmdata](
	[id] [uniqueidentifier] NOT NULL,
	[id_crmlead] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__crmdata__3213E83F3FBB6990] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crmaccount]    Script Date: 04/19/2022 15:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmaccount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmaccount](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[size] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[revenue] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[url_logo] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[type] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[found_year] [numeric](4, 0) NULL,
	[comment] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[industry] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[source_id] [uniqueidentifier] NULL,
	[source_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[delete_time] [datetime] NULL,
	[website] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[source_table] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__crmaccou__3213E83F40D1C11F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crmlead_crmaccount]    Script Date: 04/19/2022 15:21:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmlead_crmaccount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmlead_crmaccount](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_crmlead] [uniqueidentifier] NOT NULL,
	[id_crmaccount] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__crmlead___3213E83F468A9A75] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[crmaccountdata]    Script Date: 04/19/2022 15:22:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[crmaccountdata]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[crmaccountdata](
	[id] [uniqueidentifier] NOT NULL,
	[id_crmaccount] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[type] [numeric](18, 0) NOT NULL,
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__crmaccou__3213E83F1D4455E2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cosmos_service]    Script Date: 04/19/2022 15:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cosmos_service]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cosmos_service](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[domain] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__cosmos_s__3213E83F3562BA1E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cosmos_credential]    Script Date: 04/19/2022 15:24:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cosmos_credential]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cosmos_credential](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[expiration_time] [datetime] NULL,
	[id_proxy] [uniqueidentifier] NOT NULL,
	[id_client] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[auth_ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[auth_user] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[auth_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__cosmos_c__3213E83F40D46CCA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cosmos_credential_service]    Script Date: 04/19/2022 15:22:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cosmos_credential_service]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cosmos_credential_service](
	[id] [uniqueidentifier] NOT NULL,
	[id_credential] [uniqueidentifier] NOT NULL,
	[id_service] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__cosmos_c__3213E83F468D4620] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[person]    Script Date: 04/19/2022 15:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[person]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[person](
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__person__3213E83F2C738AF2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[profile]    Script Date: 04/19/2022 15:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[profile](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[headline] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[title] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[abstract] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[append_lncompany_start_time] [datetime] NULL,
	[append_lncompany_end_time] [datetime] NULL,
	[id_company_from_headline] [uniqueidentifier] NULL,
	[id_company_from_title] [uniqueidentifier] NULL,
	[append1_bot_class_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_person] [uniqueidentifier] NULL,
	[location] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[industry] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[append6_reservation_id] [uniqueidentifier] NULL,
	[append6_reservation_time] [datetime] NULL,
	[append6_reservation_times] [numeric](18, 0) NULL,
	[append6_start_time] [datetime] NULL,
	[append6_end_time] [datetime] NULL,
	[append6_pattern00_reservation_id] [uniqueidentifier] NULL,
	[append6_pattern00_reservation_time] [datetime] NULL,
	[append6_pattern00_reservation_times] [numeric](18, 0) NULL,
	[append6_pattern00_start_time] [datetime] NULL,
	[append6_pattern00_end_time] [datetime] NULL,
	[append6_pattern01_reservation_id] [uniqueidentifier] NULL,
	[append6_pattern01_reservation_time] [datetime] NULL,
	[append6_pattern01_reservation_times] [numeric](18, 0) NULL,
	[append6_pattern01_start_time] [datetime] NULL,
	[append6_pattern01_end_time] [datetime] NULL,
	[append6_pattern02_reservation_id] [uniqueidentifier] NULL,
	[append6_pattern02_reservation_time] [datetime] NULL,
	[append6_pattern02_reservation_times] [numeric](18, 0) NULL,
	[append6_pattern02_start_time] [datetime] NULL,
	[append6_pattern02_end_time] [datetime] NULL,
	[append6_pattern03_reservation_id] [uniqueidentifier] NULL,
	[append6_pattern03_reservation_time] [datetime] NULL,
	[append6_pattern03_reservation_times] [numeric](18, 0) NULL,
	[append6_pattern03_start_time] [datetime] NULL,
	[append6_pattern03_end_time] [datetime] NULL,
	[append6_pattern04_reservation_id] [uniqueidentifier] NULL,
	[append6_pattern04_reservation_time] [datetime] NULL,
	[append6_pattern04_reservation_times] [numeric](18, 0) NULL,
	[append6_pattern04_start_time] [datetime] NULL,
	[append6_pattern04_end_time] [datetime] NULL,
	[stat_email_appeded] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_phone_appeded] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_address_appeded] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[incrawl_reservation_id] [uniqueidentifier] NULL,
	[incrawl_reservation_time] [datetime] NULL,
	[incrawl_reservation_times] [int] NULL,
	[incrawl_start_time] [datetime] NULL,
	[incrawl_end_time] [datetime] NULL,
	[premium] [int] NULL,
	[data_source] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[append4_bot_class_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[append7_bot_class_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[picture_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[crawl_reservation_time] [datetime] NULL,
	[crawl_reservation_times] [numeric](18, 0) NULL,
	[crawl_start_time] [datetime] NULL,
	[crawl_end_time] [datetime] NULL,
	[snapshot_reservation_id] [uniqueidentifier] NULL,
	[snapshot_reservation_time] [datetime] NULL,
	[snapshot_reservation_times] [numeric](18, 0) NULL,
	[snapshot_start_time] [datetime] NULL,
	[snapshot_end_time] [datetime] NULL,
	[open_profile] [int] NULL,
	[unsubscribed] [bit] NULL,
 CONSTRAINT [PK__liprofil__3213E83F737017C0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__append6_pattern00_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_liprofile__append6_pattern00_reservation_id__id] ON [dbo].[profile] 
(
	[append6_pattern00_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__append6_pattern01_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_liprofile__append6_pattern01_reservation_id__id] ON [dbo].[profile] 
(
	[append6_pattern01_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__append6_pattern02_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_liprofile__append6_pattern02_reservation_id__id] ON [dbo].[profile] 
(
	[append6_pattern02_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__append6_pattern03_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_liprofile__append6_pattern03_reservation_id__id] ON [dbo].[profile] 
(
	[append6_pattern03_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__append6_pattern04_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_liprofile__append6_pattern04_reservation_id__id] ON [dbo].[profile] 
(
	[append6_pattern04_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__id_domain__code')
CREATE NONCLUSTERED INDEX [IX_liprofile__id_domain__code] ON [dbo].[profile] 
(
	[id_domain] ASC,
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__id_lncompany_from_headline')
CREATE NONCLUSTERED INDEX [IX_liprofile__id_lncompany_from_headline] ON [dbo].[profile] 
(
	[id_company_from_headline] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__id_lncompany_from_title')
CREATE NONCLUSTERED INDEX [IX_liprofile__id_lncompany_from_title] ON [dbo].[profile] 
(
	[id_company_from_title] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__industry')
CREATE NONCLUSTERED INDEX [IX_liprofile__industry] ON [dbo].[profile] 
(
	[industry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_liprofile__name')
CREATE NONCLUSTERED INDEX [IX_liprofile__name] ON [dbo].[profile] 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__code')
CREATE NONCLUSTERED INDEX [IX_profile__code] ON [dbo].[profile] 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__crawl_reservation_id__crawl_end_time__crawl_reservation_time__crawl_reservation_times')
CREATE NONCLUSTERED INDEX [IX_profile__crawl_reservation_id__crawl_end_time__crawl_reservation_time__crawl_reservation_times] ON [dbo].[profile] 
(
	[crawl_reservation_id] ASC,
	[crawl_end_time] ASC,
	[crawl_reservation_time] ASC,
	[crawl_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__crawl_reservation_id__crawl_start_time__crawl_reservation_time')
CREATE NONCLUSTERED INDEX [IX_profile__crawl_reservation_id__crawl_start_time__crawl_reservation_time] ON [dbo].[profile] 
(
	[crawl_reservation_id] ASC,
	[crawl_start_time] ASC,
	[crawl_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__id_domain__crawl_reservation_id')
CREATE NONCLUSTERED INDEX [IX_profile__id_domain__crawl_reservation_id] ON [dbo].[profile] 
(
	[id_domain] ASC,
	[crawl_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__id_domain__create_time__id')
CREATE NONCLUSTERED INDEX [IX_profile__id_domain__create_time__id] ON [dbo].[profile] 
(
	[id_domain] ASC,
	[create_time] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__id_domain__headline')
CREATE NONCLUSTERED INDEX [IX_profile__id_domain__headline] ON [dbo].[profile] 
(
	[id_domain] ASC,
	[headline] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__id_domain__snapshot_reservation_id__crawl_end_time__crawl_reservation_times')
CREATE NONCLUSTERED INDEX [IX_profile__id_domain__snapshot_reservation_id__crawl_end_time__crawl_reservation_times] ON [dbo].[profile] 
(
	[id_domain] ASC,
	[snapshot_reservation_id] ASC,
	[crawl_end_time] ASC,
	[crawl_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__industry__headline')
CREATE NONCLUSTERED INDEX [IX_profile__industry__headline] ON [dbo].[profile] 
(
	[industry] ASC,
	[headline] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__industry__headline__location')
CREATE NONCLUSTERED INDEX [IX_profile__industry__headline__location] ON [dbo].[profile] 
(
	[industry] ASC,
	[headline] ASC,
	[location] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__name')
CREATE NONCLUSTERED INDEX [IX_profile__name] ON [dbo].[profile] 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__name__id')
CREATE NONCLUSTERED INDEX [IX_profile__name__id] ON [dbo].[profile] 
(
	[name] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profile]') AND name = N'IX_profile__snapshot_reservation_id__snapshot_start_time')
CREATE NONCLUSTERED INDEX [IX_profile__snapshot_reservation_id__snapshot_start_time] ON [dbo].[profile] 
(
	[snapshot_reservation_id] ASC,
	[snapshot_start_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[drl_minutely_stats]    Script Date: 04/19/2022 15:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[drl_minutely_stats](
	[id_client] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_result] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[ininvite_start_time] [datetime] NULL,
	[ininvite_end_time] [datetime] NULL,
	[ininvite_hit_time] [datetime] NULL,
	[inmessage_start_time] [datetime] NULL,
	[inmessage_end_time] [datetime] NULL,
	[inreply_time] [datetime] NULL,
	[inreply_positive] [int] NULL,
	[wlt_time] [datetime] NULL,
	[id_message_2] [uniqueidentifier] NULL,
	[id_message_1] [uniqueidentifier] NULL,
	[inmessage_1_start_time] [datetime] NULL,
	[inmessage_1_end_time] [datetime] NULL,
	[gct_1] [bit] NULL,
	[gct_2] [bit] NULL,
	[gct] [bit] NULL,
	[gct_1_id_user] [uniqueidentifier] NULL,
	[gct_2_id_user] [uniqueidentifier] NULL,
	[gct_id_user] [uniqueidentifier] NULL,
	[snapshot_time] [datetime] NULL,
	[searchable] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[industry] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[company] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[visit_time] [datetime] NULL,
	[click_time] [datetime] NULL,
	[create_time] [datetime] NULL,
	[mirror_time] [datetime] NULL,
 CONSTRAINT [UK_drl_minutely_stats__id_result__id_lnuser__id_message] UNIQUE NONCLUSTERED 
(
	[id_result] ASC,
	[id_lnuser] ASC,
	[id_message] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__create_time_desc] ON [dbo].[drl_minutely_stats] 
(
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__click_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__click_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[click_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__id_message_1__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__id_message_1__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[id_message_2] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__ininvite_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__ininvite_end_time_desc')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__ininvite_end_time_desc] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[ininvite_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__ininvite_hit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__ininvite_hit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[ininvite_hit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__inmessage_1_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__inmessage_1_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[inmessage_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__inmessage_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__inreply_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__inreply_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[ininvite_hit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__visit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__visit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[visit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_client__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_client__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_client] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__click_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__click_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[click_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__ininvite_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__ininvite_hit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__ininvite_hit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[ininvite_hit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__inmessage_1_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__inmessage_1_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[inmessage_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__inmessage_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__inreply_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__inreply_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[inreply_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__visit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__visit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[visit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_lnuser__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_lnuser__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_lnuser] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__click_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__click_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[click_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__id_message_1__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__id_message_1__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[id_message_2] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__ininvite_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__ininvite_hit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__ininvite_hit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[ininvite_hit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__inmessage_1_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__inmessage_1_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[inmessage_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__inmessage_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__visit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__visit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[visit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_1__click_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_1__click_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_1] ASC,
	[click_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_1__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_1__ininvite_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_2] ASC,
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_1__ininvite_hit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_1__ininvite_hit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_2] ASC,
	[ininvite_hit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_1__inmessage_1_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_1__inmessage_1_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_1] ASC,
	[inmessage_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_1__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_1__inmessage_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_2] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_1__visit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_1__visit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_1] ASC,
	[visit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_1__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_1__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_2] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_2__click_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_2__click_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_2] ASC,
	[click_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_2__inmessage_1_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_2__inmessage_1_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_2] ASC,
	[inmessage_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_message_2__visit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_message_2__visit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_message_2] ASC,
	[visit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__click_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__click_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[click_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__ininvite_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__ininvite_hit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__ininvite_hit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[ininvite_hit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__inmessage_1_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__inmessage_1_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[inmessage_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__inmessage_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__inreply_positive__inreply_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__inreply_positive__inreply_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[inreply_positive] ASC,
	[inreply_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__inreply_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__inreply_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[inreply_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__snapshot_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__snapshot_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[snapshot_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__visit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__visit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[visit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_pipeline__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_pipeline__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_pipeline] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_profile')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_profile] ON [dbo].[drl_minutely_stats] 
(
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_result__id_profile__id_search')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_result__id_profile__id_search] ON [dbo].[drl_minutely_stats] 
(
	[id_result] ASC,
	[id_profile] ASC,
	[id_search] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_search__click_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_search__click_time] ON [dbo].[drl_minutely_stats] 
(
	[id_search] ASC,
	[click_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_search__ininvite_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_search__ininvite_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_search] ASC,
	[ininvite_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_search__ininvite_hit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_search__ininvite_hit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_search] ASC,
	[ininvite_hit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_search__inmessage_1_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_search__inmessage_1_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_search] ASC,
	[inmessage_1_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_search__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_search__inmessage_end_time] ON [dbo].[drl_minutely_stats] 
(
	[id_search] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_search__visit_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_search__visit_time] ON [dbo].[drl_minutely_stats] 
(
	[id_search] ASC,
	[visit_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__id_search__wlt_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__id_search__wlt_time] ON [dbo].[drl_minutely_stats] 
(
	[id_search] ASC,
	[wlt_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__ininvite_end_time__id_client')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__ininvite_end_time__id_client] ON [dbo].[drl_minutely_stats] 
(
	[ininvite_end_time] ASC,
	[id_client] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__ininvite_end_time_desc')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__ininvite_end_time_desc] ON [dbo].[drl_minutely_stats] 
(
	[ininvite_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__ininvite_hit_time_desc')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__ininvite_hit_time_desc] ON [dbo].[drl_minutely_stats] 
(
	[ininvite_hit_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__ininvite_start_time__snapshot_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__ininvite_start_time__snapshot_time] ON [dbo].[drl_minutely_stats] 
(
	[ininvite_start_time] ASC,
	[snapshot_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__inmessage_1_end_time_desc')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__inmessage_1_end_time_desc] ON [dbo].[drl_minutely_stats] 
(
	[inmessage_1_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__inmessage_end_time_desc')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__inmessage_end_time_desc] ON [dbo].[drl_minutely_stats] 
(
	[inmessage_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__snapshot_time')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__snapshot_time] ON [dbo].[drl_minutely_stats] 
(
	[snapshot_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]') AND name = N'IX_drl_minutely_stats__wlt_time_desc')
CREATE NONCLUSTERED INDEX [IX_drl_minutely_stats__wlt_time_desc] ON [dbo].[drl_minutely_stats] 
(
	[wlt_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[updateDrlMinutelyStatsOnProfileModification]    Script Date: 04/19/2022 15:22:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[updateDrlMinutelyStatsOnProfileModification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[updateDrlMinutelyStatsOnProfileModification](@id_profile UNIQUEIDENTIFIER)
AS
BEGIN
	declare @rid uniqueidentifier;
	declare @uid uniqueidentifier;
	declare @mid uniqueidentifier;
	declare @pid uniqueidentifier;
	declare @cur cursor;

	-- get the id_profile
	SET @pid = @id_profile;

	-- iterate this profile in the snapshot, updating the searchable
	SET @cur = CURSOR FOR
	select x.id_result, x.id_lnuser, x.id_message 
	from drl_minutely_stats x with (nolock index(IX_drl_minutely_stats__id_profile)) 
	where x.id_profile=@pid;
	OPEN @cur;
	FETCH NEXT FROM @cur INTO @rid, @uid, @mid;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		exec [updateDrlMinutelyStatsOnChatModification] @rid, @uid, @mid;
		FETCH NEXT FROM @cur INTO @rid, @uid, @mid;
	END
	CLOSE @cur;	
	DEALLOCATE @cur;
END; -- PROC
' 
END
GO
/****** Object:  Table [dbo].[stat_balance]    Script Date: 04/19/2022 15:24:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stat_balance]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[stat_balance](
	[id_client] [uniqueidentifier] NOT NULL,
	[product_code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[amount] [numeric](18, 6) NOT NULL,
	[credits] [numeric](18, 0) NOT NULL,
 CONSTRAINT [UK_stat_movement__id_client__product_code] UNIQUE NONCLUSTERED 
(
	[id_client] ASC,
	[product_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[custom_plan]    Script Date: 04/19/2022 15:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[custom_plan]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[custom_plan](
	[id] [uniqueidentifier] NOT NULL,
	[id_client] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[type] [varchar](1) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[item_number] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[credits] [numeric](18, 0) NOT NULL,
	[fee] [numeric](18, 6) NOT NULL,
	[period] [numeric](18, 0) NOT NULL,
	[units] [varchar](1) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[trial_credits] [numeric](18, 0) NULL,
	[trial_fee] [numeric](18, 6) NULL,
	[trial_period] [numeric](18, 0) NULL,
	[trial_units] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[trial2_credits] [numeric](18, 0) NULL,
	[trial2_fee] [numeric](18, 6) NULL,
	[trial2_period] [numeric](18, 0) NULL,
	[trial2_units] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__custom_p__3213E83F779E8EB1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[buffer_paypal_notification]    Script Date: 04/19/2022 15:38:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[buffer_paypal_notification]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[buffer_paypal_notification](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[txn_type] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[subscr_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[last_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[residence_country] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mc_currency] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[item_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[amount1] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[business] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[amount3] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[recurring] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[verify_sign] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payer_status] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[test_ipn] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payer_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[first_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[receiver_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payer_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[invoice] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[reattempt] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[item_number] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[subscr_date] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[charset] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[notify_version] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[period1] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mc_amount1] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[period3] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mc_amount3] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[ipn_track_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[transaction_subject] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payment_date] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payment_gross] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payment_type] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[txn_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[receiver_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payment_status] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payment_fee] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[sync_reservation_id] [uniqueidentifier] NULL,
	[sync_reservation_time] [datetime] NULL,
	[sync_reservation_times] [numeric](18, 0) NULL,
	[sync_start_time] [datetime] NULL,
	[sync_end_time] [datetime] NULL,
	[sync_result] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__buffer_p__3213E83F740D3625] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[buffer_paypal_notification]') AND name = N'IX_buffer_paypal_notification__sync_end_time__txn_type__create_time')
CREATE NONCLUSTERED INDEX [IX_buffer_paypal_notification__sync_end_time__txn_type__create_time] ON [dbo].[buffer_paypal_notification] 
(
	[sync_end_time] ASC,
	[txn_type] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[paypal_subscription]    Script Date: 04/19/2022 15:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[paypal_subscription]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[paypal_subscription](
	[id] [uniqueidentifier] NOT NULL,
	[id_buffer_paypal_notification] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[id_client] [uniqueidentifier] NULL,
	[active] [bit] NOT NULL,
	[subscr_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[last_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[residence_country] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mc_currency] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[amount1] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[business] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[amount3] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[recurring] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[verify_sign] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payer_status] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[test_ipn] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payer_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[first_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[receiver_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[payer_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[invoice] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[reattempt] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[subscr_date] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[charset] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[notify_version] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[period1] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mc_amount1] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[period3] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mc_amount3] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[ipn_track_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_cencelation_notification_time] [datetime] NULL,
	[stat_creation_notification_time] [datetime] NULL,
 CONSTRAINT [PK__paypal_s__3213E83F0DFDADAD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[automation_check_24]    Script Date: 04/19/2022 15:24:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_24]'))
EXEC dbo.sp_executesql @statement = N'-- select top 10 client_name, edition_hours_ago, template_name, template_url from automation_check_20_21_22_23 order by edition_hours_ago

/*
 * Answering
 * Check24:�List of active clients for answering
 * 
**/
create view [dbo].[automation_check_24]
as
select c.id as client_id, c.name as client_name, -b.credits as accounts_assigned, min(u.create_time) as signup_time, count(distinct s.id) as active_subscriptions
from client c
join stat_balance b on ( c.id=b.id_client and b.product_code=''acc'' and isnull(b.credits,0)<0 )
join [user] u on c.id=u.id_client
left join paypal_subscription s on (c.id=s.id_client and isnull(s.active,0)=1)
group by c.id, c.name, b.credits;
'
GO
/****** Object:  View [dbo].[automation_check_01]    Script Date: 04/19/2022 15:26:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_01]'))
EXEC dbo.sp_executesql @statement = N'

/*
 * Searches Scraping
 * Check01: Scope Accuracy
 *
**/
create view [dbo].[automation_check_01]
as
select
	c.name as client_name, 
	u.email as user_creator, 
	s.create_time, 
	s.name as search_name, 
	s.stat_linkedinscope as scope, 
	s.stat_sns_url as sns_url, 
	''https://connectionsphere.com/edb/search?sid=''+cast(s.id as varchar(500)) as search_url
from search s with (nolock)
join [user] u with (nolock) on u.id=s.id_user
join client c with (nolock) on c.id=u.id_client
where s.stat_linkedinscope is not null;
'
GO
/****** Object:  Table [dbo].[emserver]    Script Date: 04/19/2022 15:26:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emserver]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emserver](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[smtp_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_sender_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_last_sync_time] [datetime] NULL,
	[dedicated_verification] [bit] NULL,
	[dkim_verification] [bit] NULL,
	[spf_verification] [bit] NULL,
	[installation_time] [datetime] NULL,
	[smtp_username] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[blacklists_verification] [bit] NULL,
	[blacklists_verification_time] [datetime] NULL,
	[blacklists_verification_description] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[dedicated_verification_time] [datetime] NULL,
	[dedicated_verification_description] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[dkim_verification_time] [datetime] NULL,
	[dkim_verification_description] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[spf_verification_time] [datetime] NULL,
	[spf_verification_description] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_sender_email_verification] [bit] NULL,
	[smtp_sender_email_verification_time] [datetime] NULL,
	[smtp_sender_email_verification_description] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[expiration_time] [datetime] NULL,
	[delete_time] [datetime] NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_sender_domain_expiration_time] [datetime] NULL,
	[delivery_reservation_id] [uniqueidentifier] NULL,
	[delivery_reservation_time] [datetime] NULL,
	[delivery_reservation_times] [numeric](18, 0) NULL,
	[delivery_start_time] [datetime] NULL,
	[delivery_end_time] [datetime] NULL,
 CONSTRAINT [PK__emserver__3213E83F60E75331] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_emlists]    Script Date: 04/19/2022 15:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_emlists]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_emlists] as
select u.id_client as id_client, l.id as id_emlist, l.name as [name], stat_subscribers, stat_deliveries, stat_opens, stat_clicks, stat_unsubscribes, stat_bounces, stat_complaints
from emlist l
join [user] u on u.id=l.id_user'
GO
/****** Object:  Table [dbo].[emsubscriber]    Script Date: 04/19/2022 15:28:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emsubscriber]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emsubscriber](
	[id] [uniqueidentifier] NOT NULL,
	[id_emlist] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[source_table] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[source_id] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
	[delete_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[verify_reservation_id] [uniqueidentifier] NULL,
	[verify_reservation_time] [datetime] NULL,
	[verify_reservation_times] [numeric](18, 0) NULL,
	[verify_start_time] [datetime] NULL,
	[verify_end_time] [datetime] NULL,
	[verify_result] [numeric](18, 0) NULL,
 CONSTRAINT [PK__emsubscr__3213E83F1EC48A19] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_emsubscriber__id_emlist__email] UNIQUE NONCLUSTERED 
(
	[id_emlist] ASC,
	[email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[emsubscriber]') AND name = N'IX_emsubscriber__email')
CREATE NONCLUSTERED INDEX [IX_emsubscriber__email] ON [dbo].[emsubscriber] 
(
	[email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emfollowup]    Script Date: 04/19/2022 15:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emfollowup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emfollowup](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__emfollow__3213E83F6DEC4894] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emcampaign]    Script Date: 04/19/2022 15:29:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emcampaign]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emcampaign](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_emlist] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[subject] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[from_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[from_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[track_opens] [bit] NOT NULL,
	[track_clicks] [bit] NOT NULL,
	[deliver_days] [numeric](18, 0) NULL,
	[deliver_on_sunday] [bit] NULL,
	[deliver_on_monday] [bit] NULL,
	[deliver_on_tuesday] [bit] NULL,
	[deliver_on_wednesday] [bit] NULL,
	[deliver_on_thursday] [bit] NULL,
	[deliver_on_friday] [bit] NULL,
	[deliver_on_saturday] [bit] NULL,
	[deliver_at_00] [bit] NULL,
	[deliver_at_01] [bit] NULL,
	[deliver_at_02] [bit] NULL,
	[deliver_at_03] [bit] NULL,
	[deliver_at_04] [bit] NULL,
	[deliver_at_05] [bit] NULL,
	[deliver_at_06] [bit] NULL,
	[deliver_at_07] [bit] NULL,
	[deliver_at_08] [bit] NULL,
	[deliver_at_09] [bit] NULL,
	[deliver_at_10] [bit] NULL,
	[deliver_at_11] [bit] NULL,
	[deliver_at_12] [bit] NULL,
	[deliver_at_13] [bit] NULL,
	[deliver_at_14] [bit] NULL,
	[deliver_at_15] [bit] NULL,
	[deliver_at_16] [bit] NULL,
	[deliver_at_17] [bit] NULL,
	[deliver_at_18] [bit] NULL,
	[deliver_at_19] [bit] NULL,
	[deliver_at_20] [bit] NULL,
	[deliver_at_21] [bit] NULL,
	[deliver_at_22] [bit] NULL,
	[deliver_at_23] [bit] NULL,
	[status] [bit] NULL,
	[approved] [bit] NULL,
	[body_with_tracking_links] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[id_emfollowup] [uniqueidentifier] NULL,
	[delivery_number] [numeric](18, 0) NULL,
	[id_lngroup] [uniqueidentifier] NULL,
	[id_emserver] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
	[avoid_unsubscribe_link] [bit] NULL,
	[track_replies] [bit] NULL,
	[verify_email_before_delivery] [bit] NULL,
 CONSTRAINT [PK__emcampai__3213E83F2E06CDA9] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emdeliveryjob]    Script Date: 04/19/2022 15:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emdeliveryjob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emdeliveryjob](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_emcampaign] [uniqueidentifier] NULL,
	[number_of_emails_requested] [numeric](18, 0) NOT NULL,
	[delivery_start_time] [datetime] NULL,
	[delivery_end_time] [datetime] NULL,
	[delivery_times] [numeric](18, 0) NULL,
	[stat_emails_sent] [numeric](18, 0) NULL,
	[delivery_result] [numeric](18, 0) NULL,
	[delivery_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[delivery_reservation_id] [uniqueidentifier] NULL,
	[delivery_reservation_time] [datetime] NULL,
	[delivery_reservation_times] [numeric](18, 0) NULL,
 CONSTRAINT [PK__emdelive__3213E83F2EC5E7B8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emdelivery]    Script Date: 04/19/2022 15:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emdelivery]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emdelivery](
	[id] [uniqueidentifier] NOT NULL,
	[id_emcampaign] [uniqueidentifier] NOT NULL,
	[id_emsubscriber] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delivery_time] [datetime] NULL,
	[smtp_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_user] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smtp_sender_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[subject] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[from_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[from_email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[track_opens] [bit] NOT NULL,
	[track_clicks] [bit] NOT NULL,
	[id_emdeliveryjob] [uniqueidentifier] NULL,
	[delivery_reservation_id] [uniqueidentifier] NULL,
	[delivery_reservation_time] [datetime] NULL,
	[delivery_reservation_times] [numeric](18, 0) NULL,
	[delivery_start_time] [datetime] NULL,
	[delivery_end_time] [datetime] NULL,
	[track_replies] [bit] NULL,
 CONSTRAINT [PK__emdelive__3213E83F33BFA6FF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[emdelivery]') AND name = N'IX_emdelivery__delivery_time__id_emsubscriber')
CREATE NONCLUSTERED INDEX [IX_emdelivery__delivery_time__id_emsubscriber] ON [dbo].[emdelivery] 
(
	[delivery_time] ASC,
	[id_emsubscriber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[emdelivery]') AND name = N'IX_emdelivery__id_emcampaign__id_emsubecriber')
CREATE NONCLUSTERED INDEX [IX_emdelivery__id_emcampaign__id_emsubecriber] ON [dbo].[emdelivery] 
(
	[id_emcampaign] ASC,
	[id_emsubscriber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[emdelivery]') AND name = N'IX_emdelivery__id_emsubscriber__id_emcampaign')
CREATE NONCLUSTERED INDEX [IX_emdelivery__id_emsubscriber__id_emcampaign] ON [dbo].[emdelivery] 
(
	[id_emsubscriber] ASC,
	[id_emcampaign] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[emdelivery]') AND name = N'IX_emdelivery__smtp_url__delivery_time')
CREATE NONCLUSTERED INDEX [IX_emdelivery__smtp_url__delivery_time] ON [dbo].[emdelivery] 
(
	[smtp_url] ASC,
	[delivery_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emunsubscribe]    Script Date: 04/19/2022 15:28:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emunsubscribe]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emunsubscribe](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_emdelivery] [uniqueidentifier] NULL,
 CONSTRAINT [PK__emunsubs__3213E83F627A95E8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [tr_emunsubscribe_after_insert]    Script Date: 04/19/2022 15:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_emunsubscribe_after_insert]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_emunsubscribe_after_insert] on [dbo].[emunsubscribe] after insert
as
begin
	declare @n as integer;
	declare @m as integer;
	declare @email as varchar(500);

	-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
	select @n=count(*) from inserted;

	-- valido que solo se inserte un registro
	if @n<>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot update more than 1 record at once in the table emunsubscribe.'', 16, 1);
		return;
	end	

	-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
	select @email=email from inserted;

	-- inicio la transaccion
	begin transaction;
	
	-- bloqueo los registros emlist vinculado a este suscriptor, para decrementar el contador de suscriptores
	select @m = COUNT(distinct l.id)
	from emlist l with (xlock) -- bloqueo el registro
	join emsubscriber b on (l.id=b.id_emlist and b.email=@email)

	-- actualizo stat_subscribers de las listas, y elimino el suscriptor
	if (@m>0)
	begin
		update emlist
		set stat_subscribers=isnull(stat_subscribers,0)-1 
		where id in (
			select distinct l.id
			from emlist l -- bloqueo el registro
			join emsubscriber b on (l.id=b.id_emlist and b.email=@email)
		);

		update emsubscriber
		set delete_time=getdate(), delete_description=''unsubscribed''
		where email=@email
	end; -- if (@m>0)


	-- finalizo la transaccion
	commit transaction;


end
'
GO
/****** Object:  Trigger [tr_emsubscriber_after_insert]    Script Date: 04/19/2022 15:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_emsubscriber_after_insert]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_emsubscriber_after_insert] on [dbo].[emsubscriber] after insert
as
begin
	declare @n as integer;
	declare @lid as uniqueidentifier;

	-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
	select @n=count(*) from inserted;

	-- valido que solo se inserte un registro
	if @n<>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot update more than 1 record at once in the table emsubscriber.'', 16, 1);
		return;
	end

	-- inicio la transaccion
	begin transaction;
	
	-- bloqueo el registro de la busqueda
	select @lid = l.id 
	from emlist l with (xlock) -- bloqueo el registro
	join inserted i on (l.id=i.id_emlist);

	update emlist set stat_subscribers=isnull(stat_subscribers,0)+1 where id=(select i.id_emlist from inserted i);

	-- finalizo la transaccion
	commit transaction;
end
'
GO
/****** Object:  Table [dbo].[searchallocationjob]    Script Date: 04/19/2022 15:27:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[searchallocationjob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[searchallocationjob](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
	[allocation_start_time] [datetime] NULL,
	[allocation_end_time] [datetime] NULL,
	[allocation_result] [int] NULL,
	[allocation_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[reset_result_append_allocation_to_em_time] [bit] NULL,
	[reset_result_append_allocation_to_crm_time] [bit] NULL,
	[stat_subscribers_allocated_to_em] [numeric](18, 0) NULL,
	[stat_leads_allocated_to_crm] [numeric](18, 0) NULL,
	[export_results_from_core_database_enabled] [bit] NULL,
	[export_results_from_core_database_number] [numeric](18, 0) NULL,
	[stat_exports_to_search_results] [numeric](18, 0) NULL,
 CONSTRAINT [PK__lnsearch__3213E83F09E968C4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emfielddef]    Script Date: 04/19/2022 15:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emfielddef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emfielddef](
	[id] [uniqueidentifier] NOT NULL,
	[id_emlist] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__emfieldd__3213E83F23893F36] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_emfielddef__id_emlist__name] UNIQUE NONCLUSTERED 
(
	[id_emlist] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emfield]    Script Date: 04/19/2022 15:28:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emfield]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emfield](
	[id] [uniqueidentifier] NOT NULL,
	[id_emsubscriber] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__emfield__3213E83F2942188C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[emfield]') AND name = N'IX_emfield__name__id_emsubscriber')
CREATE NONCLUSTERED INDEX [IX_emfield__name__id_emsubscriber] ON [dbo].[emfield] 
(
	[name] ASC,
	[id_emsubscriber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emreply]    Script Date: 04/19/2022 15:28:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emreply]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emreply](
	[id] [uniqueidentifier] NOT NULL,
	[id_emdelivery] [uniqueidentifier] NOT NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NOT NULL,
	[receive_time] [datetime] NOT NULL,
	[opened] [bit] NOT NULL,
	[positive] [bit] NOT NULL,
 CONSTRAINT [PK__emreply__3213E83F323F72C8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[emopen]    Script Date: 04/19/2022 15:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emopen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emopen](
	[id] [uniqueidentifier] NOT NULL,
	[id_emdelivery] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[opened] [bit] NULL,
 CONSTRAINT [PK__emopen__3213E83F30792600] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[emlink]    Script Date: 04/19/2022 15:30:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emlink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emlink](
	[id] [uniqueidentifier] NOT NULL,
	[id_emcampaign] [uniqueidentifier] NOT NULL,
	[number] [numeric](18, 0) NOT NULL,
	[url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__emlink__3213E83F4F67C174] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emclick]    Script Date: 04/19/2022 15:29:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[emclick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[emclick](
	[id] [uniqueidentifier] NOT NULL,
	[id_emlink] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_emsubscriber] [uniqueidentifier] NOT NULL,
	[id_emdelivery] [uniqueidentifier] NULL,
 CONSTRAINT [PK__emclick__3213E83F68336F3E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[v_emcampaigns]    Script Date: 04/19/2022 15:29:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_emcampaigns]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_emcampaigns] as
select u.id_client as id_client, c.id as id_emcampaign, c.name as [name], c.subject as subject, 0 as sent, 0 as open_ratio, 0 as click_ratio
from emcampaign c
join [user] u on u.id=c.id_user'
GO
/****** Object:  Table [dbo].[division]    Script Date: 04/19/2022 15:41:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[division]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[division](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[db_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[db_port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[db_user] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[db_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[ws_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[ws_port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[db_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[app_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[app_port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[available] [bit] NULL,
	[stat_syncronization_last_emunsubscribe_create_time] [datetime] NULL,
	[stat_syncronization_last_emopen_create_time] [datetime] NULL,
	[stat_syncronization_last_embounce_create_time] [datetime] NULL,
	[stat_syncronization_last_emclick_create_time] [datetime] NULL,
	[central] [bit] NOT NULL,
	[home] [bit] NOT NULL,
	[prospecting_check_outreach_performance_last_time] [datetime] NULL,
	[prospecting_check_pending_transfers_last_time] [datetime] NULL,
	[prospecting_check_farm_health_last_time] [datetime] NULL,
	[prospecting_check_new_messages_last_time] [datetime] NULL,
	[prospecting_check_pending_results_last_time] [datetime] NULL,
 CONSTRAINT [PK__division__3213E83F711DBAFA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_division__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[embounce]    Script Date: 04/19/2022 15:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[embounce]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[embounce](
	[id] [uniqueidentifier] NOT NULL,
	[email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[diagnosis] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[status] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[create_time] [datetime] NOT NULL,
	[id_division] [uniqueidentifier] NULL,
	[id_emdelivery] [uniqueidentifier] NULL,
	[bounce_time] [datetime] NULL,
	[message_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_emsubscriber] [uniqueidentifier] NULL,
	[soft] [bit] NULL,
 CONSTRAINT [PK__embounce__3213E83F7AA72534] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [tr_embounce_after_insert]    Script Date: 04/19/2022 15:50:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_embounce_after_insert]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tr_embounce_after_insert] on [dbo].[embounce] after insert
as
begin
	declare @n as integer;
	declare @m as integer;
	declare @k as integer; -- hard bounces
	declare @email as varchar(500);

	-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
	select @n=count(*) from inserted;

	-- valido que solo se inserte un registro
	if @n<>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot update more than 1 record at once in the table embounce.'', 16, 1);
		return;
	end	

	-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
	select @k=count(*) from inserted where isnull(soft,0)=0;


	-- elimino el suscriptor de la lista,
	-- solo si es un hard bounce
	if (@k>0)
	begin

		-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
		select @email=email from inserted;

		-- inicio la transaccion
		begin transaction;
	
		-- bloqueo los registros emlist vinculado a este suscriptor, para decrementar el contador de suscriptores
		select @m = COUNT(distinct l.id)
		from emlist l with (xlock) -- bloqueo el registro
		join emsubscriber b on (l.id=b.id_emlist and b.email=@email)

		-- actualizo stat_subscribers de las listas, y elimino el suscriptor
		if (@m>0)
		begin
			update emlist
			set stat_subscribers=isnull(stat_subscribers,0)-1 
			where id in (
				select distinct l.id
				from emlist l -- bloqueo el registro
				join emsubscriber b on (l.id=b.id_emlist and b.email=@email)
			);

			update emsubscriber
			set delete_time=getdate(), delete_description=''hard bounce''
			where email=@email
		end; -- if (@m>0)

	end; -- if (@k>0)

	-- finalizo la transaccion
	commit transaction;


end
'
GO
/****** Object:  Table [dbo].[embedded_link]    Script Date: 04/19/2022 15:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[embedded_link]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[embedded_link](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_tracking_pixel] [uniqueidentifier] NOT NULL,
	[description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__embedded__3213E83F00D9E346] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[em_minutely_stats]    Script Date: 04/19/2022 15:30:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[em_minutely_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[em_minutely_stats](
	[date] [date] NOT NULL,
	[hour] [numeric](2, 0) NOT NULL,
	[minute] [numeric](2, 0) NOT NULL,
	[datetime] [datetime] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_emcampaign] [uniqueidentifier] NULL,
	[smtp_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[smtp_port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[smtp_user] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[smtp_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[stat_deliveries] [numeric](18, 0) NULL,
	[stat_opens] [numeric](18, 0) NULL,
	[stat_clicks] [numeric](18, 0) NULL,
	[stat_unsubscribes] [numeric](18, 0) NULL,
	[stat_bounces] [numeric](18, 0) NULL,
	[stat_subscribes] [numeric](18, 0) NULL,
	[stat_complaints] [numeric](18, 0) NULL,
	[stat_removed] [numeric](18, 0) NULL,
	[stat_soft_bounces] [numeric](18, 0) NULL,
	[stat_hard_bounces] [numeric](18, 0) NULL,
	[stat_replies] [numeric](18, 0) NULL,
	[stat_positive_replies] [numeric](18, 0) NULL,
	[stat_unique_opens] [numeric](18, 0) NULL,
	[stat_unique_clicks] [numeric](18, 0) NULL,
	[stat_unique_bounces] [numeric](18, 0) NULL,
	[stat_unique_unsubscribes] [numeric](18, 0) NULL,
	[stat_unique_soft_bounces] [numeric](18, 0) NULL,
	[stat_unique_hard_bounces] [numeric](18, 0) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[host]    Script Date: 04/19/2022 15:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[host]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[host](
	[id] [uniqueidentifier] NOT NULL,
	[last_update_time] [datetime] NOT NULL,
	[cpu_architecture] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[cpu_speed] [numeric](18, 0) NOT NULL,
	[cpu_load_average] [numeric](18, 0) NOT NULL,
	[cpu_model] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[cpu_type] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[cpu_number] [numeric](18, 0) NOT NULL,
	[mem_total] [numeric](18, 0) NOT NULL,
	[mem_free] [numeric](18, 0) NOT NULL,
	[disk_total] [numeric](18, 0) NOT NULL,
	[disk_free] [numeric](18, 0) NOT NULL,
	[net_hostname] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[net_remote_ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[net_mac_address] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_client] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[stealth_browser_technology_code] [varchar](50) COLLATE Traditional_Spanish_CI_AS NULL,
	[ssh_username] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[ssh_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[ssh_port] [int] NULL,
	[allowed_for_farming] [bit] NULL,
 CONSTRAINT [PK__host__3213E83F55106FA1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hosthistory]    Script Date: 04/19/2022 15:32:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hosthistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[hosthistory](
	[id] [uniqueidentifier] NOT NULL,
	[id_host] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[cpu_architecture] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[cpu_speed] [numeric](18, 0) NOT NULL,
	[cpu_load_average] [numeric](18, 0) NOT NULL,
	[cpu_model] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[cpu_type] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[cpu_number] [numeric](18, 0) NOT NULL,
	[mem_total] [numeric](18, 0) NOT NULL,
	[mem_free] [numeric](18, 0) NOT NULL,
	[disk_total] [numeric](18, 0) NOT NULL,
	[disk_free] [numeric](18, 0) NOT NULL,
	[net_hostname] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[net_remote_ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[net_mac_address] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__hosthist__3213E83F59D524BE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hostalert]    Script Date: 04/19/2022 15:32:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hostalert]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[hostalert](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_host] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[status] [bit] NOT NULL,
	[threshold_cpu_load_average] [numeric](18, 0) NULL,
	[threshold_memory_load_average] [numeric](18, 0) NULL,
	[threshold_disk_load_average] [numeric](18, 0) NULL,
 CONSTRAINT [PK__hostaler__3213E83F5F8DFE14] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[forward_domain]    Script Date: 04/19/2022 15:33:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[forward_domain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[forward_domain](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[expiration_time] [datetime] NULL,
 CONSTRAINT [PK__forward___3213E83F7FFACDA6] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[forward_email]    Script Date: 04/19/2022 15:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[forward_email]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[forward_email](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_forward_domain] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[address] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[forward_to] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[test_reservation_id] [uniqueidentifier] NULL,
	[test_reservation_time] [datetime] NULL,
	[test_start_time] [datetime] NULL,
	[test_end_time] [datetime] NULL,
	[test_error_description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__forward___3213E83F04BF82C3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fl_invite]    Script Date: 04/19/2022 15:33:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_invite]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_invite](
	[ID] [int] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[first_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[last_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[email] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[creation_time] [datetime] NULL,
	[test_start_time] [datetime] NULL,
	[test_end_time] [datetime] NULL,
	[test_error_description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__fl_invit__3214EC27160A0A56] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fl_search]    Script Date: 04/19/2022 15:34:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_search]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_search](
	[ID] [int] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[creation_time] [datetime] NULL,
	[no_of_results] [int] NULL,
	[no_of_companies] [int] NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[saved] [bit] NOT NULL,
	[temp] [bit] NULL,
 CONSTRAINT [PK__fl_searc__3214EC27796DCBA8] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fl_search_position]    Script Date: 04/19/2022 15:33:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_search_position]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_search_position](
	[ID] [int] NOT NULL,
	[id_search] [int] NULL,
	[positive] [bit] NULL,
	[value] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__fl_searc__3214EC2711455539] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[company]    Script Date: 04/19/2022 15:17:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[company](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[website] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[url_logo] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[found_year] [numeric](18, 0) NULL,
	[address] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[specialities] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[crawl_start_time] [datetime] NULL,
	[crawl_end_time] [datetime] NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[deducted_website] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[crawl_reservation_time] [datetime] NULL,
	[crawl_reservation_times] [numeric](18, 0) NULL,
	[source_name] [varchar](50) COLLATE Traditional_Spanish_CI_AS NULL,
	[incrawl_allowed] [bit] NULL,
	[incrawl_reservation_id] [uniqueidentifier] NULL,
	[incrawl_reservation_ime] [datetime] NULL,
	[incrawl_reservation_times] [numeric](18, 0) NULL,
	[incrawl_start_time] [datetime] NULL,
	[incrawl_end_time] [datetime] NULL,
	[incrawl_reservation_time] [datetime] NULL,
	[data_source] [numeric](4, 0) NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[employees] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[revenue] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[ownership] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[picture_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_lncompany] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_company__crawl_reservation_id__website__deducted_website__id')
CREATE NONCLUSTERED INDEX [IX_company__crawl_reservation_id__website__deducted_website__id] ON [dbo].[company] 
(
	[crawl_reservation_id] ASC,
	[website] ASC,
	[deducted_website] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_company__id_domain__crawl_reservation_id')
CREATE NONCLUSTERED INDEX [IX_company__id_domain__crawl_reservation_id] ON [dbo].[company] 
(
	[id_domain] ASC,
	[crawl_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__code')
CREATE NONCLUSTERED INDEX [IX_lncompany__code] ON [dbo].[company] 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__crawl_end_time__website__name')
CREATE NONCLUSTERED INDEX [IX_lncompany__crawl_end_time__website__name] ON [dbo].[company] 
(
	[crawl_end_time] ASC,
	[website] ASC,
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__crawl_end_time__website__name_id')
CREATE NONCLUSTERED INDEX [IX_lncompany__crawl_end_time__website__name_id] ON [dbo].[company] 
(
	[crawl_end_time] ASC,
	[website] ASC,
	[name] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__crawl_reservation_id__crawl_end_time__crawl_reservation_time__crawl_reservation_times')
CREATE NONCLUSTERED INDEX [IX_lncompany__crawl_reservation_id__crawl_end_time__crawl_reservation_time__crawl_reservation_times] ON [dbo].[company] 
(
	[crawl_reservation_id] ASC,
	[crawl_end_time] ASC,
	[crawl_reservation_time] ASC,
	[crawl_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__crawl_reservation_id__crawl_end_time__crawl_reservation_times__crawl_reservation_time')
CREATE NONCLUSTERED INDEX [IX_lncompany__crawl_reservation_id__crawl_end_time__crawl_reservation_times__crawl_reservation_time] ON [dbo].[company] 
(
	[crawl_reservation_id] ASC,
	[crawl_end_time] ASC,
	[crawl_reservation_times] ASC,
	[crawl_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__crawl_reservation_id__crawl_end_time__crawl_reservation_times__crawl_reservation_time__id')
CREATE NONCLUSTERED INDEX [IX_lncompany__crawl_reservation_id__crawl_end_time__crawl_reservation_times__crawl_reservation_time__id] ON [dbo].[company] 
(
	[crawl_reservation_id] ASC,
	[crawl_end_time] ASC,
	[crawl_reservation_times] ASC,
	[crawl_reservation_time] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__crawl_reservation_id__crawl_start_time')
CREATE NONCLUSTERED INDEX [IX_lncompany__crawl_reservation_id__crawl_start_time] ON [dbo].[company] 
(
	[crawl_reservation_id] ASC,
	[crawl_start_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__crawl_reservation_id__crawl_start_time__crawl_reservation_time')
CREATE NONCLUSTERED INDEX [IX_lncompany__crawl_reservation_id__crawl_start_time__crawl_reservation_time] ON [dbo].[company] 
(
	[crawl_reservation_id] ASC,
	[crawl_start_time] ASC,
	[crawl_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__id__crawl_end_time__website__name_id')
CREATE NONCLUSTERED INDEX [IX_lncompany__id__crawl_end_time__website__name_id] ON [dbo].[company] 
(
	[id] ASC,
	[crawl_end_time] ASC,
	[website] ASC,
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__incrawl_reservation_id__incrawl_start_time')
CREATE NONCLUSTERED INDEX [IX_lncompany__incrawl_reservation_id__incrawl_start_time] ON [dbo].[company] 
(
	[incrawl_reservation_id] ASC,
	[incrawl_start_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__name')
CREATE NONCLUSTERED INDEX [IX_lncompany__name] ON [dbo].[company] 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__website')
CREATE NONCLUSTERED INDEX [IX_lncompany__website] ON [dbo].[company] 
(
	[website] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[company]') AND name = N'IX_lncompany__website__id')
CREATE NONCLUSTERED INDEX [IX_lncompany__website__id] ON [dbo].[company] 
(
	[website] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'company', N'COLUMN',N'code'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key value by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'code'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'company', N'COLUMN',N'website'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Company website. This is not the url of the company page.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'website'
GO
/****** Object:  Table [dbo].[company_sics]    Script Date: 04/19/2022 15:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[company_sics]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[company_sics](
	[id] [uniqueidentifier] NOT NULL,
	[id_company] [uniqueidentifier] NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__lncompan__3213E83F27C1E455] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[company_naics]    Script Date: 04/19/2022 15:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[company_naics]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[company_naics](
	[id] [uniqueidentifier] NOT NULL,
	[id_company] [uniqueidentifier] NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__lncompan__3213E83F2C869972] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[append]    Script Date: 04/19/2022 15:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[append]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[append](
	[id] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[allocation_reservation_id] [uniqueidentifier] NULL,
	[allocation_reservation_time] [datetime] NULL,
	[allocation_reservation_times] [numeric](18, 0) NULL,
	[allocation_start_time] [datetime] NULL,
	[allocation_end_time] [datetime] NULL,
	[source_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[type] [numeric](18, 0) NULL,
	[verify_reservation_id] [uniqueidentifier] NULL,
	[verify_reservation_time] [datetime] NULL,
	[verify_reservation_times] [numeric](18, 0) NULL,
	[verify_start_time] [datetime] NULL,
	[verify_end_time] [datetime] NULL,
	[verify_result] [numeric](18, 0) NULL,
	[verify_time] [datetime] NULL,
	[delete_time] [datetime] NULL,
	[stat_last_export_of_fld_name_stats] [datetime] NULL,
 CONSTRAINT [PK__liappend__3213E83F1C3D2329] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[append]') AND name = N'IX_append__id_profile__create_time__type__verify_result')
CREATE NONCLUSTERED INDEX [IX_append__id_profile__create_time__type__verify_result] ON [dbo].[append] 
(
	[id_profile] ASC,
	[create_time] ASC,
	[type] ASC,
	[verify_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[append]') AND name = N'IX_append__id_profile__type')
CREATE NONCLUSTERED INDEX [IX_append__id_profile__type] ON [dbo].[append] 
(
	[id_profile] ASC,
	[type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[append]') AND name = N'IX_append__id_profile__verify_end_time__verify_result__source_name')
CREATE NONCLUSTERED INDEX [IX_append__id_profile__verify_end_time__verify_result__source_name] ON [dbo].[append] 
(
	[id_profile] ASC,
	[verify_end_time] ASC,
	[verify_result] ASC,
	[source_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[append]') AND name = N'IX_append__stat_last_export_of_fld_name_stats')
CREATE NONCLUSTERED INDEX [IX_append__stat_last_export_of_fld_name_stats] ON [dbo].[append] 
(
	[stat_last_export_of_fld_name_stats] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[append]') AND name = N'IX_liappend4__email')
CREATE NONCLUSTERED INDEX [IX_liappend4__email] ON [dbo].[append] 
(
	[email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [tr_result_after_insert]    Script Date: 04/19/2022 15:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_result_after_insert]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_result_after_insert] on [dbo].[result] after insert
as
begin
	declare @n as integer;
	declare @sid as uniqueidentifier;

	-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
	select @n=count(*) from inserted;

	-- valido que solo se inserte un registro
	if @n<>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot update more than 1 record at once in the table result.'', 16, 1);
		return;
	end

	-- inicio la transaccion
	begin transaction;
	
	-- bloqueo el registro de la busqueda
	select @sid = s.id 
	from search s with (xlock) -- bloqueo el registro
	join inserted i on (s.id=i.id_search);

	update search set stat_results=isnull(stat_results,0)+1 where id=(select i.id_search from inserted i);

	-- finalizo la transaccion
	commit transaction;
end
'
GO
/****** Object:  Trigger [tr_append_before_update]    Script Date: 04/19/2022 15:50:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_append_before_update]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_append_before_update] ON [dbo].[append] FOR UPDATE
AS 
BEGIN
	--
	declare @n as integer;
	declare @pid as uniqueidentifier;

	-- valido que solo se inserte un registro a la vez
	select @n=count(*) from inserted;
	if @n>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot update more than 1 record at once in the table append.'', 16, 1)
	end

	-- 
	select @pid = i.id_profile from inserted i

	--
	exec updateDrlMinutelyStatsOnProfileModification @pid;
END;
'
GO
/****** Object:  Trigger [tr_append_before_insert]    Script Date: 04/19/2022 15:50:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_append_before_insert]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_append_before_insert] ON [dbo].[append] FOR INSERT
AS 
BEGIN
	--
	declare @n as integer;
	declare @pid as uniqueidentifier;

	-- valido que solo se inserte un registro a la vez
	select @n=count(*) from inserted;
	if @n>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot insert more than 1 record at once in the table append.'', 16, 1)
	end

	-- 
	select @pid = i.id_profile from inserted i

	--
	exec updateDrlMinutelyStatsOnProfileModification @pid;
END;
'
GO
/****** Object:  Table [dbo].[affiliate_link]    Script Date: 04/19/2022 15:31:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[affiliate_link]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[affiliate_link](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__affiliat__3213E83F7C152E29] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[buffer_append_liprofile_6_output]    Script Date: 04/19/2022 15:31:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[buffer_append_liprofile_6_output]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[buffer_append_liprofile_6_output](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[rid] [uniqueidentifier] NOT NULL,
	[pattern] [numeric](18, 0) NOT NULL,
	[outputs] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[reservation_id] [uniqueidentifier] NULL,
	[reservation_time] [datetime] NULL,
	[reservation_times] [numeric](18, 0) NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[result] [numeric](18, 0) NULL,
	[id_search] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__buffer_a__3213E83F524D3DB4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[fl_export]    Script Date: 04/19/2022 15:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_export]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_export](
	[ID] [int] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[id_search] [int] NULL,
	[creation_time] [datetime] NULL,
 CONSTRAINT [PK__fl_expor__3214EC271ACEBF73] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[fielddef]    Script Date: 04/19/2022 15:31:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fielddef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fielddef](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__fielddef__3213E83F03C6A2DE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[field]    Script Date: 04/19/2022 15:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[field]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[field](
	[id] [uniqueidentifier] NOT NULL,
	[id_result] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__field__3213E83F088B57FB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[proxyprovider]    Script Date: 04/19/2022 15:08:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proxyprovider]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[proxyprovider](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[provider_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[mac_max_signups_per_day] [int] NULL,
	[mac_max_signups_per_week] [int] NULL,
	[frontend_ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[smspva_country_code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[mac_smspva_country_code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[ssh_username] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[ssh_password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[username] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[password] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK_proxyprovider] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_proxyprovider__frontend_ip] UNIQUE NONCLUSTERED 
(
	[frontend_ip] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[proxyinventory]    Script Date: 04/19/2022 15:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proxyinventory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[proxyinventory](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[ip] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[port] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cosmos_sharing]    Script Date: 04/19/2022 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cosmos_sharing]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cosmos_sharing](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_proxy] [uniqueidentifier] NOT NULL,
	[id_service] [uniqueidentifier] NOT NULL,
	[hourly_fee] [int] NOT NULL,
 CONSTRAINT [PK__cosmos_s__3213E83F3A276F3B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cosmos_proxy_uptime]    Script Date: 04/19/2022 15:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cosmos_proxy_uptime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cosmos_proxy_uptime](
	[id] [uniqueidentifier] NOT NULL,
	[id_proxy] [uniqueidentifier] NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
 CONSTRAINT [PK__cosmos_p__3213E83F309E0501] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [tr_company_after_insert_update]    Script Date: 04/19/2022 15:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_company_after_insert_update]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_company_after_insert_update] on [dbo].[company] after insert,update
as
begin
	declare @n as integer;

	-- obtengo la cantidad de registros que se estan insertando - se inserta mas de uno cuando se hace un bulk-insert o un insert-select
	select @n=count(*) from inserted;

	-- valido que solo se inserte un registro
	if @n>5000
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot insert or update more than 5000 records at once in the table company.'', 16, 1);
		return;
	end	

	-- actualizo los campos snapshot en la tabla lisearchresult
	begin transaction;
		select COUNT(r.id)
		from result r with (xlock)
		join profile p on p.id=r.id_profile
		join inserted c on (c.id=p.id_company_from_headline);

		select COUNT(r.id)
		from result r with (xlock)
		join profile p on p.id=r.id_profile
		join inserted c on (c.id=p.id_company_from_title);

		update result
		set
			stat_company_has_website = 0
		from result r
		join profile p on p.id=r.id_profile
		join inserted c on (c.id=p.id_company_from_headline and c.website is null);

		update result
		set
			stat_company_has_website = 0
		from result r
		join profile p on p.id=r.id_profile
		join inserted c on (c.id=p.id_company_from_title and c.website is null);

		update result
		set
			stat_company_has_website = 1
		from result r
		join profile p on p.id=r.id_profile
		join inserted c on (c.id=p.id_company_from_headline and c.website is not null);

		update result
		set
			stat_company_has_website = 1
		from result r
		join profile p on p.id=r.id_profile
		join inserted c on (c.id=p.id_company_from_title and c.website is not null);
	commit transaction;
end;
'
GO
/****** Object:  Table [dbo].[profilejob]    Script Date: 04/19/2022 15:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[profilejob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[profilejob](
	[id] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[id_company] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[from_time] [datetime] NULL,
	[to_time] [datetime] NULL,
	[headline] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[summary] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__profilej__3213E83F40D4AF50] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[profilejob]') AND name = N'IX_profilejob__id_profile__id_company')
CREATE NONCLUSTERED INDEX [IX_profilejob__id_profile__id_company] ON [dbo].[profilejob] 
(
	[id_profile] ASC,
	[id_company] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[updateDrlMinutelyStatsOnChatModification]    Script Date: 04/19/2022 15:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[updateDrlMinutelyStatsOnChatModification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[updateDrlMinutelyStatsOnChatModification](@id_result UNIQUEIDENTIFIER, @id_lnuser UNIQUEIDENTIFIER, @id_message UNIQUEIDENTIFIER)
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	DECLARE @n NUMERIC(18,0);
	DECLARE @m NUMERIC(18,0);
	DECLARE @dt DATETIME;
	DECLARE @dt1 DATETIME;
	DECLARE @dt2 DATETIME;
	DECLARE @gct BIT;
	DECLARE @gct_id_user UNIQUEIDENTIFIER;
	DECLARE @id UNIQUEIDENTIFIER; -- id of message
	
	-- searchable
	DECLARE @pid UNIQUEIDENTIFIER; -- id of the profile
	DECLARE @cur CURSOR;
	DECLARE @value VARCHAR(8000);
	
	-- si NO existe un registro en la tabla de estadisticas, para este result, lnuser y mensaje ...	
	BEGIN TRANSACTION
	select @n = count(*) 
	from drl_minutely_stats x with (xlock) -- bloqueo el registro de movimientos
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	if (@n=0)
	begin
		-- ... lo inserto
		insert into drl_minutely_stats 
		(id_client, id_search, id_pipeline, id_message, id_lnuser, id_result, id_profile, create_time)
		select distinct top 1 u.id_client, r.id_search, m.id_pipeline, m.id, h.id_lnuser, h.id_result, r.id_profile, getdate()
		from result r with (nolock)
		join lnchat h with (nolock) on r.id=h.id_result
		join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0) in (0,-2)) -- invitation or campaign
		join [user] u with (nolock) on u.id=m.id_user
		where h.id_result = @id_result
		and h.id_lnuser = @id_lnuser
		and h.id_message = @id_message;
	end
	COMMIT TRANSACTION;
	
	-- build searchable
	select @pid = r.id_profile
	from result r with (nolock)
	where r.id=@id_result;

	-- ... actualizo los searchable: name, headline, location, industry
	update drl_minutely_stats 
	set 
		name = (select name from [profile] p with (nolock) where p.id=@pid),
		location = (select location from [profile] p with (nolock) where p.id=@pid),
		industry = (select industry from [profile] p with (nolock) where p.id=@pid),
		company = (
			select c.name
			from [profile] p with (nolock)
			left join company c with (nolock) on c.id=p.id_company_from_headline
			where p.id=@pid
		),
		searchable = (
			select 
				''name:"''+replace(isnull(p.name,''''),''"'',''\"'')+''", '' +
				''headline:"''+replace(isnull(p.headline,''''),''"'',''\"'')+''", '' +
				''location:"''+replace(isnull(p.location,''''),''"'',''\"'')+''", '' +
				''industry:"''+replace(isnull(p.industry,''''),''"'',''\"'')+''", '' +
				''company:"''+replace(isnull(c.name,''''),''"'',''\"'')+''", ''
			from [profile] p with (nolock)
			left join company c with (nolock) on c.id=p.id_company_from_headline
			where p.id=@pid
		)
	where id_result = @id_result
	and id_lnuser = @id_lnuser
	and id_message = @id_message;

	-- 	... actualizo los searchable: emails
	SET @cur = CURSOR FOR
	SELECT	DISTINCT a.email as value
	FROM	[append] a WITH (NOLOCK)
	WHERE	a.id_profile = @pid
	AND		ISNULL(a.type,20) = 20; -- email
	OPEN @cur;
	FETCH NEXT FROM @cur INTO @value;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		update drl_minutely_stats 
		set searchable = isnull(searchable, '''') + ''email:"''+replace(isnull(@value,''''),''"'',''\"'')+''", ''
		where id_result = @id_result
		and id_lnuser = @id_lnuser
		and id_message = @id_message;
		FETCH NEXT FROM @cur INTO @value;
	END
	CLOSE @cur;	
	DEALLOCATE @cur;

	-- 	... actualizo los searchable: phones
	SET @cur = CURSOR FOR
	SELECT	DISTINCT a.email as value
	FROM	[append] a WITH (NOLOCK)
	WHERE	a.id_profile = @pid
	AND		ISNULL(a.type,20) = 10; -- phone
	OPEN @cur;
	FETCH NEXT FROM @cur INTO @value;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		update drl_minutely_stats 
		set searchable = isnull(searchable, '''') + ''phone:"''+replace(isnull(@value,''''),''"'',''\"'')+''", ''
		where id_result = @id_result
		and id_lnuser = @id_lnuser
		and id_message = @id_message;
		FETCH NEXT FROM @cur INTO @value;
	END
	CLOSE @cur;	
	DEALLOCATE @cur;

	-- 	... actualizo los searchable: linkedin
	SET @cur = CURSOR FOR
	SELECT	DISTINCT a.email as value
	FROM	[append] a WITH (NOLOCK)
	WHERE	a.id_profile = @pid
	AND		ISNULL(a.type,20) = 90; -- linkedin
	OPEN @cur;
	FETCH NEXT FROM @cur INTO @value;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		update drl_minutely_stats 
		set searchable = isnull(searchable, '''') + ''linkedin:"''+replace(isnull(@value,''''),''"'',''\"'')+''", ''
		where id_result = @id_result
		and id_lnuser = @id_lnuser
		and id_message = @id_message;
		FETCH NEXT FROM @cur INTO @value;
	END
	CLOSE @cur;	
	DEALLOCATE @cur;

	-- 	... actualizo los searchable: chats
	SET @cur = CURSOR FOR
	SELECT	DISTINCT h.body as body
	FROM	lnchat h WITH (NOLOCK)
	where h.id_result = @id_result
	and h.id_lnuser = @id_lnuser
	and h.id_message = @id_message
	and isnull(h.direction, 0) <> 3; -- disregards "Invitation Accepted" chats
	OPEN @cur;
	FETCH NEXT FROM @cur INTO @value;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		update drl_minutely_stats 
		set searchable = isnull(searchable, '''') + ''chat:"''+replace(isnull(@value,''''),''"'',''\"'')+''", ''
		where id_result = @id_result
		and id_lnuser = @id_lnuser
		and id_message = @id_message;
		FETCH NEXT FROM @cur INTO @value;
	END
	CLOSE @cur;	
	DEALLOCATE @cur;

	-- INVITATION MESSAGES
	-- ininvite_start_time
	-- ininvite_end_time
	update x set
	x.ininvite_start_time = h.inmessage_start_time,
	x.ininvite_end_time = h.inmessage_end_time
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on h.id_result=x.id_result
	join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0) in (0,-2) and isnull(h.direction,0)=0)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;

	-- INVITATIONS ACCEPTANCE - NEW CONNECTIONS
	-- ininvite_hit_time
	set @dt=null;
	select @dt = min(h.create_time)
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=3)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	-- 
	update drl_minutely_stats set ininvite_hit_time = @dt where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;
		
	-- INTRODUCTION MESSAGES
	-- id_message_1
	-- inmessage_1_start_time
	-- inmessage_1_end_time
	set @dt1=null;
	set @dt2=null;
	set @id=null;
	set @gct=null;	
	set @gct_id_user=null;	
	select top 1 @dt1 = h.inmessage_start_time, @dt2 = h.inmessage_end_time, @id = m.id, @gct=h.gct, @gct_id_user=h.gct_id_user
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=0 and h.delete_time is null)
	join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=1)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message
	order by h.create_time; -- replicate the first intro messages created
	-- 
	update drl_minutely_stats set inmessage_1_start_time = @dt1, inmessage_1_end_time = @dt2, id_message_1 = @id, gct_1 = @gct, gct_1_id_user = @gct_id_user where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;

	-- WELCOME MESSAGE
	-- id_message_2
	-- inmessage_start_time (it should be inmessage_2_start_time)
	-- inmessage_end_time (it should be inmessage_2_end_time)
	set @dt1=null;
	set @dt2=null;
	set @id=null;
	set @gct=null;	
	set @gct_id_user=null;	
	select top 1 @dt1 = h.inmessage_start_time, @dt2 = h.inmessage_end_time, @id = m.id, @gct=h.gct, @gct_id_user=h.gct_id_user
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=0 and h.delete_time is null)
	join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=2)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message
	order by h.create_time; -- replicate the first welcome messages created
	-- 
	update drl_minutely_stats set inmessage_start_time = @dt1, inmessage_end_time = @dt2, id_message_2 = @id, gct_2 = @gct, gct_2_id_user = @gct_id_user where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;

	-- POSITIVE REPLY
	-- inreply_positive
	set @dt=null;
	select @dt = max(h.create_time)
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=1 and isnull(h.positive,0)=1 and h.delete_time is null)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	if (@dt is not null)
		begin
			update drl_minutely_stats set inreply_positive = 1 where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;		
		end
	else
		begin
			update drl_minutely_stats set inreply_positive = 0 where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;		
		end
	
	-- LAST REPLY
	-- inreply_time
	set @dt=null;
	select @dt = max(h.create_time)
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=1 /*and isnull(h.positive,0)=1*/ and h.delete_time is null)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	--
	update drl_minutely_stats set inreply_time = @dt where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;				
	
	-- TRANSFER MESSAGES
	-- wlt_time
	set @dt=null;
	set @gct=null;
	set @gct_id_user=null;	
	select top 1 @dt = h.inmessage_end_time, @gct=h.gct, @gct_id_user=h.gct_id_user
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on ( x.id_result=h.id_result and isnull(h.direction,0)=0 and isnull(h.wlt_enabled,0)=1 and h.delete_time is null )
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message
	order by h.create_time; -- replicate the first transfer messages created
	-- 
	update drl_minutely_stats set wlt_time = @dt, gct = @gct, gct_id_user = @gct_id_user where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;
/*
	-- CAMPAIGN (BLAST) MESSAGES
	-- id_message_campaign
	-- inmessage_campaign_start_time
	-- inmessage_campaign_end_time
	set @dt1=null;
	set @dt2=null;
	set @id=null;
	set @gct=null;	
	set @gct_id_user=null;	
	select top 1 @dt1 = h.inmessage_start_time, @dt2 = h.inmessage_end_time, @id = m.id
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=0 and h.delete_time is null)
	join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=-2)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message
	order by h.create_time; -- replicate the first welcome messages created
	-- 
	update drl_minutely_stats set inmessage_campaign_start_time = @dt1, inmessage_campaign_end_time = @dt2, id_message_campaign = @id where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;
*/
	-- FLAG SNAPSHOT AS DONE
	-- snapshot_time
	update drl_minutely_stats set snapshot_time=getdate() where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;		

END; -- PROC


' 
END
GO
/****** Object:  StoredProcedure [dbo].[processShapShot]    Script Date: 04/19/2022 15:22:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[processShapShot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[processShapShot](@d DATETIME)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @r INT;
	DECLARE @rid UNIQUEIDENTIFIER;
	DECLARE @uid UNIQUEIDENTIFIER;
	DECLARE @mid UNIQUEIDENTIFIER;

	-- START PROCESSIGN
	PRINT ''Reprocessing snapshots... ''
	SET @r = 1;
	WHILE @r > 0
	BEGIN
		BEGIN TRANSACTION;
	   
		SELECT TOP 1 @rid=x.id_result, @uid=x.id_lnuser, @mid=x.id_message -- this will change
		--select count(*) -- -- 4645810
		from drl_minutely_stats x with (nolock index(IX_drl_minutely_stats__snapshot_time))
		where isnull(x.snapshot_time, ''1900-01-01'') < @d;

		SET @r = @@ROWCOUNT;

		exec dbo.[updateDrlMinutelyStatsOnChatModification] @rid, @uid, @mid;

		COMMIT TRANSACTION;
		-- CHECKPOINT; -- if simple
		-- BACKUP LOG ... -- if full
	END;

	SET NOCOUNT OFF;
END;
' 
END
GO
/****** Object:  StoredProcedure [dbo].[processPipelineShapShot]    Script Date: 04/19/2022 15:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[processPipelineShapShot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[processPipelineShapShot](@id_pipeline UNIQUEIDENTIFIER, @d DATETIME)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @r INT;
	DECLARE @rid UNIQUEIDENTIFIER;
	DECLARE @uid UNIQUEIDENTIFIER;
	DECLARE @mid UNIQUEIDENTIFIER;

	-- START PROCESSIGN
	PRINT ''Reprocessing snapshots... ''
	SET @r = 1;
	WHILE @r > 0
	BEGIN
		BEGIN TRANSACTION;
	   
		SELECT TOP 1 @rid=x.id_result, @uid=x.id_lnuser, @mid=x.id_message -- this will change
		--select count(*) -- -- 4645810
		from drl_minutely_stats x with (nolock)
		where isnull(x.snapshot_time, ''1900-01-01'') < @d
		and x.id_pipeline=@id_pipeline;

		SET @r = @@ROWCOUNT;

		exec dbo.[updateDrlMinutelyStatsOnChatModification] @rid, @uid, @mid;

		COMMIT TRANSACTION;
		-- CHECKPOINT; -- if simple
		-- BACKUP LOG ... -- if full
	END;

	SET NOCOUNT OFF;
END;
' 
END
GO
/****** Object:  StoredProcedure [dbo].[processDrlMinutelyStats]    Script Date: 04/19/2022 15:22:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[processDrlMinutelyStats]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[processDrlMinutelyStats](@d DATETIME)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @r INT;
	DECLARE @rid UNIQUEIDENTIFIER;
	DECLARE @uid UNIQUEIDENTIFIER;
	DECLARE @mid UNIQUEIDENTIFIER;

	-- START PROCESSIGN
	PRINT ''Reprocessing snapshots... ''
	SET @r = 1;
	WHILE @r > 0
	BEGIN
		BEGIN TRANSACTION;
	   
		SELECT TOP 1 @rid=x.id_result, @uid=x.id_lnuser, @mid=x.id_message -- this will change
		--select count(*) -- -- 4645810
		--select top 10 x.*
		from drl_minutely_stats x with (nolock index(IX_drl_minutely_stats__snapshot_time))
--join lnchat h with (nolock) on h.id_result=x.id_result
--join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=-2)
--where isnull(x.snapshot_time, ''1900-01-01'') < ''2000-01-01'';
		where isnull(x.snapshot_time, ''1900-01-01'') < @d;

		SET @r = @@ROWCOUNT;

		exec dbo.[updateDrlMinutelyStatsOnChatModification] @rid, @uid, @mid;

		COMMIT TRANSACTION;
		-- CHECKPOINT; -- if simple
		-- BACKUP LOG ... -- if full
	END;

	SET NOCOUNT OFF;
END;

' 
END
GO
/****** Object:  Table [dbo].[post]    Script Date: 04/19/2022 15:08:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[post]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[post](
	[id] [uniqueidentifier] NOT NULL,
	[url] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[post_time] [datetime] NOT NULL,
	[html_content] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[reacts] [bigint] NOT NULL,
	[comments] [bigint] NOT NULL,
 CONSTRAINT [PK__post__3213E83F392DB772] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pipeline_user]    Script Date: 04/19/2022 15:08:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pipeline_user]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pipeline_user](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_receiver] [uniqueidentifier] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[allowed_for_linkedin_group_chat_transfers] [bit] NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__pipeline__3213E83F1F7C7842] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pipeline_user]') AND name = N'IX_pipeline_user__id_pipeline__id_receiver')
CREATE NONCLUSTERED INDEX [IX_pipeline_user__id_pipeline__id_receiver] ON [dbo].[pipeline_user] 
(
	[id_pipeline] ASC,
	[id_receiver] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[filejobdrlwlt]    Script Date: 04/19/2022 15:31:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[filejobdrlwlt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[filejobdrlwlt](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[period] [varchar](1) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[units] [numeric](18, 0) NOT NULL,
	[generation_start_time] [datetime] NULL,
	[generation_end_time] [datetime] NULL,
	[generation_tries] [numeric](18, 0) NULL,
	[generation_success] [bit] NULL,
	[generation_description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[generation_results] [numeric](18, 0) NULL,
	[generation_filename_brokendown] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[generation_filename_summarized] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__filejobd__3213E83F1B39D517] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[invoice]    Script Date: 04/19/2022 15:46:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[invoice]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[invoice](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_client] [uniqueidentifier] NOT NULL,
	[billing_period_from] [date] NULL,
	[billing_period_to] [date] NULL,
	[id_buffer_paypal_notification] [uniqueidentifier] NULL,
	[status] [int] NULL,
	[paypal_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[automatic_billing] [bit] NULL,
	[subscr_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[disabled_for_trial_ssm] [bit] NULL,
	[disabled_for_add_remove_items] [bit] NULL,
	[id_previous_invoice] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__invoice__3213E83F6A83CBEB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[invoice_item]    Script Date: 04/19/2022 15:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[invoice_item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[invoice_item](
	[id] [uniqueidentifier] NOT NULL,
	[id_invoice] [uniqueidentifier] NOT NULL,
	[product_code] [varchar](5) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[unit_price] [numeric](18, 4) NOT NULL,
	[units] [numeric](18, 4) NOT NULL,
	[amount] [numeric](18, 4) NOT NULL,
	[detail] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[item_number] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[create_time] [datetime] NULL,
 CONSTRAINT [PK__invoice___3213E83F6E545CCF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[movement]    Script Date: 04/19/2022 15:33:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[movement](
	[id] [uniqueidentifier] NOT NULL,
	[id_client] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[id_user_creator] [uniqueidentifier] NULL,
	[description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[paypal1_amount] [numeric](18, 6) NOT NULL,
	[bonus_amount] [numeric](18, 6) NOT NULL,
	[amount] [numeric](18, 6) NOT NULL,
	[credits] [numeric](18, 0) NOT NULL,
	[lgb2_id_lngroup] [uniqueidentifier] NULL,
	[edb_id_crmlist] [uniqueidentifier] NULL,
	[profits_amount] [numeric](18, 6) NOT NULL,
	[id_invoice_item] [uniqueidentifier] NULL,
	[product_code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[expiration_time] [datetime] NULL,
	[expiration_start_time] [datetime] NULL,
	[expiration_end_time] [datetime] NULL,
	[expiration_tries] [int] NULL,
	[expiration_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[expiration_on_next_payment] [bit] NULL,
	[expiration_lead_period] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[expiration_lead_units] [int] NULL,
	[give_away_negative_credits] [bit] NULL,
 CONSTRAINT [PK__movement__3213E83F27E3DFFF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__id_client')
CREATE NONCLUSTERED INDEX [IX_movement__id_client] ON [dbo].[movement] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__id_client__create_time')
CREATE NONCLUSTERED INDEX [IX_movement__id_client__create_time] ON [dbo].[movement] 
(
	[id_client] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__id_client__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_movement__id_client__create_time_desc] ON [dbo].[movement] 
(
	[id_client] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__id_client__product_code')
CREATE NONCLUSTERED INDEX [IX_movement__id_client__product_code] ON [dbo].[movement] 
(
	[id_client] ASC,
	[product_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__id_client__product_code__create_time__credits')
CREATE NONCLUSTERED INDEX [IX_movement__id_client__product_code__create_time__credits] ON [dbo].[movement] 
(
	[id_client] ASC,
	[product_code] ASC,
	[create_time] ASC,
	[credits] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__id_client__product_code__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_movement__id_client__product_code__create_time_desc] ON [dbo].[movement] 
(
	[id_client] ASC,
	[product_code] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__product_code__type__create_time')
CREATE NONCLUSTERED INDEX [IX_movement__product_code__type__create_time] ON [dbo].[movement] 
(
	[product_code] ASC,
	[type] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__type__create_time')
CREATE NONCLUSTERED INDEX [IX_movement__type__create_time] ON [dbo].[movement] 
(
	[type] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__type__id_client__product_code__create_time_desc__credits_asc')
CREATE NONCLUSTERED INDEX [IX_movement__type__id_client__product_code__create_time_desc__credits_asc] ON [dbo].[movement] 
(
	[type] ASC,
	[id_client] ASC,
	[product_code] ASC,
	[create_time] DESC,
	[credits] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movement__type__id_client__product_code__create_time_desc__credits_desc')
CREATE NONCLUSTERED INDEX [IX_movement__type__id_client__product_code__create_time_desc__credits_desc] ON [dbo].[movement] 
(
	[type] ASC,
	[id_client] ASC,
	[product_code] ASC,
	[create_time] DESC,
	[credits] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movment__id_client__type')
CREATE NONCLUSTERED INDEX [IX_movment__id_client__type] ON [dbo].[movement] 
(
	[id_client] ASC,
	[type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[movement]') AND name = N'IX_movment__id_invoice_item')
CREATE NONCLUSTERED INDEX [IX_movment__id_invoice_item] ON [dbo].[movement] 
(
	[id_invoice_item] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnBalance]    Script Date: 04/19/2022 15:33:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnBalance]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[fnBalance](@product_code VARCHAR(500), @id_client UNIQUEIDENTIFIER)
RETURNS TABLE
AS
RETURN
(
	select cast(sum(cast(amount as numeric(18,12))) as numeric(18,6)) as amount, sum(credits) as credits 
	from movement with (nolock index(IX_movement__id_client__product_code)) 
	where id_client=@id_client
	and product_code=@product_code
);' 
END
GO
/****** Object:  StoredProcedure [dbo].[reduceDebt]    Script Date: 04/19/2022 15:33:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reduceDebt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[reduceDebt](@product_code VARCHAR(500), @id_client UNIQUEIDENTIFIER, @credits_to_reduce NUMERIC(18,0), @description VARCHAR(500))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	DECLARE @date DATETIME;
	DECLARE @credits AS NUMERIC(18,0);
	DECLARE @credit_value AS FLOAT;
	DECLARE @profits_amount AS FLOAT;
	DECLARE @n NUMERIC(18,0);

	SET @date = GETDATE();
	SET @credits = (select isnull(credits,0) from dbo.fnBalance(@product_code, @id_client)) ;
	SET @credit_value = (select isnull(amount,0) / credits from dbo.fnBalance(@product_code, @id_client) where isnull(credits,0)<>0) ;
	SET @profits_amount = @credits_to_reduce * ISNULL(@credit_value,0) ;

	-- si no existe un registro en la tabla de movimientos, para este cliente y esta lista, el dia de hoy, lo bloqueo para evitar que se inserten duplicados
	begin transaction;

	-- si no existe un registro en la tabla de movimientos, para este cliente, para este producto, el dia de hoy, que cancele la deuda, creo un registro nuevo
	select @n = count(*) 
	from movement m with (xlock) -- bloqueo el registro de movimientos
	where m.id_client = @id_client
	and m.type = 4
	and m.product_code = @product_code
	and CAST(m.description AS VARCHAR(8000)) = CAST(@description AS VARCHAR(8000))
	and isnull(m.credits,0) > 0
	and year(m.create_time)=year(@date) 
	and month(m.create_time)=month(@date) 
	and day(m.create_time)=day(@date)

	if (@n=0)
	begin
		--
		insert into movement (
			id, id_client, create_time, type, product_code, description, 
			paypal1_amount, bonus_amount,
			amount, credits,
			profits_amount)
		values (
			newid(), @id_client, @date, 4, @product_code, CAST(@description AS TEXT), 
			0, 0, 
			@profits_amount, @credits_to_reduce,
			-@profits_amount)	
	end
	else
	begin
		update movement
		set 
		amount=amount+@profits_amount, 
		credits=credits+@credits_to_reduce,
		profits_amount=profits_amount-@profits_amount
		where id in (
			select top 1 m.id
			from movement m with (nolock) 
			where m.id_client = @id_client
			and m.type = 4
			and m.product_code = @product_code
			and CAST(m.description AS VARCHAR(8000)) = CAST(@description AS VARCHAR(8000))
			and isnull(m.credits,0) > 0
			and year(m.create_time)=year(@date) 
			and month(m.create_time)=month(@date) 
			and day(m.create_time)=day(@date)
			order by m.create_time desc
		)
	end

	--
	commit transaction;
END' 
END
GO
/****** Object:  Table [dbo].[on_wlt_from_message_action]    Script Date: 04/19/2022 15:27:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[on_wlt_from_message_action](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[status] [bit] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_search] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
 CONSTRAINT [PK__on_wlt_f__3213E83F6CE33D86] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[on_emopen_action]    Script Date: 04/19/2022 15:28:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[on_emopen_action]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[on_emopen_action](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[status] [bit] NOT NULL,
	[id_emcampaign] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_search] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
 CONSTRAINT [PK__on_emope__3213E83F1A41C4B8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[on_emdelivery_action]    Script Date: 04/19/2022 15:29:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[on_emdelivery_action](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[status] [bit] NOT NULL,
	[id_emcampaign] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_search] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
 CONSTRAINT [PK__on_emdel__3213E83F11AC7EB7] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[on_emclick_action]    Script Date: 04/19/2022 15:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[on_emclick_action]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[on_emclick_action](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[status] [bit] NOT NULL,
	[id_emlink] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_search] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
 CONSTRAINT [PK__on_emcli__3213E83F22D70AB9] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[notification]    Script Date: 04/19/2022 15:32:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[notification]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[notification](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delivery_time] [datetime] NULL,
	[type] [numeric](18, 0) NOT NULL,
	[id_user] [uniqueidentifier] NULL,
	[name_to] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[email_to] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name_from] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[email_from] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[subject] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[body] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_host] [uniqueidentifier] NULL,
 CONSTRAINT [PK__notifica__3213E83F0D99FE17] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[nbsharecommentfile]    Script Date: 04/19/2022 15:08:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbsharecommentfile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbsharecommentfile](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[delete_time] [datetime] NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[processing_start_time] [datetime] NULL,
	[processing_end_time] [datetime] NULL,
	[processing_result] [int] NULL,
	[processing_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__nbsharec__3213E83F004FD361] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[nbsharecomment]    Script Date: 04/19/2022 15:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbsharecomment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbsharecomment](
	[id] [uniqueidentifier] NOT NULL,
	[id_sharecommentfile] [uniqueidentifier] NOT NULL,
	[number] [bigint] NOT NULL,
	[comment] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__nbsharec__3213E83F0514887E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_nbsharecomment__id_commentfile__number] UNIQUE NONCLUSTERED 
(
	[id_sharecommentfile] ASC,
	[number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbsharecomment]') AND name = N'IX_nbsharecomment__id_sharecommentfile__number')
CREATE NONCLUSTERED INDEX [IX_nbsharecomment__id_sharecommentfile__number] ON [dbo].[nbsharecomment] 
(
	[id_sharecommentfile] ASC,
	[number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nbrun]    Script Date: 04/19/2022 15:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbrun]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbrun](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_jobs] [int] NULL,
	[stat_jobs_completed] [int] NULL,
	[stat_jobs_failed] [int] NULL,
	[param_traffic_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[param_traffic_number_of_visits] [int] NULL,
	[param_traffic_visit_min_seconds] [int] NULL,
	[param_traffic_visit_random_additional_seconds] [int] NULL,
	[setup_start_time] [datetime] NULL,
	[setup_end_time] [datetime] NULL,
	[setup_tries] [int] NULL,
	[last_history_update_time] [datetime] NULL,
	[param_reacts_rate_like] [float] NULL,
	[param_reacts_rate_celebrate] [float] NULL,
	[param_reacts_rate_support] [float] NULL,
	[param_reacts_rate_love] [float] NULL,
	[param_reacts_rate_insightful] [float] NULL,
	[param_reacts_rate_curious] [float] NULL,
	[param_shares_rate] [float] NULL,
	[param_check_linkedin_video] [bit] NULL,
	[type] [int] NULL,
	[param_comments_rate] [float] NULL,
	[param_allow_recurrent_visits] [bit] NULL,
	[cancel_time] [datetime] NULL,
	[id_search_for_tagging] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
 CONSTRAINT [PK__nbrun__3213E83F0A0E47C5] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[nbrun_history]    Script Date: 04/19/2022 15:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbrun_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbrun_history](
	[id] [uniqueidentifier] NOT NULL,
	[id_run] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_jobs] [int] NULL,
	[stat_jobs_completed] [int] NULL,
	[stat_jobs_failed] [int] NULL,
	[param_traffic_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[param_traffic_number_of_visits] [int] NULL,
	[param_traffic_visit_min_seconds] [int] NULL,
	[param_traffic_visit_random_additional_seconds] [int] NULL,
	[setup_start_time] [datetime] NULL,
	[setup_end_time] [datetime] NULL,
	[setup_tries] [int] NULL,
	[param_reacts_rate_like] [float] NULL,
	[param_reacts_rate_celebrate] [float] NULL,
	[param_reacts_rate_support] [float] NULL,
	[param_reacts_rate_love] [float] NULL,
	[param_reacts_rate_insightful] [float] NULL,
	[param_reacts_rate_curious] [float] NULL,
	[param_shares_rate] [float] NULL,
	[param_check_linkedin_video] [bit] NULL,
	[type] [int] NULL,
	[param_comments_rate] [float] NULL,
	[param_allow_recurrent_visits] [bit] NULL,
 CONSTRAINT [PK__nbrun_hi__3213E83F659BDD25] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [tr_on_insert_nbrun]    Script Date: 04/19/2022 15:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_insert_nbrun]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_on_insert_nbrun] ON [dbo].[nbrun]
AFTER INSERT
AS
BEGIN
	INSERT INTO nbrun_history(id, id_run, create_time, id_user, [description], param_traffic_url, param_traffic_number_of_visits, param_traffic_visit_min_seconds, param_traffic_visit_random_additional_seconds, setup_start_time, setup_end_time, setup_tries, param_reacts_rate_like, param_reacts_rate_celebrate, param_reacts_rate_support, param_reacts_rate_love, param_reacts_rate_insightful, param_reacts_rate_curious, param_shares_rate, param_comments_rate, param_check_linkedin_video, param_allow_recurrent_visits, [type])
	SELECT newid(), b.id, getdate(), b.id_user, cast(b.[description] as varchar(8000)), cast(b.param_traffic_url as varchar(8000)), b.param_traffic_number_of_visits, b.param_traffic_visit_min_seconds, b.param_traffic_visit_random_additional_seconds, b.setup_start_time, b.setup_end_time, b.setup_tries, b.param_reacts_rate_like, b.param_reacts_rate_celebrate, b.param_reacts_rate_support, b.param_reacts_rate_love, b.param_reacts_rate_insightful, b.param_reacts_rate_curious, b.param_shares_rate, b.param_comments_rate, b.param_check_linkedin_video, b.param_allow_recurrent_visits, b.type
	FROM nbrun b with (nolock)
	JOIN inserted i with (nolock) on b.id=i.id; -- must do this join to avoid the error "Cannot use text, ntext, or image columns in the ''inserted'' and ''deleted'' tables".
END;
'
GO
/****** Object:  Table [dbo].[nbjob_history]    Script Date: 04/19/2022 15:09:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbjob_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbjob_history](
	[id] [uniqueidentifier] NOT NULL,
	[id_job] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_run] [uniqueidentifier] NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[run_reservation_id] [uniqueidentifier] NULL,
	[run_reservation_times] [int] NULL,
	[run_start_time] [datetime] NULL,
	[run_end_time] [datetime] NULL,
	[run_reservation_time] [datetime] NULL,
 CONSTRAINT [PK__nbjob_hi__3213E83F6B54B67B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[nbjob]    Script Date: 04/19/2022 15:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbjob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbjob](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_run] [uniqueidentifier] NULL,
	[description] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[run_reservation_id] [uniqueidentifier] NULL,
	[run_reservation_times] [int] NULL,
	[run_start_time] [datetime] NULL,
	[run_end_time] [datetime] NULL,
	[run_reservation_time] [datetime] NULL,
	[last_history_update_time] [datetime] NULL,
 CONSTRAINT [PK__nbjob__3213E83F0ED2FCE2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [tr_on_update_nbjob]    Script Date: 04/19/2022 15:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_update_nbjob]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_on_update_nbjob] ON [dbo].[nbjob]
AFTER UPDATE
AS
BEGIN
	INSERT INTO nbjob_history(id, id_job, create_time, id_user, id_run, [description], run_reservation_id, run_reservation_times, run_start_time, run_end_time, run_reservation_time)
	SELECT newid(), b.id, getdate(), b.id_user, b.id_run, cast(b.[description] as varchar(8000)), b.run_reservation_id, b.run_reservation_times, b.run_start_time, b.run_end_time, b.run_reservation_time
	FROM nbjob b with (nolock)
	JOIN inserted i with (nolock) on b.id=i.id; -- must do this join to avoid the error "Cannot use text, ntext, or image columns in the ''inserted'' and ''deleted'' tables".
END;
'
GO
/****** Object:  Trigger [tr_on_insert_nbjob]    Script Date: 04/19/2022 15:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_insert_nbjob]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_on_insert_nbjob] ON [dbo].[nbjob]
AFTER INSERT
AS
BEGIN
	INSERT INTO nbjob_history(id, id_job, create_time, id_user, id_run, [description], run_reservation_id, run_reservation_times, run_start_time, run_end_time, run_reservation_time)
	SELECT newid(), b.id, getdate(), b.id_user, b.id_run, cast(b.[description] as varchar(8000)), b.run_reservation_id, b.run_reservation_times, b.run_start_time, b.run_end_time, b.run_reservation_time
	FROM nbjob b with (nolock)
	JOIN inserted i with (nolock) on b.id=i.id; -- must do this join to avoid the error "Cannot use text, ntext, or image columns in the ''inserted'' and ''deleted'' tables".
END;
'
GO
/****** Object:  Table [dbo].[nbcommentfile]    Script Date: 04/19/2022 15:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbcommentfile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbcommentfile](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[delete_time] [datetime] NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[processing_start_time] [datetime] NULL,
	[processing_end_time] [datetime] NULL,
	[processing_result] [int] NULL,
	[processing_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__nbcommen__3213E83F75D244EE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[nbcomment]    Script Date: 04/19/2022 15:09:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbcomment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbcomment](
	[id] [uniqueidentifier] NOT NULL,
	[id_commentfile] [uniqueidentifier] NOT NULL,
	[number] [bigint] NOT NULL,
	[comment] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__nbcommen__3213E83F7A96FA0B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_nbcomment__id_commentfile__number] UNIQUE NONCLUSTERED 
(
	[id_commentfile] ASC,
	[number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbcomment]') AND name = N'IX_nbcomment__id_commentfile__number')
CREATE NONCLUSTERED INDEX [IX_nbcomment__id_commentfile__number] ON [dbo].[nbcomment] 
(
	[id_commentfile] ASC,
	[number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mimic_profile_history]    Script Date: 04/19/2022 15:24:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mimic_profile_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mimic_profile_history](
	[id] [uniqueidentifier] NOT NULL,
	[id_mimic_profile] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_client_allocated] [uniqueidentifier] NULL,
	[id_proxy] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
	[allowed_for_crowdtrust_traffic] [bit] NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[auto_regeneration_minutes] [int] NULL,
	[disabled_for_heijunka] [bit] NULL,
 CONSTRAINT [PK__mimic_pr__3213E83F10863B2A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mimic_profile]    Script Date: 04/19/2022 15:24:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mimic_profile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mimic_profile](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_client_allocated] [uniqueidentifier] NULL,
	[id_proxy] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
	[allowed_for_crowdtrust_traffic] [bit] NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[auto_regeneration_minutes] [int] NULL,
	[disabled_for_heijunka] [bit] NULL,
	[id_lnuser] [uniqueidentifier] NULL,
 CONSTRAINT [PK__mimic_pr__3213E83F0ACD61D4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[nbcommand]    Script Date: 04/19/2022 15:40:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbcommand](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[run_start_time] [datetime] NULL,
	[run_end_time] [datetime] NULL,
	[run_success] [bit] NULL,
	[run_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[param_start_id_lnuser] [uniqueidentifier] NULL,
	[param_login_id_domain] [uniqueidentifier] NULL,
	[param_goto_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[param_traffic_id_proxy] [uniqueidentifier] NULL,
	[param_traffic_url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[param_traffic_number_of_visits] [int] NULL,
	[param_traffic_visit_min_seconds] [int] NULL,
	[param_traffic_visit_random_additional_seconds] [int] NULL,
	[id_lnuser_for_remote] [uniqueidentifier] NULL,
	[param_goto_visit_min_seconds] [int] NULL,
	[param_goto_visit_random_additiona_seconds] [int] NULL,
	[username_lnuser_for_remote] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[password_lnuser_for_remote] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_mimic_profile_lnuser_for_remote] [uniqueidentifier] NULL,
	[id_job] [uniqueidentifier] NULL,
	[number] [int] NULL,
	[last_history_update_time] [datetime] NULL,
	[param_react] [int] NULL,
	[param_comment] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[param_share] [bit] NULL,
	[param_check_linkedin_video] [bit] NULL,
	[param_start_id_mimic_profile] [uniqueidentifier] NULL,
	[param_share_comment] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[param_start_id_proxy] [uniqueidentifier] NULL,
 CONSTRAINT [PK__nbcomman__3213E83F4C461F76] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand]') AND name = N'IX_nbcommand__id_job__type__run_success__run_end_time')
CREATE NONCLUSTERED INDEX [IX_nbcommand__id_job__type__run_success__run_end_time] ON [dbo].[nbcommand] 
(
	[id_job] ASC,
	[type] ASC,
	[run_success] ASC,
	[run_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand]') AND name = N'IX_nbcommand__param_start_id_mimic_profile__run_end_time__run_start_time')
CREATE NONCLUSTERED INDEX [IX_nbcommand__param_start_id_mimic_profile__run_end_time__run_start_time] ON [dbo].[nbcommand] 
(
	[param_start_id_mimic_profile] ASC,
	[run_end_time] ASC,
	[run_start_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand]') AND name = N'IX_nbcommand__run_end_time__number__id_job')
CREATE NONCLUSTERED INDEX [IX_nbcommand__run_end_time__number__id_job] ON [dbo].[nbcommand] 
(
	[run_end_time] ASC,
	[number] ASC,
	[id_job] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand]') AND name = N'IX_nbcommand__run_end_time__run_start_time__id_lnuser_for_remote')
CREATE NONCLUSTERED INDEX [IX_nbcommand__run_end_time__run_start_time__id_lnuser_for_remote] ON [dbo].[nbcommand] 
(
	[run_end_time] ASC,
	[run_start_time] ASC,
	[id_lnuser_for_remote] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand]') AND name = N'IX_nbcommand__run_start_time__type__id_job__id_lnuser_for_remote')
CREATE NONCLUSTERED INDEX [IX_nbcommand__run_start_time__type__id_job__id_lnuser_for_remote] ON [dbo].[nbcommand] 
(
	[run_start_time] ASC,
	[type] ASC,
	[id_job] ASC,
	[id_lnuser_for_remote] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nbcommand_history]    Script Date: 04/19/2022 15:09:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbcommand_history](
	[id] [uniqueidentifier] NOT NULL,
	[id_command] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[run_start_time] [datetime] NULL,
	[run_end_time] [datetime] NULL,
	[run_success] [bit] NULL,
	[run_error_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[id_job] [uniqueidentifier] NOT NULL,
	[param_react] [int] NULL,
	[param_comment] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[param_share] [bit] NULL,
	[param_check_linkedin_video] [bit] NULL,
	[param_start_id_mimic_profile] [uniqueidentifier] NULL,
	[param_share_comment] [text] COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__nbcomman__3213E83F5DFABB5D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[nbcommand_history]') AND name = N'IX_nbcommand_history__id_command__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_nbcommand_history__id_command__create_time_desc] ON [dbo].[nbcommand_history] 
(
	[id_command] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [tr_on_update_nbcommand]    Script Date: 04/19/2022 15:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_update_nbcommand]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_on_update_nbcommand] ON [dbo].[nbcommand]
AFTER UPDATE
AS
BEGIN
	INSERT INTO nbcommand_history(id, id_command, id_job, create_time, run_start_time, run_end_time, run_success, run_error_description, param_react, param_comment, param_share, param_share_comment, param_check_linkedin_video, param_start_id_mimic_profile)
	SELECT newid(), b.id, b.id_job, getdate(), b.run_start_time, b.run_end_time, b.run_success, cast(b.run_error_description as varchar(8000)), b.param_react, b.param_comment, b.param_share, b.param_share_comment, b.param_check_linkedin_video, b.param_start_id_mimic_profile
	FROM nbcommand b with (nolock)
	JOIN inserted i with (nolock) on b.id=i.id; -- must do this join to avoid the error "Cannot use text, ntext, or image columns in the ''inserted'' and ''deleted'' tables".
END;
'
GO
/****** Object:  Trigger [tr_on_insert_nbcommand]    Script Date: 04/19/2022 15:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_insert_nbcommand]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_on_insert_nbcommand] ON [dbo].[nbcommand]
AFTER INSERT
AS
BEGIN
	INSERT INTO nbcommand_history(id, id_command, id_job, create_time, run_start_time, run_end_time, run_success, run_error_description, param_react, param_comment, param_share, param_share_comment, param_check_linkedin_video, param_start_id_mimic_profile)
	SELECT newid(), b.id, b.id_job, getdate(), b.run_start_time, b.run_end_time, b.run_success, cast(b.run_error_description as varchar(8000)), b.param_react, b.param_comment, b.param_share, b.param_share_comment, b.param_check_linkedin_video, b.param_start_id_mimic_profile
	FROM nbcommand b with (nolock)
	JOIN inserted i with (nolock) on b.id=i.id; -- must do this join to avoid the error "Cannot use text, ntext, or image columns in the ''inserted'' and ''deleted'' tables".
END;
'
GO
/****** Object:  Table [dbo].[nbmention]    Script Date: 04/19/2022 15:09:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nbmention]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[nbmention](
	[id] [uniqueidentifier] NOT NULL,
	[id_command] [uniqueidentifier] NOT NULL,
	[id_result] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__nbmentio__3213E83F2FFEE683] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnusertemplateschool]    Script Date: 04/19/2022 15:14:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnusertemplateschool]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnusertemplateschool](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnusertemplate] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[school_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[degree_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[field_of_study] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[education_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[from_year] [int] NOT NULL,
	[to_year] [int] NOT NULL,
 CONSTRAINT [PK__lnuserte__3213E83F452C22BD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lnuserdomain]    Script Date: 04/19/2022 15:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnuserdomain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnuserdomain](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[expiration_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__lnuserdo__3213E83F583EF731] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuserdomain]') AND name = N'IX_lnuserdomain__expiration_time__create_time__name')
CREATE NONCLUSTERED INDEX [IX_lnuserdomain__expiration_time__create_time__name] ON [dbo].[lnuserdomain] 
(
	[expiration_time] ASC,
	[create_time] ASC,
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[worker]    Script Date: 04/19/2022 15:41:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[worker]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[worker](
	[id] [uniqueidentifier] NOT NULL,
	[process] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[last_ping_time] [datetime] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[active] [bit] NULL,
	[id_division] [uniqueidentifier] NULL,
	[assigned_process] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_object] [uniqueidentifier] NULL,
	[division_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_client] [uniqueidentifier] NULL,
	[delete_time] [datetime] NULL,
	[create_time] [datetime] NULL,
	[public_ip_address] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[expiration_time] [datetime] NULL,
	[id_host] [uniqueidentifier] NULL,
	[id_workerjob] [uniqueidentifier] NULL,
	[id_client_owner] [uniqueidentifier] NULL,
	[id_lnuser] [uniqueidentifier] NULL,
	[id_proxy] [uniqueidentifier] NULL,
	[id_lnuser_for_remote] [uniqueidentifier] NULL,
	[id_proxy_for_remote_scraping] [uniqueidentifier] NULL,
	[dispatch_reservation_id] [uniqueidentifier] NULL,
	[dispatch_reservation_time] [datetime] NULL,
	[dispatch_reservation_times] [int] NULL,
	[dispatch_start_time] [datetime] NULL,
	[dispatch_end_time] [datetime] NULL,
 CONSTRAINT [PK__peer__3213E83F7D0E9093] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[worker]') AND name = N'IX_peer__process__last_ping_time')
CREATE NONCLUSTERED INDEX [IX_peer__process__last_ping_time] ON [dbo].[worker] 
(
	[process] ASC,
	[last_ping_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[workerjob]    Script Date: 04/19/2022 15:23:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[workerjob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[workerjob](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[filename] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_worker] [uniqueidentifier] NOT NULL,
	[id_proxy] [uniqueidentifier] NULL,
	[id_lnuser] [uniqueidentifier] NULL,
	[job_start_time] [datetime] NULL,
	[job_end_time] [datetime] NULL,
	[id_client] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__workerjo__3213E83F663AFBA3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_flywheel_clients]    Script Date: 04/19/2022 15:14:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_flywheel_clients]'))
EXEC dbo.sp_executesql @statement = N'
create view [dbo].[v_flywheel_clients]
as
select c.id, c.name, count(distinct s.id) as subscriptions, count(distinct u.id) as rented_accounts, count(distinct r.id) as owned_accounts
from client c with (nolock)
join [user] r with (nolock) on c.id=r.id_client
left join paypal_subscription s with (nolock) on (c.id=s.id_client and isnull(s.active,0)=1)
left join lnuser u with (nolock) on (u.id_client_allocated=c.id and u.delete_time is null)
left join lnuser e with (nolock) on (e.id_user=r.id and e.delete_time is null)
group by c.id, c.name
having count(s.id)>0 or count(u.id)>0 or count(e.id)>0
'
GO
/****** Object:  View [dbo].[v_aux_onhold_accounts]    Script Date: 04/19/2022 15:24:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_aux_onhold_accounts]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_aux_onhold_accounts]
as
select c.id as id_client, u.id as id_lnuser, c.name, u.username
from lnuser u
join [user] v on v.id=u.id_user
join client d on d.id=v.id_client
join client c on c.id=u.id_client_allocated
where u.edit_profile_end_time is null
and not exists ( -- no esten activos desde hace meses
	select *
	from drl_minutely_stats x with (nolock)
	where x.ininvite_end_time is not null
	and x.ininvite_end_time > dateadd(mm, -3, getdate()) 
	and x.id_client=c.id
	and x.id_lnuser=u.id
)
/*
and not exists (
	select *
	from connection_request_to_user x with (nolock)
	join [user] e with (nolock) on e.id=x.id_user
	where e.id_client=c.id
	and x.id_lnuser=u.id
)
*/
and d.name=''Expanded Venture 2''
and u.delete_time is null
--order by c.name, u.username'
GO
/****** Object:  StoredProcedure [dbo].[spUnlockCaptcha]    Script Date: 04/19/2022 15:15:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUnlockCaptcha]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spUnlockCaptcha]
	@username as varchar(500)
as
	update lnuser
	set status=6,
	status_time=getdate(),
	login_failure_times=0
	where delete_time is null
	and isnull(status,6)=8
	and username=@username;
' 
END
GO
/****** Object:  Table [dbo].[pipeline_lnuser]    Script Date: 04/19/2022 15:15:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pipeline_lnuser](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
 CONSTRAINT [PK__pipeline__3213E83F4DDD6B9C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ__pipeline__A5E55D991398B34F] UNIQUE NONCLUSTERED 
(
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ__pipeline__A5E55D9916751FFA] UNIQUE NONCLUSTERED 
(
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]') AND name = N'IX_pipeline_lnuser__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_pipeline_lnuser__id_lnuser] ON [dbo].[pipeline_lnuser] 
(
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spReAssignLnUser]    Script Date: 04/19/2022 15:15:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spReAssignLnUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- drop procedure spReAssignLnUser
create procedure [dbo].[spReAssignLnUser]
	@username varchar(500),
	@email varchar(500)
as
	declare @n int;

	set @n = (
		select count(*)
		from lnuser
		where username=@username
	);
	if (@n=0)
	begin
		RAISERROR (''LinkedIn account not found.'', 11,1);
		RETURN;
	end;

	set @n = (
		select count(*)
		from [user] 
		where email=@email
	);
	if (@n=0)
	begin
		RAISERROR (''User not found.'', 11,1);
		RETURN;
	end;

	begin transaction;
	
	update lnuser set id_user=(select id from [user] where email=@email) where username=@username;

	update proxy set id_user=(select id from [user] where email=@email) where id=(select id_proxy from lnuser where username=@username);

	delete pipeline_lnuser 
	where id_lnuser=(select id from lnuser where username=@username)
	and id_pipeline not in (
		-- todos los pipelines de este cliente
		select p.id
		from pipeline p
		join [user] u on (u.id=p.id_user and u.id_client=(select id_client from [user] where email=@email))
	) ;
	
	commit;	
' 
END
GO
/****** Object:  Table [dbo].[connection_request_to_user]    Script Date: 04/19/2022 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[connection_request_to_user]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[connection_request_to_user](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[ininvite_start_time] [datetime] NULL,
	[ininvite_end_time] [datetime] NULL,
	[ininvite_tries] [int] NULL,
	[ininvite_hit_time] [datetime] NULL,
	[ininvite_result] [int] NULL,
 CONSTRAINT [PK__connecti__3213E83F4D053985] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_connection_request_to_user] UNIQUE NONCLUSTERED 
(
	[id_lnuser] ASC,
	[id_user] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[signal]    Script Date: 04/19/2022 15:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[signal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[signal](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[to] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_lnuser] [uniqueidentifier] NULL,
	[id_result] [uniqueidentifier] NULL,
	[subject] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[html] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[received_time] [datetime] NULL,
	[id_connection_request_to_user] [uniqueidentifier] NULL,
 CONSTRAINT [PK__signal__3213E83F376AFE21] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[browseractivity]    Script Date: 04/19/2022 15:23:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[browseractivity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[browseractivity](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[filename] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[method] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_worker] [uniqueidentifier] NULL,
	[id_proxy] [uniqueidentifier] NULL,
	[id_lnuser] [uniqueidentifier] NULL,
	[id_previous_activity_of_same_proxy] [uniqueidentifier] NULL,
	[id_previous_activity_of_same_lnuser] [uniqueidentifier] NULL,
	[id_previous_activity_of_same_worker] [uniqueidentifier] NULL,
	[worker_assigned_process] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[profile_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[agent_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[request_ip] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[request_useragent] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_workerjob] [uniqueidentifier] NULL,
 CONSTRAINT [PK__browsera__3213E83F0183BCF2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[browseractivity]') AND name = N'IX_browseractivity__create_time_desc__id_proxy__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_browseractivity__create_time_desc__id_proxy__id_lnuser] ON [dbo].[browseractivity] 
(
	[create_time] DESC,
	[id_proxy] ASC,
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[browseractivity]') AND name = N'IX_browseractivity__id_lnuser__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_browseractivity__id_lnuser__create_time_desc] ON [dbo].[browseractivity] 
(
	[id_lnuser] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[browseractivity]') AND name = N'IX_browseractivity__id_lnuser__id_proxy')
CREATE NONCLUSTERED INDEX [IX_browseractivity__id_lnuser__id_proxy] ON [dbo].[browseractivity] 
(
	[id_lnuser] ASC,
	[id_proxy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[browseractivity]') AND name = N'IX_browseractivity__id_proxy__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_browseractivity__id_proxy__create_time_desc] ON [dbo].[browseractivity] 
(
	[id_proxy] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[browseractivity]') AND name = N'IX_browseractivity__id_worker__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_browseractivity__id_worker__create_time_desc] ON [dbo].[browseractivity] 
(
	[id_worker] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[reserve_proxy]    Script Date: 04/19/2022 15:23:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reserve_proxy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[reserve_proxy] 
@id_lnuser uniqueidentifier,
@minutes_interval int
AS 

	BEGIN TRANSACTION
	IF NOT EXISTS (
		SELECT * 
		FROM browseractivity a WITH (XLOCK)
		WHERE a.create_time > DATEADD(mi, -@minutes_interval, GETDATE())
		AND a.id_lnuser <> @id_lnuser
		AND a.id_proxy = (select id_proxy from lnuser where [id]=@id_lnuser)
	)
	BEGIN
		INSERT INTO browseractivity
		([id], create_time, method, id_proxy, id_lnuser)
		VALUES
		(NEWID(), GETDATE(), ''reserve_proxy'', (select id_proxy from lnuser where [id]=@id_lnuser), @id_lnuser)
	END
	COMMIT TRANSACTION' 
END
GO
/****** Object:  Table [dbo].[lnuserschool]    Script Date: 04/19/2022 15:15:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnuserschool]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnuserschool](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[school_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[degree_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[field_of_study] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[education_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[from_year] [int] NOT NULL,
	[to_year] [int] NOT NULL,
 CONSTRAINT [PK__lnusersc__3213E83F5191F9A2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuserschool]') AND name = N'IX_lnuserschool__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnuserschool__id_lnuser] ON [dbo].[lnuserschool] 
(
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lnuseractivity]    Script Date: 04/19/2022 15:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnuseractivity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnuseractivity](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[code] [int] NOT NULL,
	[id_mimic_profile] [uniqueidentifier] NULL,
	[username] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[param1] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[param2] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[param3] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[param4] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[param5] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_worker] [uniqueidentifier] NULL,
 CONSTRAINT [PK__lnuserac__3213E83F37E53D9E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuseractivity]') AND name = N'IX_lnuseractivity__id_lnuser__code__create_time')
CREATE NONCLUSTERED INDEX [IX_lnuseractivity__id_lnuser__code__create_time] ON [dbo].[lnuseractivity] 
(
	[id_lnuser] ASC,
	[code] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuseractivity]') AND name = N'IX_lnuseractivity__id_lnuser__create_time')
CREATE NONCLUSTERED INDEX [IX_lnuseractivity__id_lnuser__create_time] ON [dbo].[lnuseractivity] 
(
	[id_lnuser] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[boterrorlog]    Script Date: 04/19/2022 15:23:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[boterrorlog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[boterrorlog](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_worker] [uniqueidentifier] NOT NULL,
	[process] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[description] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[screenshot_filename] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_object] [uniqueidentifier] NULL,
 CONSTRAINT [PK__boterror__3213E83F32F1C6AB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[boterrorlog]') AND name = N'IX_boterrorlog__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_boterrorlog__create_time_desc] ON [dbo].[boterrorlog] 
(
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[boterrorlog]') AND name = N'IX_boterrorlog__id_lnuser__id_object__process__create_time_desc')
CREATE NONCLUSTERED INDEX [IX_boterrorlog__id_lnuser__id_object__process__create_time_desc] ON [dbo].[boterrorlog] 
(
	[id_lnuser] ASC,
	[id_object] ASC,
	[process] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[blending_task]    Script Date: 04/19/2022 15:23:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[blending_task]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[blending_task](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[order] [int] NOT NULL,
	[randomizable] [bit] NOT NULL,
	[frequency] [float] NOT NULL,
	[strategy] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[instance] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__blending__3213E83F596B106A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[blending_task_parameter]    Script Date: 04/19/2022 15:23:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[blending_task_parameter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[blending_task_parameter](
	[id] [uniqueidentifier] NOT NULL,
	[id_blending_task] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[order] [int] NOT NULL,
	[type] [int] NOT NULL,
	[value_string] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[value_int_mean] [int] NULL,
	[value_int_deviation] [int] NULL,
	[value_float_mean] [float] NULL,
	[value_float_deviation] [float] NULL,
	[value_bool_p] [float] NULL,
 CONSTRAINT [PK__blending__3213E83F6C7DE4DE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[blending_cookie]    Script Date: 04/19/2022 15:23:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[blending_cookie]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[blending_cookie](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__blending__3213E83F54A65B4D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[automation_check_20_21_22_23]    Script Date: 04/19/2022 15:25:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_20_21_22_23]'))
EXEC dbo.sp_executesql @statement = N'-- select top 10 client_name, message_hours_ago, lead_name, lead_url, account_email, account_password from automation_check_07 order by account_email, inmessage_end_time desc


/*
 * Profiles Edition
 * Check20:�Picture Accuracy
 * Check21:�Headline Accuracy
 * Check22:�Summary Accuracy
 * Check23:�Job Experience Accuracy
 * 
**/
create view [dbo].[automation_check_20_21_22_23]
as
select 
	c.name, 
	u.username as account_email,
	datediff(hh, u.edit_profile_end_time, getdate()) as edition_hours_ago,
	t.name as template_name,
	''https://connectionsphere.com/mac/template?tid='' + cast(t.id as varchar(500)) as template_url
from lnuser u
join client c on (c.id=u.id_client_allocated)
left join lnusertemplate t on t.id=u.id_lnusertemplate
where u.delete_time is null
and u.edit_profile_end_time is not null;
'
GO
/****** Object:  Trigger [tr_on_update_mimic_profile]    Script Date: 04/19/2022 15:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_update_mimic_profile]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_on_update_mimic_profile] ON [dbo].[mimic_profile]
AFTER UPDATE
AS
BEGIN
	INSERT INTO mimic_profile_history([id], id_mimic_profile, create_time, id_client_allocated, id_proxy, delete_time, allowed_for_crowdtrust_traffic, name, auto_regeneration_minutes, disabled_for_heijunka)
	SELECT newid(), b.id, getdate(), b.id_client_allocated, b.id_proxy, b.delete_time, b.allowed_for_crowdtrust_traffic, b.name, b.auto_regeneration_minutes, b.disabled_for_heijunka
	FROM mimic_profile b with (nolock)
	JOIN inserted i with (nolock) on b.id=i.id; -- must do this join to avoid the error "Cannot use text, ntext, or image columns in the ''inserted'' and ''deleted'' tables".
END;
'
GO
/****** Object:  Trigger [tr_on_insert_mimic_profile]    Script Date: 04/19/2022 15:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_on_insert_mimic_profile]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_on_insert_mimic_profile] ON [dbo].[mimic_profile]
AFTER INSERT
AS
BEGIN
	INSERT INTO mimic_profile_history([id], id_mimic_profile, create_time, id_client_allocated, id_proxy, delete_time, allowed_for_crowdtrust_traffic, name, auto_regeneration_minutes, disabled_for_heijunka)
	SELECT newid(), b.id, getdate(), b.id_client_allocated, b.id_proxy, b.delete_time, b.allowed_for_crowdtrust_traffic, b.name, b.auto_regeneration_minutes, b.disabled_for_heijunka
	FROM mimic_profile b with (nolock)
	JOIN inserted i with (nolock) on b.id=i.id; -- must do this join to avoid the error "Cannot use text, ntext, or image columns in the ''inserted'' and ''deleted'' tables".
END;
'
GO
/****** Object:  Table [dbo].[milestone_ssm_drx]    Script Date: 04/19/2022 15:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[milestone_ssm_drx]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[milestone_ssm_drx](
	[id] [uniqueidentifier] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[deadline] [date] NOT NULL,
	[number] [int] NOT NULL,
 CONSTRAINT [PK__mileston__3213E83F1B331F29] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[stat_drl_shared_report]    Script Date: 04/19/2022 15:11:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_report]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[stat_drl_shared_report](
	[id] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[show_testimonial] [bit] NOT NULL,
	[testimonial_client_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[testimonial_client_position] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[testimonial_company_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[testimonial_company_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[testimonial_client_message] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[testimonial_client_picture_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__stat_drl__3213E83F1140912F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_stat_drl_shared_report__id_message] UNIQUE NONCLUSTERED 
(
	[id_message] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[search_message]    Script Date: 04/19/2022 15:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_message]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_message](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__lnsearch__3213E83F7B7489B9] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[search_message]') AND name = N'IX_search_message__id_message')
CREATE NONCLUSTERED INDEX [IX_search_message__id_message] ON [dbo].[search_message] 
(
	[id_message] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[search_message]') AND name = N'IX_search_message__id_message__id_search')
CREATE NONCLUSTERED INDEX [IX_search_message__id_message__id_search] ON [dbo].[search_message] 
(
	[id_message] ASC,
	[id_search] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[on_message_action]    Script Date: 04/19/2022 15:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[on_message_action]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[on_message_action](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[status] [bit] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_search] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
 CONSTRAINT [PK__on_messa__3213E83F0081F2B5] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[message_keyword]    Script Date: 04/19/2022 15:11:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[message_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[message_keyword](
	[id] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[keyword] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[negative] [bit] NOT NULL,
 CONSTRAINT [PK__message___3213E83F6436C10F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[login]    Script Date: 04/19/2022 15:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[login]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[login](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
 CONSTRAINT [PK__login__3213E83F6ABAD62E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[v_prospecting_and_3_month_active_clients]    Script Date: 04/19/2022 15:14:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_prospecting_and_3_month_active_clients]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_prospecting_and_3_month_active_clients]
as
	select distinct u.id_client as id
	from [login] l with (nolock)
	join [user] u with (nolock) on u.id=l.id_user
	where l.create_time > dateadd(mm, -3, getdate())
	union 
	select id from v_flywheel_clients
'
GO
/****** Object:  Table [dbo].[log]    Script Date: 04/19/2022 15:14:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[log]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[log](
	[id] [uniqueidentifier] NOT NULL,
	[id_worker] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[description] [text] COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[pulqui_version] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[process] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[level] [int] NOT NULL,
	[is_error] [bit] NOT NULL,
 CONSTRAINT [PK__log__3213E83F408F9238] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[log]') AND name = N'IX_log__create_time')
CREATE NONCLUSTERED INDEX [IX_log__create_time] ON [dbo].[log] 
(
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lnallocationjob]    Script Date: 04/19/2022 15:34:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnallocationjob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnallocationjob](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_lnsearch] [uniqueidentifier] NULL,
	[allocation_start_time] [datetime] NULL,
	[allocation_end_time] [datetime] NULL,
 CONSTRAINT [PK__lnalloca__3213E83F53F76C67] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lcappend]    Script Date: 04/19/2022 15:34:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lcappend]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lcappend](
	[id] [uniqueidentifier] NOT NULL,
	[id_company] [uniqueidentifier] NOT NULL,
	[type] [numeric](18, 0) NOT NULL,
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[source_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NOT NULL,
 CONSTRAINT [PK__lcappend__3213E83F31573D41] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fnFirstDate]    Script Date: 04/19/2022 15:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnFirstDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
create function [dbo].[fnFirstDate]()
returns datetime
begin
	return ''2016-01-01 00:00:00''
end
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnProxyDiscretion]    Script Date: 04/19/2022 15:34:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnProxyDiscretion]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
create function [dbo].[fnProxyDiscretion](
	@process varchar(500),
	@seconds_to_wait_if_proxy_has_been_reserved_but_didnt_finish int,
	@seconds_to_wait_if_proxy_has_finished_successfully int,
	@seconds_to_wait_if_proxy_has_been_blocked int,
	@seconds_to_wait_for_long_sleep int,
	@stop_from time,
	@stop_until time
)
returns @ret table (id uniqueidentifier not null primary key)
begin
	declare @now time;
	set @now = cast(getdate() as time);

	insert into @ret
	select p.id
	from proxy p with (nolock)
	where 
	p.process=@process and 
	p.delete_time is null and
	not (@now>=@stop_from and @now<@stop_until ) and -- no se puede reservar proxies durante 3 a 4 horas diarias
	(
	 p.reservation_id is null or
	 (
	  ( p.reservation_end_time is null AND isnull(p.reservation_time, dbo.fnFirstDate()) < dateadd(ss,-@seconds_to_wait_if_proxy_has_been_reserved_but_didnt_finish, getdate()) ) or -- caso en que el proxy fue reservado pero nunca inicio o finalizo el crawleo por alguna exepcion
	  ( p.reservation_end_time is not null AND p.reservation_result=0 AND isnull(p.reservation_start_time, dbo.fnFirstDate()) < dateadd(ss, -@seconds_to_wait_if_proxy_has_finished_successfully, getdate()) ) or -- caso en que termino exitoso y pasaron 60 segundos
	  ( p.reservation_end_time is not null AND p.reservation_result=-1 AND isnull(p.reservation_start_time, dbo.fnFirstDate()) < dateadd(ss, -@seconds_to_wait_if_proxy_has_been_blocked, getdate()) ) -- caso en que el proxy fue bloqueado y pasaron 60 minutos
	 )
	) and
	datediff(ss, isnull(time_reached_max_records_before_long_sleep, dbo.fnFirstDate()), getdate()) > @seconds_to_wait_for_long_sleep

	return;
end
' 
END
GO
/****** Object:  StoredProcedure [dbo].[reserveProxyWithDiscretion]    Script Date: 04/19/2022 15:34:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reserveProxyWithDiscretion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create procedure [dbo].[reserveProxyWithDiscretion]
	@reservation_id uniqueidentifier,
	@process varchar(500),
	@seconds_to_wait_if_proxy_has_been_reserved_but_didnt_finish int,
	@seconds_to_wait_if_proxy_has_finished_successfully int,
	@seconds_to_wait_if_proxy_has_been_blocked int,
	@seconds_to_wait_for_long_sleep int,
	@stop_from time,
	@stop_until time
as
begin
	declare @pid as uniqueidentifier ;

	begin transaction ;

	select top 1 @pid = p.id
	from proxy p with (xlock)
	join fnProxyDiscretion(
		@process,
		@seconds_to_wait_if_proxy_has_been_reserved_but_didnt_finish,
		@seconds_to_wait_if_proxy_has_finished_successfully,
		@seconds_to_wait_if_proxy_has_been_blocked,
		@seconds_to_wait_for_long_sleep,
		@stop_from,
		@stop_until
		) d on d.id=p.id ;

	update proxy set reservation_id=@reservation_id, reservation_time=getdate(), reservation_start_time=getdate() where id=@pid ;

	commit transaction ;
end
' 
END
GO
/****** Object:  Table [dbo].[lnconnection]    Script Date: 04/19/2022 15:34:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnconnection]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnconnection](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[type] [int] NOT NULL,
	[incrawl_reservation_id] [uniqueidentifier] NULL,
	[incrawl_reservation_time] [datetime] NULL,
	[incrawl_reservation_times] [int] NULL,
	[incrawl_start_time] [datetime] NULL,
	[incrawl_end_time] [datetime] NULL,
 CONSTRAINT [PK__lnconnec__3213E83F2B6C50BA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnconnection]') AND name = N'IX_lnconnection__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnconnection__id_lnuser] ON [dbo].[lnconnection] 
(
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnconnection]') AND name = N'IX_lnconnection__id_lnuser__incrawl_end_time__type__create_time')
CREATE NONCLUSTERED INDEX [IX_lnconnection__id_lnuser__incrawl_end_time__type__create_time] ON [dbo].[lnconnection] 
(
	[id_lnuser] ASC,
	[incrawl_end_time] ASC,
	[type] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnconnection]') AND name = N'IX_lnconnection__id_profile')
CREATE NONCLUSTERED INDEX [IX_lnconnection__id_profile] ON [dbo].[lnconnection] 
(
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[daily]    Script Date: 04/19/2022 15:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[daily]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[daily](
	[date] [date] NOT NULL,
 CONSTRAINT [PK__daily__D9DE21FC7226EDCC] PRIMARY KEY CLUSTERED 
(
	[date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[daily]') AND name = N'IX_daily__date')
CREATE NONCLUSTERED INDEX [IX_daily__date] ON [dbo].[daily] 
(
	[date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pulqui_minutely_stats]    Script Date: 04/19/2022 15:35:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pulqui_minutely_stats](
	[date] [date] NOT NULL,
	[hour] [numeric](2, 0) NOT NULL,
	[minute] [numeric](2, 0) NOT NULL,
	[id_search] [uniqueidentifier] NULL,
	[datetime] [datetime] NULL,
	[profile_crawl_started] [numeric](18, 0) NULL,
	[profile_crawl_finished] [numeric](18, 0) NULL,
	[company_crawl_started] [numeric](18, 0) NULL,
	[company_crawl_finished] [numeric](18, 0) NULL,
	[profile_append1_started] [numeric](18, 0) NULL,
	[profile_append1_finished] [numeric](18, 0) NULL,
	[profile_append1_hits] [numeric](18, 0) NULL,
	[profile_append4_started] [numeric](18, 0) NULL,
	[profile_append4_finished] [numeric](18, 0) NULL,
	[profile_append4_hits] [numeric](18, 0) NULL,
	[profile_append7_started] [numeric](18, 0) NULL,
	[profile_append7_finished] [numeric](18, 0) NULL,
	[profile_append7_hits] [numeric](18, 0) NULL,
	[id_domain] [uniqueidentifier] NULL,
	[lnsearchvariation_incrawl_started] [numeric](18, 0) NULL,
	[lnsearchvariation_incrawl_finished] [numeric](18, 0) NULL,
	[lnsearchvariation_incrawl_results] [numeric](18, 0) NULL,
	[buffer_incrawl_lnsearchvariation_result_copy_started] [numeric](18, 0) NULL,
	[buffer_incrawl_lnsearchvariation_result_copy_finished] [numeric](18, 0) NULL,
	[buffer_incrawl_lnsearchvariation_result_copy_hits] [numeric](18, 0) NULL,
	[sitemap_crawl_started] [numeric](18, 0) NULL,
	[sitemap_crawl_finished] [numeric](18, 0) NULL,
	[sitemap_crawl_results] [numeric](18, 0) NULL,
	[peopledirectory_crawl_started] [numeric](18, 0) NULL,
	[peopledirectory_crawl_finished] [numeric](18, 0) NULL,
	[peopledirectory_crawl_results] [numeric](18, 0) NULL,
	[profile_export_to_em_started] [numeric](18, 0) NULL,
	[profile_export_to_em_finished] [numeric](18, 0) NULL,
	[profile_export_to_em_hits] [numeric](18, 0) NULL,
	[profile_export_to_crm_started] [numeric](18, 0) NULL,
	[profile_export_to_crm_finished] [numeric](18, 0) NULL,
	[profile_export_to_crm_hits] [numeric](18, 0) NULL,
	[search_flood_started] [numeric](18, 0) NULL,
	[search_flood_finished] [numeric](18, 0) NULL,
	[search_flood_hits] [numeric](18, 0) NULL,
	[profile_snapshot_started] [numeric](18, 0) NULL,
	[profile_snapshot_finished] [numeric](18, 0) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]') AND name = N'IX_ln_minutely_stats')
CREATE NONCLUSTERED INDEX [IX_ln_minutely_stats] ON [dbo].[pulqui_minutely_stats] 
(
	[id_search] ASC,
	[datetime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]') AND name = N'IX_pulqui__minutely_stats__date__hour__minute__id_domain')
CREATE NONCLUSTERED INDEX [IX_pulqui__minutely_stats__date__hour__minute__id_domain] ON [dbo].[pulqui_minutely_stats] 
(
	[date] ASC,
	[hour] ASC,
	[minute] ASC,
	[id_domain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]') AND name = N'IX_pulqui__minutely_stats__date__hour__minute__id_search')
CREATE NONCLUSTERED INDEX [IX_pulqui__minutely_stats__date__hour__minute__id_search] ON [dbo].[pulqui_minutely_stats] 
(
	[date] ASC,
	[hour] ASC,
	[minute] ASC,
	[id_search] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]') AND name = N'IX_pulqui__minutely_stats__date__hour__minute__id_search__id_domain')
CREATE NONCLUSTERED INDEX [IX_pulqui__minutely_stats__date__hour__minute__id_search__id_domain] ON [dbo].[pulqui_minutely_stats] 
(
	[date] ASC,
	[hour] ASC,
	[minute] ASC,
	[id_search] ASC,
	[id_domain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[insertPulquiMinutelyStats3]    Script Date: 04/19/2022 15:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insertPulquiMinutelyStats3]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[insertPulquiMinutelyStats3](@id_search UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)

	BEGIN TRANSACTION
	IF NOT EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_domain IS NULL
		AND m.id_search = @id_search
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''INSERT INTO pulqui_minutely_stats (id_search, [date], [datetime], [hour], [minute]) '' +
		''VALUES ('' +
		''	''''''+cast(@id_search as varchar(500))+'''''', '' +
		''	''''''+cast(@date as varchar(500))+'''''', '' +
		''	''''''+right(''0000''+cast(year(@date) as varchar(4)),4)+''-''+right(''00''+cast(month(@date) as varchar(2)),2)+''-''+right(''00''+cast(day(@date) as varchar(2)),2)+'' ''+right(''00''+cast(@hour as varchar(2)),2)+'':''+right(''00''+cast(@minute as varchar(2)),2)+'':00'''', '' +
		''	''+cast(@hour as varchar(500))+'', '' +
		''	''+cast(@minute as varchar(500))+'') ''
		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[insertPulquiMinutelyStats2]    Script Date: 04/19/2022 15:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insertPulquiMinutelyStats2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[insertPulquiMinutelyStats2](@id_search UNIQUEIDENTIFIER, @id_domain UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)

	BEGIN TRANSACTION
	IF NOT EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search = @id_search 
		AND m.id_domain = @id_domain
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''INSERT INTO pulqui_minutely_stats (id_search, id_domain, [date], [datetime], [hour], [minute]) '' +
		''VALUES ('' +
		''	''''''+cast(@id_search as varchar(500))+'''''', '' +
		''	''''''+cast(@id_domain as varchar(500))+'''''', '' +
		''	''''''+cast(@date as varchar(500))+'''''', '' +
		''	''''''+right(''0000''+cast(year(@date) as varchar(4)),4)+''-''+right(''00''+cast(month(@date) as varchar(2)),2)+''-''+right(''00''+cast(day(@date) as varchar(2)),2)+'' ''+right(''00''+cast(@hour as varchar(2)),2)+'':''+right(''00''+cast(@minute as varchar(2)),2)+'':00'''', '' +
		''	''+cast(@hour as varchar(500))+'', '' +
		''	''+cast(@minute as varchar(500))+'') ''
		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[insertPulquiMinutelyStats1]    Script Date: 04/19/2022 15:35:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insertPulquiMinutelyStats1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[insertPulquiMinutelyStats1](@id_domain UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)

	BEGIN TRANSACTION
	IF NOT EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search IS NULL
		AND m.id_domain = @id_domain
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''INSERT INTO pulqui_minutely_stats (id_domain, [date], [datetime], [hour], [minute]) '' +
		''VALUES ('' +
		''	''''''+cast(@id_domain as varchar(500))+'''''', '' +
		''	''''''+cast(@date as varchar(500))+'''''', '' +
		''	''''''+right(''0000''+cast(year(@date) as varchar(4)),4)+''-''+right(''00''+cast(month(@date) as varchar(2)),2)+''-''+right(''00''+cast(day(@date) as varchar(2)),2)+'' ''+right(''00''+cast(@hour as varchar(2)),2)+'':''+right(''00''+cast(@minute as varchar(2)),2)+'':00'''', '' +
		''	''+cast(@hour as varchar(500))+'', '' +
		''	''+cast(@minute as varchar(500))+'') ''
		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[insertPulquiMinutelyStats0]    Script Date: 04/19/2022 15:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insertPulquiMinutelyStats0]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[insertPulquiMinutelyStats0](@date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)

	BEGIN TRANSACTION
	IF NOT EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE id_search IS NULL 
		AND id_domain IS NULL
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''INSERT INTO pulqui_minutely_stats ([date], [datetime], [hour], [minute]) '' +
		''VALUES ('' +
		''	''''''+cast(@date as varchar(500))+'''''', '' +
		''	''''''+right(''0000''+cast(year(@date) as varchar(4)),4)+''-''+right(''00''+cast(month(@date) as varchar(2)),2)+''-''+right(''00''+cast(day(@date) as varchar(2)),2)+'' ''+right(''00''+cast(@hour as varchar(2)),2)+'':''+right(''00''+cast(@minute as varchar(2)),2)+'':00'''', '' +
		''	''+cast(@hour as varchar(500))+'', '' +
		''	''+cast(@minute as varchar(500))+'') ''
		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[insertPulquiMinutelyStats]    Script Date: 04/19/2022 15:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insertPulquiMinutelyStats]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[insertPulquiMinutelyStats](@id_search UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)

	BEGIN TRANSACTION
	IF NOT EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search = @id_search 
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''INSERT INTO pulqui_minutely_stats (id_search, [date], [datetime], [hour], [minute]) '' +
		''VALUES ('' +
		''	''''''+cast(@id_search as varchar(500))+'''''', '' +
		''	''''''+cast(@date as varchar(500))+'''''', '' +
		''	''''''+right(''0000''+cast(year(@date) as varchar(4)),4)+''-''+right(''00''+cast(month(@date) as varchar(2)),2)+''-''+right(''00''+cast(day(@date) as varchar(2)),2)+'' ''+right(''00''+cast(@hour as varchar(2)),2)+'':''+right(''00''+cast(@minute as varchar(2)),2)+'':00'''', '' +
		''	''+cast(@hour as varchar(500))+'', '' +
		''	''+cast(@minute as varchar(500))+'') ''
		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[insertEmMinutelyStats]    Script Date: 04/19/2022 15:35:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insertEmMinutelyStats]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--drop procedure insertEmMinutelyStats;
CREATE PROCEDURE [dbo].[insertEmMinutelyStats](
	@id_emcampaign UNIQUEIDENTIFIER, 
	@smtp_url VARCHAR(500), 
	@smtp_port VARCHAR(500), 
	@smtp_user VARCHAR(500), 
	@smtp_password VARCHAR(500), 
	@date DATE, 
	@hour NUMERIC(2,0), 
	@minute NUMERIC(2,0)
)
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)

	BEGIN TRANSACTION
	IF NOT EXISTS (
		SELECT * 
		FROM em_minutely_stats m WITH (XLOCK)
		WHERE m.id_emcampaign = @id_emcampaign
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
		AND m.[smtp_url] = @smtp_url
		AND m.[smtp_port] = @smtp_port
		AND m.[smtp_user] = @smtp_user
		AND m.[smtp_password] = @smtp_password
	)
	BEGIN 
		SET @sql = 
		''INSERT INTO em_minutely_stats (id_emcampaign, [date], [datetime], [hour], [minute], smtp_url, smtp_port, smtp_user, smtp_password) '' +
		''VALUES ('' +
		''	''''''+cast(@id_emcampaign as varchar(500))+'''''', '' +
		''	''''''+cast(@date as varchar(500))+'''''', '' +
		''	''''''+right(''0000''+cast(year(@date) as varchar(4)),4)+''-''+right(''00''+cast(month(@date) as varchar(2)),2)+''-''+right(''00''+cast(day(@date) as varchar(2)),2)+'' ''+right(''00''+cast(@hour as varchar(2)),2)+'':''+right(''00''+cast(@minute as varchar(2)),2)+'':00'''', '' +
		''	''+cast(@hour as varchar(500))+'', '' +
		''	''+cast(@minute as varchar(500))+'', '' +
		''	''''''+@smtp_url+'''''', '' +
		''	''''''+@smtp_port+'''''', '' +
		''	''''''+@smtp_user+'''''', '' +
		''	''''''+@smtp_password+'''''') ''
		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[incrementPulquiMinutelyStats3]    Script Date: 04/19/2022 15:35:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incrementPulquiMinutelyStats3]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[incrementPulquiMinutelyStats3](@column_name VARCHAR(500), @id_search UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0), @n NUMERIC(18,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	
	EXEC [dbo].insertPulquiMinutelyStats3 @id_search, @date, @hour, @minute

	BEGIN TRANSACTION
	IF EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search = @id_search
		AND m.id_domain IS NULL
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''UPDATE pulqui_minutely_stats '' +
		''SET ''+@column_name+'' = ISNULL(''+@column_name+'',0) + ''+CAST(@n AS VARCHAR(500))+'' '' +
		''WHERE id_domain IS NULL '' +
		''AND id_search = ''''''+CAST(@id_search AS VARCHAR(500))+'''''' '' +
		''AND [date] = ''''''+CAST(@date AS VARCHAR(500))+'''''' '' +
		''AND [hour] = ''+CAST(@hour AS VARCHAR(500))+'' '' +
		''AND [minute] = ''+CAST(@minute AS VARCHAR(500))+'' ''

		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[incrementPulquiMinutelyStats2]    Script Date: 04/19/2022 15:35:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incrementPulquiMinutelyStats2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[incrementPulquiMinutelyStats2](@column_name VARCHAR(500), @id_search UNIQUEIDENTIFIER, @id_domain UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0), @n NUMERIC(18,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	
	EXEC [dbo].insertPulquiMinutelyStats2 @id_search, @id_domain, @date, @hour, @minute

	BEGIN TRANSACTION
	IF EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search = @id_search 
		AND m.id_domain = @id_domain
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''UPDATE pulqui_minutely_stats '' +
		''SET ''+@column_name+'' = ISNULL(''+@column_name+'',0) + ''+CAST(@n AS VARCHAR(500))+'' '' +
		''WHERE id_search = ''''''+CAST(@id_search AS VARCHAR(500))+'''''' '' +
		''AND id_domain = ''''''+CAST(@id_domain AS VARCHAR(500))+'''''' '' +
		''AND [date] = ''''''+CAST(@date AS VARCHAR(500))+'''''' '' +
		''AND [hour] = ''+CAST(@hour AS VARCHAR(500))+'' '' +
		''AND [minute] = ''+CAST(@minute AS VARCHAR(500))+'' ''

		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[incrementPulquiMinutelyStats1]    Script Date: 04/19/2022 15:35:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incrementPulquiMinutelyStats1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[incrementPulquiMinutelyStats1](@column_name VARCHAR(500), @id_domain UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0), @n NUMERIC(18,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	
	EXEC [dbo].insertPulquiMinutelyStats1 @id_domain, @date, @hour, @minute

	BEGIN TRANSACTION
	IF EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search IS NULL
		AND m.id_domain = @id_domain
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''UPDATE pulqui_minutely_stats '' +
		''SET ''+@column_name+'' = ISNULL(''+@column_name+'',0) + ''+CAST(@n AS VARCHAR(500))+'' '' +
		''WHERE id_search IS NULL '' +
		''AND id_domain = ''''''+CAST(@id_domain AS VARCHAR(500))+'''''' '' +
		''AND [date] = ''''''+CAST(@date AS VARCHAR(500))+'''''' '' +
		''AND [hour] = ''+CAST(@hour AS VARCHAR(500))+'' '' +
		''AND [minute] = ''+CAST(@minute AS VARCHAR(500))+'' ''

		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[incrementPulquiMinutelyStats0]    Script Date: 04/19/2022 15:35:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incrementPulquiMinutelyStats0]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[incrementPulquiMinutelyStats0](@column_name VARCHAR(500), @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0), @n NUMERIC(18,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	
	EXEC [dbo].insertPulquiMinutelyStats0 @date, @hour, @minute

	BEGIN TRANSACTION
	IF EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search IS NULL
		AND m.id_domain IS NULL
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''UPDATE pulqui_minutely_stats '' +
		''SET ''+@column_name+'' = ISNULL(''+@column_name+'',0) + ''+CAST(@n AS VARCHAR(500))+'' '' +
		''WHERE id_search IS NULL '' +
		''AND id_domain IS NULL '' +
		''AND [date] = ''''''+CAST(@date AS VARCHAR(500))+'''''' '' +
		''AND [hour] = ''+CAST(@hour AS VARCHAR(500))+'' '' +
		''AND [minute] = ''+CAST(@minute AS VARCHAR(500))+'' ''

		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[incrementPulquiMinutelyStats]    Script Date: 04/19/2022 15:35:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incrementPulquiMinutelyStats]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[incrementPulquiMinutelyStats](@column_name VARCHAR(500), @id_search UNIQUEIDENTIFIER, @date DATE, @hour NUMERIC(2,0), @minute NUMERIC(2,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	
	EXEC [dbo].insertPulquiMinutelyStats @id_search, @date, @hour, @minute

	BEGIN TRANSACTION
	IF EXISTS (
		SELECT * 
		FROM pulqui_minutely_stats m WITH (XLOCK)
		WHERE m.id_search = @id_search 
		AND m.[date] = @date
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''UPDATE pulqui_minutely_stats '' +
		''SET ''+@column_name+'' = ISNULL(''+@column_name+'',0) + 1 '' +
		''WHERE id_search = ''''''+CAST(@id_search AS VARCHAR(500))+'''''' '' +
		''AND [date] = ''''''+CAST(@date AS VARCHAR(500))+'''''' '' +
		''AND [hour] = ''+CAST(@hour AS VARCHAR(500))+'' '' +
		''AND [minute] = ''+CAST(@minute AS VARCHAR(500))+'' ''

		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[incrementEmMinutelyStats]    Script Date: 04/19/2022 15:35:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[incrementEmMinutelyStats]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- drop procedure incrementEmMinutelyStats
CREATE PROCEDURE [dbo].[incrementEmMinutelyStats](@column_name VARCHAR(500), 
	@id_emcampaign UNIQUEIDENTIFIER, 
	@smtp_url VARCHAR(500), 
	@smtp_port VARCHAR(500), 
	@smtp_user VARCHAR(500), 
	@smtp_password VARCHAR(500), 
	@date DATE, 
	@hour NUMERIC(2,0), 
	@minute NUMERIC(2,0))
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	
	EXEC [dbo].insertEmMinutelyStats @id_emcampaign, @smtp_url, @smtp_port, @smtp_user, @smtp_password, @date, @hour, @minute

	BEGIN TRANSACTION
	IF EXISTS (
		SELECT * 
		FROM em_minutely_stats m WITH (XLOCK)
		WHERE m.id_emcampaign = @id_emcampaign
		AND m.[date] = @date
		AND m.[smtp_url] = @smtp_url
		AND m.[smtp_port] = @smtp_port
		AND m.[smtp_user] = @smtp_user
		AND m.[smtp_password] = @smtp_password
		AND m.[hour] = @hour
		AND m.[minute] = @minute
	)
	BEGIN
		SET @sql = 
		''UPDATE em_minutely_stats '' +
		''SET ''+@column_name+'' = ISNULL(''+@column_name+'',0) + 1 '' +
		''WHERE id_emcampaign = ''''''+CAST(@id_emcampaign AS VARCHAR(500))+'''''' '' +
		''AND [smtp_url] = ''''''+CAST(@smtp_url AS VARCHAR(500))+'''''' '' +
		''AND [smtp_port] = ''''''+CAST(@smtp_port AS VARCHAR(500))+'''''' '' +
		''AND [smtp_user] = ''''''+CAST(@smtp_user AS VARCHAR(500))+'''''' '' +
		''AND [smtp_password] = ''''''+CAST(@smtp_password AS VARCHAR(500))+'''''' '' +
		''AND [date] = ''''''+CAST(@date AS VARCHAR(500))+'''''' '' +
		''AND [hour] = ''+CAST(@hour AS VARCHAR(500))+'' '' +
		''AND [minute] = ''+CAST(@minute AS VARCHAR(500))+'' ''

		EXEC sp_executesql @sql
	END
	COMMIT TRANSACTION
END
' 
END
GO
/****** Object:  View [dbo].[v_lngroup]    Script Date: 04/19/2022 15:16:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_lngroup]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_lngroup] as
select [id], id_user
from lngroup

'
GO
/****** Object:  Table [dbo].[search_lngroup]    Script Date: 04/19/2022 15:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_lngroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_lngroup](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lngroup] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__search_l__3213E83F3A27B1C1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[milestone_ipj_lgb]    Script Date: 04/19/2022 15:16:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[milestone_ipj_lgb]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[milestone_ipj_lgb](
	[id] [uniqueidentifier] NOT NULL,
	[id_lngroup] [uniqueidentifier] NOT NULL,
	[deadline] [date] NOT NULL,
	[number] [int] NOT NULL,
 CONSTRAINT [PK__mileston__3213E83F166E6A0C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lngroupgrowth]    Script Date: 04/19/2022 15:16:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lngroupgrowth]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lngroupgrowth](
	[id] [uniqueidentifier] NOT NULL,
	[id_lngroup] [uniqueidentifier] NOT NULL,
	[crawl_time] [datetime] NOT NULL,
	[members] [numeric](18, 0) NOT NULL,
	[stat_difference_members] [numeric](18, 0) NULL,
	[stat_difference_seconds] [numeric](18, 0) NULL,
 CONSTRAINT [PK__lngroupg__3213E83F1D4655FB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnMilestonesWorkDoneGrowth]    Script Date: 04/19/2022 15:34:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnMilestonesWorkDoneGrowth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnMilestonesWorkDoneGrowth](@cid UNIQUEIDENTIFIER, @from_time DATETIME, @to_time DATETIME)
RETURNS TABLE
AS
RETURN 
(
	select u.id_client, g.id as id_object, g.name as object_name, max(w.members)-min(w.members) as growth
	from [user] u with (nolock)
	join lngroup g with (nolock) on u.id=g.id_user
	join lngroupgrowth w with (nolock) on (g.id=w.id_lngroup and w.crawl_time>=@from_time and w.crawl_time<=@to_time)
	where u.id_client=@cid
	group by u.id_client, g.id, g.name
)
' 
END
GO
/****** Object:  Table [dbo].[lnchat]    Script Date: 04/19/2022 15:20:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnchat](
	[id] [uniqueidentifier] NOT NULL,
	[id_result] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NULL,
	[id_lnchat_previous] [uniqueidentifier] NULL,
	[direction] [int] NOT NULL,
	[body] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[inmessage_start_time] [datetime] NULL,
	[inmessage_end_time] [datetime] NULL,
	[create_time] [datetime] NULL,
	[opened] [bit] NULL,
	[positive] [bit] NULL,
	[inmessage_tries] [int] NULL,
	[recover_needed] [bit] NULL,
	[recover_try_times] [datetime] NULL,
	[recover_start_time] [datetime] NULL,
	[recover_end_time] [datetime] NULL,
	[recover_tries] [int] NULL,
	[delete_time] [datetime] NULL,
	[wlt_enabled] [bit] NULL,
	[aux_add_to_movement] [bit] NULL,
	[gct] [bit] NULL,
	[gct_id_user] [uniqueidentifier] NULL,
	[id_user] [uniqueidentifier] NULL,
	[unsubscribe] [bit] NULL,
 CONSTRAINT [PK__lnchat__3213E83F0C9F15BB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lncat__create_time__recover_end_time__recover_needed__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lncat__create_time__recover_end_time__recover_needed__id_lnuser] ON [dbo].[lnchat] 
(
	[create_time] ASC,
	[recover_end_time] ASC,
	[recover_needed] ASC,
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__create_time__direction__inmessage_end_time__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__create_time__direction__inmessage_end_time__id_result] ON [dbo].[lnchat] 
(
	[create_time] ASC,
	[direction] ASC,
	[inmessage_end_time] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__delete_time__inmessage_end_time__create_time__direction__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__delete_time__inmessage_end_time__create_time__direction__id_result] ON [dbo].[lnchat] 
(
	[delete_time] ASC,
	[inmessage_end_time] ASC,
	[create_time] ASC,
	[direction] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__direction')
CREATE NONCLUSTERED INDEX [IX_lnchat__direction] ON [dbo].[lnchat] 
(
	[direction] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__direction__create_time__id_message')
CREATE NONCLUSTERED INDEX [IX_lnchat__direction__create_time__id_message] ON [dbo].[lnchat] 
(
	[direction] ASC,
	[create_time] ASC,
	[id_message] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__direction__id_lnuser__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__direction__id_lnuser__id_result] ON [dbo].[lnchat] 
(
	[direction] ASC,
	[id_lnuser] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__direction__inmessage_end_time__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__direction__inmessage_end_time__id_result] ON [dbo].[lnchat] 
(
	[direction] ASC,
	[inmessage_end_time] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__direction__recover_needed')
CREATE NONCLUSTERED INDEX [IX_lnchat__direction__recover_needed] ON [dbo].[lnchat] 
(
	[direction] ASC,
	[recover_needed] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__direction__recover_needed__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__direction__recover_needed__id_result] ON [dbo].[lnchat] 
(
	[direction] ASC,
	[recover_needed] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__gct__gct_id_user__create_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__gct__gct_id_user__create_time] ON [dbo].[lnchat] 
(
	[gct] ASC,
	[gct_id_user] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__gct__gct_id_user__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__gct__gct_id_user__inmessage_end_time] ON [dbo].[lnchat] 
(
	[gct] ASC,
	[gct_id_user] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnchat_previous__id_message__id_result__create_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnchat_previous__id_message__id_result__create_time] ON [dbo].[lnchat] 
(
	[id_lnchat_previous] ASC,
	[id_message] ASC,
	[id_result] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__direction__inmessage_end_time__inmessage_tries')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__direction__inmessage_end_time__inmessage_tries] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[direction] ASC,
	[inmessage_end_time] ASC,
	[inmessage_tries] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__direction__inmessage_end_time__inmessage_tries__id_message__wlt_enabled__create_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__direction__inmessage_end_time__inmessage_tries__id_message__wlt_enabled__create_time] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[direction] ASC,
	[inmessage_end_time] ASC,
	[inmessage_tries] ASC,
	[id_message] ASC,
	[wlt_enabled] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__direction__inmessage_tries__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__direction__inmessage_tries__inmessage_end_time] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[direction] ASC,
	[inmessage_tries] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__direction__inmessages_tries__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__direction__inmessages_tries__inmessage_end_time] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[direction] ASC,
	[inmessage_tries] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__id_result] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__id_result__direction')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__id_result__direction] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[id_result] ASC,
	[direction] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__id_result__direction__create_time__inmessage_end_time__gct')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__id_result__direction__create_time__inmessage_end_time__gct] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[id_result] ASC,
	[direction] ASC,
	[create_time] ASC,
	[inmessage_end_time] ASC,
	[gct] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__id_result__direction__inmessage_end_time_desc')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__id_result__direction__inmessage_end_time_desc] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[id_result] ASC,
	[direction] ASC,
	[inmessage_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_lnuser__recover_start_time__recover_needed__create_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_lnuser__recover_start_time__recover_needed__create_time] ON [dbo].[lnchat] 
(
	[id_lnuser] ASC,
	[recover_start_time] ASC,
	[recover_needed] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_message__id_lnuser__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_message__id_lnuser__id_result] ON [dbo].[lnchat] 
(
	[id_message] ASC,
	[id_lnuser] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_message__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_message__id_result] ON [dbo].[lnchat] 
(
	[id_message] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_result] ON [dbo].[lnchat] 
(
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_result__direction__inmessage_end_time__opened__create_time__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_result__direction__inmessage_end_time__opened__create_time__id_lnuser] ON [dbo].[lnchat] 
(
	[id_result] ASC,
	[direction] ASC,
	[inmessage_end_time] ASC,
	[opened] ASC,
	[create_time] ASC,
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_result__id')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_result__id] ON [dbo].[lnchat] 
(
	[id_result] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_result__inmessage_end_time__direction__inmessage_tries__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_result__inmessage_end_time__direction__inmessage_tries__id_lnuser] ON [dbo].[lnchat] 
(
	[id_result] ASC,
	[inmessage_end_time] ASC,
	[direction] ASC,
	[inmessage_tries] ASC,
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__id_result__wlt_enabled__inmessage_end_time')
CREATE NONCLUSTERED INDEX [IX_lnchat__id_result__wlt_enabled__inmessage_end_time] ON [dbo].[lnchat] 
(
	[id_result] ASC,
	[wlt_enabled] ASC,
	[inmessage_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__create_time__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__create_time__id_result] ON [dbo].[lnchat] 
(
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__desc')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__desc] ON [dbo].[lnchat] 
(
	[inmessage_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__direction__id_message__id_lnuser__inmessage_tries')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__direction__id_message__id_lnuser__inmessage_tries] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[direction] ASC,
	[id_message] ASC,
	[id_lnuser] ASC,
	[inmessage_tries] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__id_lnuser] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__id_message__id_lnuser__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__id_message__id_lnuser__id_result] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[id_message] ASC,
	[id_lnuser] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__id_result] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__id_result__id_message')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__id_result__id_message] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[id_result] ASC,
	[id_message] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__inmessage_start_time__id')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__inmessage_start_time__id] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[inmessage_start_time] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__inmessage_start_time_desc__create_time__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__inmessage_start_time_desc__create_time__id_lnuser] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[inmessage_start_time] DESC,
	[create_time] ASC,
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__inmessage_tries__id_message__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__inmessage_tries__id_message__id_result] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[inmessage_tries] ASC,
	[id_message] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time__inmessage_tries__id_result')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time__inmessage_tries__id_result] ON [dbo].[lnchat] 
(
	[inmessage_end_time] ASC,
	[inmessage_tries] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__inmessage_end_time_desc')
CREATE NONCLUSTERED INDEX [IX_lnchat__inmessage_end_time_desc] ON [dbo].[lnchat] 
(
	[inmessage_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchat]') AND name = N'IX_lnchat__recover_needed__recover_end_time__id_lnchat_previous__recover_tries__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnchat__recover_needed__recover_end_time__id_lnchat_previous__recover_tries__id_lnuser] ON [dbo].[lnchat] 
(
	[recover_needed] ASC,
	[recover_end_time] ASC,
	[id_lnchat_previous] ASC,
	[recover_tries] ASC,
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_PROSPECTING_LNUSER_STEALTH]    Script Date: 04/19/2022 15:20:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_PROSPECTING_LNUSER_STEALTH]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[V_PROSPECTING_LNUSER_STEALTH]
AS
SELECT 
	u.id,
	u.username, 
	
	count(distinct a.id) as login_attempts_last_hour, 
	isnull(u.drx_max_logins_per_hour, c.drx_max_logins_per_hour) as allowed_login_attempts_per_hour,
	
	count(distinct b.id) as login_attempts_last_day,
	isnull(u.drx_max_logins_per_day, c.drx_max_logins_per_day) as allowed_login_attempts_per_day,

	count(distinct h.id) as invites_last_hour,
	isnull(u.drx_max_invitations_per_hour, c.drx_max_invitations_per_hour) as allowed_invites_per_hour,

	count(distinct i.id) as invites_last_day,
	isnull(u.drx_max_invitations_per_day, c.drx_max_invitations_per_day) as allowed_invites_per_day,

	count(distinct j.id) as messages_last_hour,
	isnull(u.drx_max_messages_per_hour, c.drx_max_messages_per_hour) as allowed_messages_per_hour,

	count(distinct k.id) as messages_last_day,
	isnull(u.drx_max_messages_per_day, c.drx_max_messages_per_day) as allowed_messages_per_day

FROM lnuser u WITH (NOLOCK) 

join [user] e with (nolock) on e.id=u.id_user -- user owner of this account
join client c with (nolock) on c.id=e.id_client

left join lnuseractivity a with (nolock) on ( u.id=a.id_lnuser and isnull(a.code,0)=1 and a.create_time>dateadd(hh,-1,getdate()) )
left join lnuseractivity b with (nolock) on ( u.id=b.id_lnuser and isnull(b.code,0)=1 and b.create_time>dateadd(dd,-1,getdate()) )

-- invites last hour
left join lnchat h with (nolock) on ( 
	u.id=h.id_lnuser and 
	h.direction=0 and 
	h.inmessage_end_time is not null and
	h.inmessage_end_time > dateadd(hh, -1, getdate()) and
	( -- chat is linked to an invitation message
		h.id_message in ( select id from [message] with (nolock) where isnull(trigger_type,0)=0 )
	)
)

-- invites last hour
left join lnchat i with (nolock) on ( 
	u.id=i.id_lnuser and 
	i.direction=0 and 
	i.inmessage_end_time is not null and
	i.inmessage_end_time > dateadd(dd, -1, getdate()) and
	( -- chat is linked to an invitation message
		i.id_message in ( select id from [message] with (nolock) where isnull(trigger_type,0)=0 )
	)
)

-- messages last hour
left join lnchat j with (nolock) on ( 
	u.id=j.id_lnuser and 
	j.direction=0 and 
	j.inmessage_end_time is not null and
	j.inmessage_end_time > dateadd(hh, -1, getdate()) and
	( -- chat is NOT linked to an invitation message
		j.id_message is null
		or
		j.id_message in ( select id from [message] with (nolock) where isnull(trigger_type,0)>0 )
	)
)

-- messages last day
left join lnchat k with (nolock) on ( 
	u.id=k.id_lnuser and 
	k.direction=0 and 
	k.inmessage_end_time is not null and
	k.inmessage_end_time > dateadd(hh, -1, getdate()) and
	( -- chat is NOT linked to an invitation message
		k.id_message is null
		or
		k.id_message in ( select id from [message] with (nolock) where isnull(trigger_type,0)>0 )
	)
)

WHERE u.delete_time is null
GROUP BY 
	u.id, 
	u.username,

	u.drx_max_logins_per_hour,
	u.drx_max_logins_per_day,
	u.drx_max_invitations_per_hour, 
	u.drx_max_invitations_per_day, 
	u.drx_max_messages_per_hour,
	u.drx_max_messages_per_day,

	c.drx_max_logins_per_hour,
	c.drx_max_logins_per_day,
	c.drx_max_invitations_per_hour, 
	c.drx_max_invitations_per_day, 
	c.drx_max_messages_per_hour,
	c.drx_max_messages_per_day;
'
GO
/****** Object:  View [dbo].[v_prospecting_lnuser_pending_manual_chats]    Script Date: 04/19/2022 15:20:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_prospecting_lnuser_pending_manual_chats]'))
EXEC dbo.sp_executesql @statement = N'
create view [dbo].[v_prospecting_lnuser_pending_manual_chats]
as
select 
	v.id,
	v.username,
	v.allowed_login_attempts_per_day - v.login_attempts_last_day as allowed_login_attempts_right_now,
	v.allowed_invites_per_day - v.invites_last_day as allowed_invites_right_now,
	v.allowed_messages_per_day - v.messages_last_day as allowed_messages_right_now,
	count(distinct h.id) as pending_manual_chats

from V_PROSPECTING_LNUSER_STEALTH v
join lnchat h with (nolock) on v.id=h.id_lnuser
join [user] u with (nolock) on u.id=h.id_user -- chat has been created by a [user] (not by automation)

where isnull(h.direction,0) = 0 -- is an outgoing message
and h.create_time > dateadd(hh,-36,getdate()) -- it is not an aged message
and h.inmessage_end_time is null -- message is still pending
and isnull(h.inmessage_tries, 0) < 3 -- message didn''t fail 3 times or more
and ( -- chat is NOT a connection request
	h.id_message is null
	or
	h.id_message in ( select id from [message] where isnull(trigger_type,0)>0 )
) 
and not exists ( -- no incoming message after the manual message creation
	select i.id
	from lnchat i with (nolock) 
	where i.id_result=h.id_result
	and i.id_lnuser=h.id_lnuser
	and isnull(i.direction,0)=1
	and i.create_time > h.create_time
)

group by
	v.id,
	v.username,
	v.allowed_login_attempts_per_day,
	v.login_attempts_last_day,
	v.allowed_invites_per_day,
	v.invites_last_day,
	v.allowed_messages_per_day,
	v.messages_last_day
'
GO
/****** Object:  View [dbo].[v_prospecting_lnchat_pending_manual]    Script Date: 04/19/2022 15:21:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_prospecting_lnchat_pending_manual]'))
EXEC dbo.sp_executesql @statement = N'
create view [dbo].[v_prospecting_lnchat_pending_manual]
as
select 
	h.id,
	h.body,
	u.email as created_by,
	v.id as id_lnuser,
	h.id_result as id_result,
	v.username,
	v.allowed_login_attempts_per_day - v.login_attempts_last_day as allowed_login_attempts_right_now,
	v.allowed_invites_per_day - v.invites_last_day as allowed_invites_right_now,
	v.allowed_messages_per_day - v.messages_last_day as allowed_messages_right_now

from V_PROSPECTING_LNUSER_STEALTH v
join lnchat h with (nolock) on v.id=h.id_lnuser
join [user] u with (nolock) on u.id=h.id_user -- chat has been created by a [user] (not by automation)

where isnull(h.direction,0) = 0 -- is an outgoing message
and h.create_time > dateadd(hh,-36,getdate()) -- it is not an aged message
and h.inmessage_end_time is null -- message is still pending
and isnull(h.inmessage_tries, 0) < 3 -- message didn''t fail 3 times or more
and ( -- chat is NOT a connection request
	h.id_message is null
	or
	h.id_message in ( select id from [message] where isnull(trigger_type,0)>0 )
) 
and not exists ( -- no incoming message after the manual message creation
	select i.id
	from lnchat i with (nolock) 
	where i.id_result=h.id_result
	and i.id_lnuser=h.id_lnuser
	and isnull(i.direction,0)=1
	and i.create_time > h.create_time
)
/*
group by
	h.id,
	h.body,
	u.email,
	v.id,
	h.id_result,
	v.username,
	v.allowed_login_attempts_per_day,
	v.login_attempts_last_day,
	v.allowed_invites_per_day,
	v.invites_last_day,
	v.allowed_messages_per_day,
	v.messages_last_day
*/'
GO
/****** Object:  StoredProcedure [dbo].[updateDrlMinutelyStats]    Script Date: 04/19/2022 15:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[updateDrlMinutelyStats]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[updateDrlMinutelyStats](@id_result UNIQUEIDENTIFIER, @id_lnuser UNIQUEIDENTIFIER, @id_message UNIQUEIDENTIFIER)
AS
BEGIN
	DECLARE @sql NVARCHAR(4000)
	DECLARE @n NUMERIC(18,0);
	DECLARE @m NUMERIC(18,0);
	DECLARE @dt DATETIME;
	DECLARE @dt1 DATETIME;
	DECLARE @dt2 DATETIME;
	DECLARE @gct BIT;
	DECLARE @gct_id_user UNIQUEIDENTIFIER;
	DECLARE @id UNIQUEIDENTIFIER; -- id of message

	-- si NO existe un registro en la tabla de estadisticas, para este result, lnuser y mensaje ...	
	BEGIN TRANSACTION
	select @n = count(*) 
	from drl_minutely_stats x with (xlock) -- bloqueo el registro de movimientos
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	if (@n=0)
	begin
		-- ... lo inserto
		insert into drl_minutely_stats 
		(id_client, id_search, id_pipeline, id_message, id_lnuser, id_result, id_profile)
		select distinct top 1 u.id_client, r.id_search, m.id_pipeline, m.id, h.id_lnuser, h.id_result, r.id_profile
		from result r with (nolock)
		join lnchat h with (nolock) on r.id=h.id_result
		join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=0)
		join [user] u with (nolock) on u.id=m.id_user
		where h.id_result = @id_result
		and h.id_lnuser = @id_lnuser
		and h.id_message = @id_message;
	end
	COMMIT TRANSACTION;
	
	-- INVITATION MESSAGES
	-- ininvite_start_time
	-- ininvite_end_time
	update x set
	x.ininvite_start_time = h.inmessage_start_time,
	x.ininvite_end_time = h.inmessage_end_time
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on h.id_result=x.id_result
	join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=0 and isnull(h.direction,0)=0)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;

	-- INVITATIONS ACCEPTANCE - NEW CONNECTIONS
	-- ininvite_hit_time
	set @dt=null;
	select @dt = min(h.create_time)
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=3)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	-- 
	update drl_minutely_stats set ininvite_hit_time = @dt where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;
		
	-- INTRODUCTION MESSAGES
	-- id_message_1
	-- inmessage_start_time
	-- inmessage_end_time
	set @dt1=null;
	set @dt2=null;
	set @id=null;
	set @gct=null;	
	set @gct_id_user=null;	
	select top 1 @dt1 = h.inmessage_start_time, @dt2 = h.inmessage_end_time, @id = m.id, @gct=h.gct, @gct_id_user=h.gct_id_user
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=0 and h.delete_time is null)
	join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=1)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message
	order by h.create_time; -- replicate the first intro messages created
	-- 
	update drl_minutely_stats set inmessage_1_start_time = @dt1, inmessage_1_end_time = @dt2, id_message_1 = @id, gct_1 = @gct, gct_1_id_user = @gct_id_user where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;

	-- WELCOME MESSAGE
	-- id_message_2
	-- inmessage_start_time
	-- inmessage_end_time
	set @dt1=null;
	set @dt2=null;
	set @id=null;
	set @gct=null;	
	set @gct_id_user=null;	
	select top 1 @dt1 = h.inmessage_start_time, @dt2 = h.inmessage_end_time, @id = m.id, @gct=h.gct, @gct_id_user=h.gct_id_user
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=0 and h.delete_time is null)
	join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=2)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message
	order by h.create_time; -- replicate the first welcome messages created
	-- 
	update drl_minutely_stats set inmessage_start_time = @dt1, inmessage_end_time = @dt2, id_message_2 = @id, gct_2 = @gct, gct_2_id_user = @gct_id_user where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;

	-- POSITIVE REPLY
	-- inreply_positive
	set @dt=null;
	select @dt = max(h.create_time)
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=1 and isnull(h.positive,0)=1 and h.delete_time is null)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	if (@dt is not null)
		begin
			update drl_minutely_stats set inreply_positive = 1 where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;		
		end
	else
		begin
			update drl_minutely_stats set inreply_positive = 0 where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;		
		end
	
	-- LAST REPLY
	-- inreply_time
	set @dt=null;
	select @dt = max(h.create_time)
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on (x.id_result=h.id_result and isnull(h.direction,0)=1 /*and isnull(h.positive,0)=1*/ and h.delete_time is null)
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message;
	--
	update drl_minutely_stats set inreply_time = @dt where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;				
	
	-- TRANSFER MESSAGES
	-- wlt_time
	set @dt=null;
	set @gct=null;
	set @gct_id_user=null;	
	select top 1 @dt = h.inmessage_end_time, @gct=h.gct, @gct_id_user=h.gct_id_user
	from drl_minutely_stats x with (nolock) 
	join lnchat h with (nolock) on ( x.id_result=h.id_result and isnull(h.direction,0)=0 and isnull(h.wlt_enabled,0)=1 and h.delete_time is null )
	where x.id_result = @id_result
	and x.id_lnuser = @id_lnuser
	and x.id_message = @id_message
	order by h.create_time; -- replicate the first transfer messages created
	-- 
	update drl_minutely_stats set wlt_time = @dt, gct = @gct, gct_id_user = @gct_id_user where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;

	-- FLAG SNAPSHOT AS DONE
	-- snapshot_time
	update drl_minutely_stats set snapshot_time=getdate() where id_result = @id_result and id_lnuser=@id_lnuser and id_message=@id_message;		

END; -- PROC
' 
END
GO
/****** Object:  Trigger [tr_lnchat_before_update]    Script Date: 04/19/2022 15:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_lnchat_before_update]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[tr_lnchat_before_update] ON [dbo].[lnchat] FOR UPDATE
AS 
BEGIN
	--
	declare @n as integer;
	declare @rid uniqueidentifier;
	declare @uid uniqueidentifier;
	declare @mid uniqueidentifier;

	-- valido que solo se actualice un registro a la vez
	select @n=count(*) from inserted;
	if @n>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot update more than 1 record at once in the table lnchat.'', 16, 1)
	end

	-- 
	select @rid = h.id_result, @uid = h.id_lnuser, @mid = m0.id
	from inserted h
	join lnchat h0 ON (h.id_result=h0.id_result AND h.id_lnuser=h0.id_lnuser)
	join message m0 ON (m0.id=h0.id_message AND ISNULL(m0.trigger_type,0)=0);

	--
	exec updateDrlMinutelyStatsOnChatModification @rid, @uid, @mid;
END;
'
GO
/****** Object:  Trigger [tr_lnchat_before_insert]    Script Date: 04/19/2022 15:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_lnchat_before_insert]'))
EXEC dbo.sp_executesql @statement = N'    
CREATE TRIGGER [dbo].[tr_lnchat_before_insert] ON [dbo].[lnchat] FOR INSERT
AS 
BEGIN
	--
	declare @n as integer;
	declare @rid uniqueidentifier;
	declare @uid uniqueidentifier;
	declare @mid uniqueidentifier;

	-- valido que solo se inserte un registro a la vez
	select @n=count(*) from inserted;
	if @n>1
	begin
		ROLLBACK TRANSACTION
		raiserror(''Cannot insert more than 1 record at once in the table lnchat.'', 16, 1)
	end

	-- 
	select @n = count(*)
	from inserted h
	join lnchat h0 ON (h.id_result=h0.id_result AND h.id_lnuser=h0.id_lnuser)
	join message m0 ON (m0.id=h0.id_message AND ISNULL(m0.trigger_type,0)=0);
	
	if (@n > 0)
	begin
		select @rid = h.id_result, @uid = h.id_lnuser, @mid = m0.id
		from inserted h
		join lnchat h0 ON (h.id_result=h0.id_result AND h.id_lnuser=h0.id_lnuser)
		join message m0 ON (m0.id=h0.id_message AND ISNULL(m0.trigger_type,0)=0);
	end
	else
	begin
		select @rid = h.id_result, @uid = h.id_lnuser, @mid = h.id_message
		from inserted h
	end	

	--
	exec updateDrlMinutelyStatsOnChatModification @rid, @uid, @mid;
END;
'
GO
/****** Object:  Table [dbo].[stat_drl_shared_responses]    Script Date: 04/19/2022 15:21:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_responses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[stat_drl_shared_responses](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnchat] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__stat_drl__3213E83F715DD182] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[processDrlMinutelyStatsForCampaigns]    Script Date: 04/19/2022 15:22:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[processDrlMinutelyStatsForCampaigns]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[processDrlMinutelyStatsForCampaigns](@d DATETIME)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @r INT;
	DECLARE @rid UNIQUEIDENTIFIER;
	DECLARE @uid UNIQUEIDENTIFIER;
	DECLARE @mid UNIQUEIDENTIFIER;

	-- START PROCESSIGN
	PRINT ''Reprocessing snapshots... ''
	SET @r = 1;
	WHILE @r > 0
	BEGIN
		BEGIN TRANSACTION;
	   
		SELECT TOP 1 @rid=h.id_result, @uid=h.id_lnuser, @mid=h.id_message -- this will change
		--select count(*) -- -- 4645810
		--select top 10 x.*
		from lnchat h with (nolock) 
		join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=-2)
		where h.id_result not in (select id_result from drl_minutely_stats with (nolock));
		--where isnull(h.snapshot_time, ''1900-01-01'') < @d;

		SET @r = @@ROWCOUNT;

		exec dbo.[updateDrlMinutelyStatsOnChatModification] @rid, @uid, @mid;

		COMMIT TRANSACTION;
		-- CHECKPOINT; -- if simple
		-- BACKUP LOG ... -- if full
	END;

	SET NOCOUNT OFF;
END;

' 
END
GO
/****** Object:  Table [dbo].[on_wlt_from_message_action_instance]    Script Date: 04/19/2022 15:27:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[on_wlt_from_message_action_instance](
	[id] [uniqueidentifier] NOT NULL,
	[id_on_wlt_from_message_action] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_lnchat] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_search] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
 CONSTRAINT [PK__on_wlt_f__3213E83F75788387] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[on_message_action_instance]    Script Date: 04/19/2022 15:27:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[on_message_action_instance](
	[id] [uniqueidentifier] NOT NULL,
	[id_on_message_action] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[id_lnchat] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[id_emlist] [uniqueidentifier] NULL,
	[id_search] [uniqueidentifier] NULL,
	[id_crmlist] [uniqueidentifier] NULL,
 CONSTRAINT [PK__on_messa__3213E83F091738B6] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnchatopen]    Script Date: 04/19/2022 15:21:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnchatopen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnchatopen](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NULL,
	[id_lnchat] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__lnchatop__3213E83F34F8A5CA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnchatopen]') AND name = N'IX_lnchatopen__id_lnchat__id_user__create_time')
CREATE NONCLUSTERED INDEX [IX_lnchatopen__id_lnchat__id_user__create_time] ON [dbo].[lnchatopen] 
(
	[id_lnchat] ASC,
	[id_user] ASC,
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[automation_check_12]    Script Date: 04/19/2022 15:25:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_12]'))
EXEC dbo.sp_executesql @statement = N'-- select client_name, message_hours_ago, lead_name, lead_url, account_email, account_password from automation_check_11 order by account_email, create_time desc


/*
 * Recovery
 * Check12:�Recovered Messages Accuracy
 *
**/
create view [dbo].[automation_check_12]
as
select --top 100
        c.name as client_name, 
        datediff(mi, h.inmessage_end_time, getdate()) as message_minutes_ago, 
		h.inmessage_end_time,
        p.name as lead_name,
        ''https://linkedin.com/in''+p.code as lead_url,
        e.username as account_email,
        e.[password] as account_password,
        isnull(h.direction,0) as message_in, 
		h.body
from lnchat h with (nolock)
join lnuser e with (nolock) on e.id=h.id_lnuser
join result r with (nolock) on r.id=h.id_result
join search s with (nolock) on s.id=r.id_search
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=s.id_user
join client c with (nolock) on c.id=u.id_client
where exists (
	select *
	from lnchat i with (nolock)
	where i.id_result=h.id_result
	and i.id_lnuser=h.id_lnuser
	and i.inmessage_end_time is not null
	and i.inmessage_end_time > dateadd(hh, -3, getdate())
	and isnull(i.direction,0)=1
);
'
GO
/****** Object:  View [dbo].[automation_check_11]    Script Date: 04/19/2022 15:25:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_11]'))
EXEC dbo.sp_executesql @statement = N'-- select top 10 client_name, message_hours_ago, lead_name, lead_url, account_email, account_password from automation_check_09 order by create_time desc

/*
 * Messages
 * Check11: Missed Incomming Messages
 *
**/
create view [dbo].[automation_check_11]
as
select
        c.name as client_name, 
        datediff(hh, h.create_time, getdate()) as message_hours_ago, 
		h.create_time,
        p.name as lead_name,
        ''https://linkedin.com/in/''+p.code as lead_url,
        e.username as account_email,
        e.[password] as account_password,
        h.body
from lnchat h with (nolock)

join lnchat i with (nolock) on (i.id_result=h.id_result and i.id_lnuser=h.id_lnuser and isnull(i.direction,0)=0 and i.inmessage_end_time is not null)
join [message] m with (nolock) on (m.id=i.id_message and isnull(m.trigger_type,0)=0)

join lnuser e with (nolock) on e.id=h.id_lnuser
join result r with (nolock) on r.id=h.id_result
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=m.id_user
join client c with (nolock) on c.id=u.id_client
where h.inmessage_end_time is not null
and h.inmessage_end_time > dateadd(dd, -3, getdate())
and isnull(h.direction,0)=1;
'
GO
/****** Object:  View [dbo].[automation_check_09]    Script Date: 04/19/2022 15:25:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_09]'))
EXEC dbo.sp_executesql @statement = N'-- select top 10 client_name, message_hours_ago, lead_name, lead_url, account_email, account_password from automation_check_08 order by inmessage_end_time desc

/*
 * Messages
 * Check09: Messages False Negative
 *
**/
create view [dbo].[automation_check_09]
as
select
        c.name as client_name, 
        datediff(hh, h.create_time, getdate()) as hours_ago, 
		h.create_time,
        p.name as lead_name,
        ''https://linkedin.com/in/''+p.code as lead_url,
        e.username as account_email,
        e.[password] as account_password,
        h.body
from lnchat h with (nolock)
join lnuser e with (nolock) on e.id=h.id_lnuser
join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=1)
join result r with (nolock) on r.id=h.id_result
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=m.id_user
join client c with (nolock) on c.id=u.id_client
where h.inmessage_end_time is /*not*/ null
and isnull(h.inmessage_tries,0) >= 3
and isnull(h.direction,0)=0;
'
GO
/****** Object:  View [dbo].[automation_check_08_10]    Script Date: 04/19/2022 15:25:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_08_10]'))
EXEC dbo.sp_executesql @statement = N'-- select top 10 client_name, message_hours_ago, lead_name, lead_url, account_email, account_password from automation_check_07 order by account_email, inmessage_end_time desc

/*
 * Messages
 * Check08: Messages False Positive
 * Check10: Message Scripts Accuracy
 *
**/
create view [dbo].[automation_check_08_10]
as
select
        c.name as client_name, 
        datediff(hh, h.inmessage_end_time, getdate()) as message_hours_ago, 
		h.inmessage_end_time,
        p.name as lead_name,
        ''https://linkedin.com/in''+p.code as lead_url,
        e.username as account_email,
        e.[password] as account_password,
        h.body
from lnchat h with (nolock)
join lnuser e with (nolock) on e.id=h.id_lnuser
join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=1)
join result r with (nolock) on r.id=h.id_result
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=m.id_user
join client c with (nolock) on c.id=u.id_client
where h.inmessage_end_time is not null
and isnull(h.direction,0)=0;
'
GO
/****** Object:  View [dbo].[automation_check_07]    Script Date: 04/19/2022 15:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_07]'))
EXEC dbo.sp_executesql @statement = N'-- select top 10 client_name, message_hours_ago, lead_name, lead_url, account_email, account_password, body from automation_check_05 order by inmessage_end_time desc

/*
 * Invitations
 * Check07:�Missed New Connections
 *
**/
create view [dbo].[automation_check_07]
as
select
        c.name as client_name, 
        datediff(hh, h.create_time, getdate()) as message_hours_ago, 
		h.inmessage_end_time,
        p.name as lead_name,
        ''https://linkedin.com/in''+p.code as lead_url,
        e.username as account_email,
        e.[password] as account_password
from lnchat h with (nolock)
join lnuser e with (nolock) on e.id=h.id_lnuser
join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=0)
join result r with (nolock) on r.id=h.id_result
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=m.id_user
join client c with (nolock) on c.id=u.id_client
where h.inmessage_end_time is not null
and h.inmessage_end_time > dateadd(dd, -3, getdate())
and isnull(h.direction,0)=3;
'
GO
/****** Object:  View [dbo].[automation_check_05]    Script Date: 04/19/2022 15:25:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_05]'))
EXEC dbo.sp_executesql @statement = N'-- select top 25 client_name, message_hours_ago, lead_name, lead_url, account_email, account_password, body from automation_check_04_06 order by h.inmessage_end_time desc

/*
 * Invitations
 * Check05:�Invitations False Negatives
 *
**/
create view [dbo].[automation_check_05]
as
select
        c.name as client_name, 
        datediff(hh, h.create_time, getdate()) as message_hours_ago, 
		h.inmessage_end_time,
        p.name as lead_name,
        ''https://linkedin.com/in/''+p.code as lead_url,
        e.username as account_email,
        e.[password] as account_password,
        h.body
from lnchat h with (nolock)
join lnuser e with (nolock) on e.id=h.id_lnuser
join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=0)
join result r with (nolock) on r.id=h.id_result
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=m.id_user
join client c with (nolock) on c.id=u.id_client
where h.inmessage_end_time is /*not*/ null
and isnull(h.inmessage_tries,0) >= 3
and isnull(h.direction,0)=0;
'
GO
/****** Object:  View [dbo].[automation_check_04_06]    Script Date: 04/19/2022 15:26:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_04_06]'))
EXEC dbo.sp_executesql @statement = N'-- select top 1000 client_name, user_creator, search_name, search_url, scraped_hours_ago, lead_name, lead_url from automation_check_02 order by inmessage_end_time desc


/*
 * Invitations
 * Check04:�Invitations False Positives
 * Check06:�Invitation Scripts Accuracy
 *
**/
create view [dbo].[automation_check_04_06]
as
select top 10
	c.name as client_name, 
	datediff(hh, h.inmessage_end_time, getdate()) as message_hours_ago, 
	h.inmessage_end_time,
	p.name as lead_name,
	''https://linkedin.com/in''+p.code as lead_url,
	e.username as account_email,
	e.[password] as account_password,
	h.body
from lnchat h with (nolock)
join lnuser e with (nolock) on e.id=h.id_lnuser
join [message] m with (nolock) on (m.id=h.id_message and isnull(m.trigger_type,0)=0)
join result r with (nolock) on r.id=h.id_result
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=m.id_user
join client c with (nolock) on c.id=u.id_client
where h.inmessage_end_time is not null
and isnull(h.direction,0)=0;
'
GO
/****** Object:  View [dbo].[automation_check_02]    Script Date: 04/19/2022 15:26:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[automation_check_02]'))
EXEC dbo.sp_executesql @statement = N'-- select top 10 client_name, user_creator, create_time, search_name, scope, sns_url from automation_check_01 order by s.create_time desc


/*
 * Searches Scraping
 * Check02: Results Accuracy
 *
**/
create view [dbo].[automation_check_02]
as
select
	c.name as client_name, 
	u.email as user_creator, 
	s.name as search_name, 
	''https://connectionsphere.com/edb/search?sid=''+cast(s.id as varchar(500)) as search_url,
	datediff(hh, r.create_time, getdate()) as scraped_hours_ago,
	r.create_time as scraped_time, 
	h.inmessage_end_time, 
	p.name as lead_name,
	''https://linkedin.com/in/''+p.code as lead_url
from lnchat h with (nolock)
join result r with (nolock) on r.id=h.id_result
join search s with (nolock) on s.id=r.id_search
join [profile] p with (nolock) on p.id=r.id_profile
join [user] u with (nolock) on u.id=s.id_user
join client c with (nolock) on c.id=u.id_client
where h.inmessage_end_time is not null;
'
GO
/****** Object:  Table [dbo].[hourly]    Script Date: 04/19/2022 15:35:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hourly]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[hourly](
	[hour] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK__hourly__7F30AF4F10416098] PRIMARY KEY CLUSTERED 
(
	[hour] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [dbo].[hostNameFromUrl]    Script Date: 04/19/2022 15:35:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hostNameFromUrl]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[hostNameFromUrl]( @Url AS VARCHAR(500) )
RETURNS VARCHAR(500)
BEGIN
	RETURN
	SUBSTRING(@Url,
        /* Starting Position (After any ''//'') */
        (CASE WHEN CHARINDEX(''//'', @Url)= 0 THEN 1 ELSE CHARINDEX(''//'', @Url) + 2 END),
        /* Length (ending on first ''/'' or on a ''?'') */
        CASE
            WHEN CHARINDEX(''/'', @Url, CHARINDEX(''//'', @Url) + 2) > 0 THEN CHARINDEX(''/'', @Url, CHARINDEX(''//'', @Url) + 2) - (CASE WHEN CHARINDEX(''//'', @Url)= 0 THEN 1 ELSE CHARINDEX(''//'', @Url) + 2 END)
            WHEN CHARINDEX(''?'', @Url, CHARINDEX(''//'', @Url) + 2) > 0 THEN CHARINDEX(''?'', @Url, CHARINDEX(''//'', @Url) + 2) - (CASE WHEN CHARINDEX(''//'', @Url)= 0 THEN 1 ELSE CHARINDEX(''//'', @Url) + 2 END)
            ELSE LEN(@Url)
        END
    )
END' 
END
GO
/****** Object:  Table [dbo].[search_lncompanytype]    Script Date: 04/19/2022 15:35:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_lncompanytype]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_lncompanytype](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lncompanytype] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__search_l__3213E83F7AEAD939] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_search_lncompanytype] UNIQUE NONCLUSTERED 
(
	[id_search] ASC,
	[id_lncompanytype] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[search_lncompanysize]    Script Date: 04/19/2022 15:35:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_lncompanysize]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_lncompanysize](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lncompanysize] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__search_l__3213E83F743DDBAA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_search_lncompanysize] UNIQUE NONCLUSTERED 
(
	[id_search] ASC,
	[id_lncompanysize] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnDomainFromEmail]    Script Date: 04/19/2022 15:35:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnDomainFromEmail]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
create function [dbo].[fnDomainFromEmail](@email AS varchar(8000))
returns varchar(8000)
begin
	return SUBSTRING (@email, CHARINDEX( ''@'', @email) + 1, LEN(@email))
end;
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[lastNameFromFullName]    Script Date: 04/19/2022 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lastNameFromFullName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[lastNameFromFullName]( @full_name AS VARCHAR(500) )
RETURNS VARCHAR(500)
BEGIN
	RETURN REVERSE( LEFT( REVERSE(@full_name), CHARINDEX('' '', REVERSE(@full_name))-1 ) )
END ' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[ipv4blockc]    Script Date: 04/19/2022 15:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ipv4blockc]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[ipv4blockc](@ip as varchar(500))
returns varchar(500)
begin
	return left(@ip, len(@ip) - CHARINDEX(''.'', reverse(@ip), 1));
end -- function
' 
END
GO
/****** Object:  Table [dbo].[search_lnyearsincurrentposition]    Script Date: 04/19/2022 15:41:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_lnyearsincurrentposition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_lnyearsincurrentposition](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lnyearsincurrentposition] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__search_l__3213E83F0197D6C8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_search_lnyearsincurrentposition] UNIQUE NONCLUSTERED 
(
	[id_search] ASC,
	[id_lnyearsincurrentposition] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnsearchvariationblockparent]    Script Date: 04/19/2022 15:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblockparent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnsearchvariationblockparent](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_lnsearchvariationblock_parent] [uniqueidentifier] NOT NULL,
	[id_lnsearchvariationblock_child] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__lnsearch__3213E83F31D74509] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnsearchvariationblock_keyword]    Script Date: 04/19/2022 15:41:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock_keyword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnsearchvariationblock_keyword](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnsearchvariationblock] [uniqueidentifier] NOT NULL,
	[keyword] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[apply_to_whole_profile] [bit] NOT NULL,
	[apply_to_current_job_title] [bit] NOT NULL,
	[apply_to_past_job_title] [bit] NOT NULL,
	[is_negative] [bit] NOT NULL,
	[apply_to_current_company_name] [bit] NOT NULL,
	[apply_to_past_company_name] [bit] NOT NULL,
 CONSTRAINT [PK__lnsearch__3213E83F0844D457] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[name_keyword_blacklist]    Script Date: 04/19/2022 15:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[name_keyword_blacklist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[name_keyword_blacklist](
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__name_key__72E12F1A79289009] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[minutely]    Script Date: 04/19/2022 15:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[minutely]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[minutely](
	[minute] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK__minutely__7E7AEAFD1411F17C] PRIMARY KEY CLUSTERED 
(
	[minute] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnprofiles_to_discard]    Script Date: 04/19/2022 15:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnprofiles_to_discard]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnprofiles_to_discard](
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__lnprofil__3213E83F7CA47C3F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnindustry_naic]    Script Date: 04/19/2022 15:42:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnindustry_naic]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnindustry_naic](
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[stat_position_liprofile]    Script Date: 04/19/2022 15:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stat_position_liprofile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[stat_position_liprofile](
	[id] [uniqueidentifier] NOT NULL,
	[keyword] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_lnindustry] [uniqueidentifier] NOT NULL,
	[id_liprofile] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__stat_pos__3213E83F305E8732] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_position_liprofile]') AND name = N'IX_stat_position_liprofile__keyword__id_lnindustry__id_liprofile')
CREATE NONCLUSTERED INDEX [IX_stat_position_liprofile__keyword__id_lnindustry__id_liprofile] ON [dbo].[stat_position_liprofile] 
(
	[keyword] ASC,
	[id_lnindustry] ASC,
	[id_liprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_position_liprofile]') AND name = N'UK_stat_position_liprofile__keyword__id_liprofile')
CREATE UNIQUE NONCLUSTERED INDEX [UK_stat_position_liprofile__keyword__id_liprofile] ON [dbo].[stat_position_liprofile] 
(
	[keyword] ASC,
	[id_liprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[search_lnindustry]    Script Date: 04/19/2022 15:42:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_lnindustry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_lnindustry](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lnindustry] [uniqueidentifier] NOT NULL,
	[positive] [bit] NOT NULL,
 CONSTRAINT [PK__search_l__3213E83F66E3E08C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_search_lnindustry] UNIQUE NONCLUSTERED 
(
	[id_search] ASC,
	[id_lnindustry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnusertemplatejob]    Script Date: 04/19/2022 15:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnusertemplatejob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnusertemplatejob](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnusertemplate] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[title] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[company_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_lnindustry] [uniqueidentifier] NULL,
	[company_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[current] [bit] NOT NULL,
 CONSTRAINT [PK__lnuserte__3213E83F3E7F252E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lnuserjob]    Script Date: 04/19/2022 15:42:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnuserjob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnuserjob](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[title] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[company_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_lnindustry] [uniqueidentifier] NOT NULL,
	[company_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[current] [bit] NOT NULL,
 CONSTRAINT [PK__lnuserjo__3213E83F4AE4FC13] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnuserjob]') AND name = N'IX_lnuserjob__id_lnuser')
CREATE NONCLUSTERED INDEX [IX_lnuserjob__id_lnuser] ON [dbo].[lnuserjob] 
(
	[id_lnuser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fakeReservationId]    Script Date: 04/19/2022 15:36:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fakeReservationId]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[fakeReservationId]()
RETURNS UNIQUEIDENTIFIER
AS BEGIN
    RETURN CAST(''cd297219-19dc-4d8b-8ca6-53431bcdd229'' AS UNIQUEIDENTIFIER)
END' 
END
GO
/****** Object:  Table [dbo].[event]    Script Date: 04/19/2022 15:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[event]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[event](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[update_time] [datetime] NOT NULL,
	[url] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[event_time] [datetime] NOT NULL,
	[short_description] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[large_description] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NULL,
	[atendees] [bigint] NOT NULL,
 CONSTRAINT [PK__event__3213E83F3DF26C8F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[event_speaker]    Script Date: 04/19/2022 15:36:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[event_speaker]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[event_speaker](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[id_event] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__event_sp__3213E83F45938E57] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[event_attendee]    Script Date: 04/19/2022 15:36:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[event_attendee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[event_attendee](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[id_event] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__event_at__3213E83F4B4C67AD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[fl_company]    Script Date: 04/19/2022 15:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_company]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_company](
	[ID] [int] NOT NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__fl_compa__3214EC27208798C9] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[firstNameFromFullName]    Script Date: 04/19/2022 15:37:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[firstNameFromFullName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[firstNameFromFullName]( @full_name AS VARCHAR(500) )
RETURNS VARCHAR(500)
BEGIN
	RETURN SUBSTRING(@full_name, 1, CHARINDEX('' '', @full_name, 1) - 1)
END ' 
END
GO
/****** Object:  Table [dbo].[firstname]    Script Date: 04/19/2022 15:37:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[firstname]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[firstname](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[relevance] [numeric](18, 0) NOT NULL,
	[country_code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[gender] [numeric](1, 0) NULL,
 CONSTRAINT [PK_firstname] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[firstname]') AND name = N'IX_firstname__relevance')
CREATE NONCLUSTERED INDEX [IX_firstname__relevance] ON [dbo].[firstname] 
(
	[relevance] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[firstname]') AND name = N'IX_firstname__relevance_desc')
CREATE NONCLUSTERED INDEX [IX_firstname__relevance_desc] ON [dbo].[firstname] 
(
	[relevance] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[buffer_incrawl_event_result]    Script Date: 04/19/2022 15:37:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_event_result]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[buffer_incrawl_event_result](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[url] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[event_time] [datetime] NOT NULL,
	[short_description] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[large_description] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NULL,
	[atendees] [bigint] NOT NULL,
 CONSTRAINT [PK__buffer_i__3213E83F41C2FD73] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[lock_browserfactory]    Script Date: 04/19/2022 15:41:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lock_browserfactory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[lock_browserfactory] 
@peer_id uniqueidentifier,
@host_name varchar(500)
AS 

	BEGIN TRANSACTION;

	SELECT [reservation_id] AS bid 
	FROM browserfactory WITH (XLOCK) 
	WHERE [host_name]=@host_name
	AND ( reservation_id IS NULL OR DATEDIFF(mi, ISNULL(reservation_time, ''1900-01-01 00:00:00''), GETDATE())>5 ) ;

	UPDATE browserfactory SET 
	reservation_id=@peer_id,
	reservation_time=GETDATE() 
	WHERE [host_name]=@host_name
	AND EXISTS (
		SELECT [reservation_id] AS bid 
		FROM browserfactory WITH (XLOCK) 
		WHERE [host_name]=@host_name
		AND ( reservation_id IS NULL OR DATEDIFF(mi, ISNULL(reservation_time, ''1900-01-01 00:00:00''), GETDATE())>5 )
	)

	COMMIT TRANSACTION;' 
END
GO
/****** Object:  Table [dbo].[drl_performance_swap]    Script Date: 04/19/2022 15:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[drl_performance_swap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[drl_performance_swap](
	[id_client] [uniqueidentifier] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
	[id_message_1] [uniqueidentifier] NULL,
	[id_message_2] [uniqueidentifier] NULL,
	[industry] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[invitations] [bigint] NOT NULL,
	[invitation_hits] [bigint] NOT NULL,
	[messages1] [bigint] NOT NULL,
	[messages2] [bigint] NOT NULL,
	[replies] [bigint] NOT NULL,
	[wlts] [bigint] NOT NULL,
	[visits] [bigint] NOT NULL,
	[clicks] [bigint] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[drl_performance_stats]    Script Date: 04/19/2022 15:37:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[drl_performance_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[drl_performance_stats](
	[id_client] [uniqueidentifier] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_message] [uniqueidentifier] NOT NULL,
	[id_message_1] [uniqueidentifier] NULL,
	[id_message_2] [uniqueidentifier] NULL,
	[industry] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[invitations] [bigint] NOT NULL,
	[invitation_hits] [bigint] NOT NULL,
	[messages1] [bigint] NOT NULL,
	[messages2] [bigint] NOT NULL,
	[replies] [bigint] NOT NULL,
	[wlts] [bigint] NOT NULL,
	[visits] [bigint] NOT NULL,
	[clicks] [bigint] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[company_domain_pattern_blacklist]    Script Date: 04/19/2022 15:37:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[company_domain_pattern_blacklist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[company_domain_pattern_blacklist](
	[domain_pattern] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__company___C02D714424A71F94] PRIMARY KEY CLUSTERED 
(
	[domain_pattern] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[em_buffer_link]    Script Date: 04/19/2022 15:37:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[em_buffer_link]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[em_buffer_link](
	[id] [uniqueidentifier] NOT NULL,
	[url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__em_buffe__3213E83F542C7691] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fl_location]    Script Date: 04/19/2022 15:36:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_location]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_location](
	[ID] [int] NOT NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__fl_locat__3214EC27020311A9] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fl_search_location]    Script Date: 04/19/2022 15:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_search_location]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_search_location](
	[ID] [int] NOT NULL,
	[id_location] [int] NULL,
	[id_search] [int] NULL,
	[positive] [bit] NULL,
 CONSTRAINT [PK__fl_searc__3214EC270B8C7BE3] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[fl_industry]    Script Date: 04/19/2022 15:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_industry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_industry](
	[ID] [int] NOT NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__fl_indus__3214EC277E3280C5] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fl_search_industry]    Script Date: 04/19/2022 15:36:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_search_industry]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_search_industry](
	[ID] [int] NOT NULL,
	[id_industry] [int] NULL,
	[id_search] [int] NULL,
	[positive] [bit] NULL,
 CONSTRAINT [PK__fl_searc__3214EC2705D3A28D] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[fld_name_stats]    Script Date: 04/19/2022 15:36:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fld_name_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fld_name_stats](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[industry] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[searchable] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__fld_name__3213E83F17BD489E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_fld_name_stats__id] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fnTimeAgoDescription]    Script Date: 04/19/2022 15:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnTimeAgoDescription]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[fnTimeAgoDescription](@from datetime, @to datetime)
returns varchar(500)
as
begin
declare @years int;
declare @months int;
declare @days int;
declare @hours int;
declare @minutes int;
declare @seconds int;
declare @s varchar(500);

set @years = datediff(yy,@from,@to);
set @months = datediff(mm,@from,@to);
set @days = datediff(dd,@from,@to);
set @hours = datediff(hh,@from,@to);
set @minutes = datediff(mi,@from,@to);
set @seconds = datediff(ss,@from,@to);

set @s = ''ago'';
if (@seconds<0) 
begin
	set @s = ''from now'';
end

set @years = abs(@years);
set @months = abs(@months);
set @days = abs(@days);
set @hours = abs(@hours);
set @minutes = abs(@minutes);
set @seconds = abs(@seconds);

if (@months>=12) return cast(@years as varchar(500))+'' years ''+@s;
--if (@days>30) return cast(@months as varchar(500))+'' months ''+@s;
if (@hours>24) return cast(@days as varchar(500))+'' days ''+@s;
if (@minutes>60) return cast(@hours as varchar(500))+'' hours ''+@s;
if (@seconds>60) return cast(@minutes as varchar(500))+'' minutes ''+@s;
return cast(@seconds as varchar(500))+'' seconds ''+@s;
end;' 
END
GO
/****** Object:  View [dbo].[v_searches]    Script Date: 04/19/2022 15:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_searches]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_searches]
as
select 
	u.id_client, s.id as id_search, s.name, s.create_time, dbo.fnTimeAgoDescription(s.create_time, getdate()) as create_time_ago_description, s.delete_time, 
	isnull(s.stat_linkedinscope,0) as stat_linkedinscope, isnull(s.stat_linkedinresults,0) as stat_linkedinresults, ISNULL(s.stat_ssm_pending_results,0) as stat_ssm_pending_results
-- , s.stat_results as scraped_results, s.stat_linkedinresults as linkedin_results, s.stat_ssm_pending_results as ssm_pending_results
from search s
join [user] u on u.id=s.id_user;'
GO
/****** Object:  View [dbo].[v_messages]    Script Date: 04/19/2022 15:36:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_messages]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_messages] 
AS
SELECT u.id AS id_user, u.id_client AS id_client, m.id AS mid, m.name AS mname, m.create_time AS create_time, m.delete_time AS delete_time, dbo.fnTimeAgoDescription(m.create_time, getdate()) as timeago, m.trigger_type AS trigger_type, ISNULL(m.status,0) AS status, g.id AS gid, g.name AS gname, p.name AS pname, p.id AS pid
FROM [user] u WITH (NOLOCK) 
JOIN [message] m WITH (NOLOCK) ON u.id=m.id_user 
LEFT JOIN pipeline p WITH (NOLOCK) ON p.id=m.id_pipeline 
LEFT JOIN lngroup g WITH (NOLOCK) ON g.id=m.id_lngroup;
'
GO
/****** Object:  Table [dbo].[guid_aux]    Script Date: 04/19/2022 15:36:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[guid_aux]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[guid_aux](
	[id] [uniqueidentifier] NOT NULL,
	[id2] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__guid_aux__3213E83F1D88A94B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [dbo].[getPatternPositions]    Script Date: 04/19/2022 15:36:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getPatternPositions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'Create FUNCTION [dbo].[getPatternPositions] 
(
@txt varchar(max),
@Pat varchar(max)
)
RETURNS 
@tab TABLE 
(
 ID int
)
AS
BEGIN
	Declare @pos int
	Declare @oldpos int
	Select @oldpos=0
	select @pos=patindex(@pat,@txt) 
	while @pos > 0 and @oldpos<>@pos
	 begin
	   insert into @tab Values (@pos)
	   Select @oldpos=@pos
	   select @pos=patindex(@pat,Substring(@txt,@pos + 1,len(@txt))) + @pos
	end

	RETURN 
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[getDomainFromEmail]    Script Date: 04/19/2022 15:36:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getDomainFromEmail]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[getDomainFromEmail](@email varchar(500))
returns varchar(500)
as
begin
	return RIGHT(@email, LEN(@email) - CHARINDEX(''@'', @email))
end' 
END
GO
/****** Object:  Table [dbo].[em_buffer_unsubscribe]    Script Date: 04/19/2022 15:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[em_buffer_unsubscribe]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[em_buffer_unsubscribe](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_emlist] [uniqueidentifier] NOT NULL,
	[email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[sync_start_time] [datetime] NULL,
	[sync_end_time] [datetime] NULL,
	[sync_id_division] [uniqueidentifier] NULL,
	[sync_times] [numeric](18, 0) NULL,
	[did] [uniqueidentifier] NULL,
 CONSTRAINT [PK__em_buffe__3213E83F4119A21D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[big_company_name]    Script Date: 04/19/2022 15:38:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[big_company_name]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[big_company_name](
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__big_comp__72E12F1A2877B078] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_x]    Script Date: 04/19/2022 15:38:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_x]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_x](
	[x] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_usernames]    Script Date: 04/19/2022 15:38:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_usernames]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_usernames](
	[username] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__aux_user__F3DBC57335B8FB51] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_title]    Script Date: 04/19/2022 15:38:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_title]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_title](
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_proxies_2]    Script Date: 04/19/2022 15:38:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_proxies_2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_proxies_2](
	[ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_proxies]    Script Date: 04/19/2022 15:38:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_proxies]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_proxies](
	[ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[port] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_profile_id]    Script Date: 04/19/2022 15:38:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_profile_id]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_profile_id](
	[id] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[aux_names]    Script Date: 04/19/2022 15:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_names]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_names](
	[fname] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[lname] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_message_id]    Script Date: 04/19/2022 15:38:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_message_id]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_message_id](
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__aux_mess__3213E83F41961ED7] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[aux_id]    Script Date: 04/19/2022 15:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_id]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_id](
	[id] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[aux_firstname]    Script Date: 04/19/2022 15:38:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_firstname]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_firstname](
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_domain]    Script Date: 04/19/2022 15:38:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_domain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_domain](
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_creators]    Script Date: 04/19/2022 15:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_creators]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_creators](
	[ip] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[s] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_companies]    Script Date: 04/19/2022 15:39:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_companies]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_companies](
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aux_bhw_free_leads]    Script Date: 04/19/2022 15:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aux_bhw_free_leads]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aux_bhw_free_leads](
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[industry] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[location] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[company] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[headline] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[url] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[email] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[appendc6]    Script Date: 04/19/2022 15:39:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[appendc6]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[appendc6](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnprofile] [uniqueidentifier] NOT NULL,
	[type] [int] NOT NULL,
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NULL,
 CONSTRAINT [PK__appendc6__3213E83F251C81ED] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[appendc6]') AND name = N'appendc6__id_lnprofile')
CREATE NONCLUSTERED INDEX [appendc6__id_lnprofile] ON [dbo].[appendc6] 
(
	[id_lnprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[append1_source_domain_pattern_blacklist]    Script Date: 04/19/2022 15:39:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[append1_source_domain_pattern_blacklist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[append1_source_domain_pattern_blacklist](
	[domain] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__append1___723FC1F77A5CAB64] PRIMARY KEY CLUSTERED 
(
	[domain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[drl_connection_stats]    Script Date: 04/19/2022 15:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[drl_connection_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[drl_connection_stats](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[industry] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[searchable] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NULL,
	[last_chat_create_time] [datetime] NOT NULL,
 CONSTRAINT [PK__drl_conn__3213E83F6E069E31] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_drl_connection_stats__id] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_drl_connection_stats__id_lnuser__id_profile] UNIQUE NONCLUSTERED 
(
	[id_lnuser] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_connection_stats]') AND name = N'IX_drl_connection_stats__last_chat_create_time')
CREATE NONCLUSTERED INDEX [IX_drl_connection_stats__last_chat_create_time] ON [dbo].[drl_connection_stats] 
(
	[last_chat_create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[drl_available_for_campaign_stats]    Script Date: 04/19/2022 15:39:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[drl_available_for_campaign_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[drl_available_for_campaign_stats](
	[id_client] [uniqueidentifier] NOT NULL,
	[id_pipeline] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lnuser] [uniqueidentifier] NOT NULL,
	[id_result] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[industry] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[searchable] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NULL,
	[last_chat_create_time] [datetime] NOT NULL,
 CONSTRAINT [UK_drl_available_for_campaign_stats__id_result] UNIQUE NONCLUSTERED 
(
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[drl_available_for_campaign_stats]') AND name = N'IX_drl_available_for_campaign_stats__last_chat_create_time')
CREATE NONCLUSTERED INDEX [IX_drl_available_for_campaign_stats__last_chat_create_time] ON [dbo].[drl_available_for_campaign_stats] 
(
	[last_chat_create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[domainNameFromUrl]    Script Date: 04/19/2022 15:39:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[domainNameFromUrl]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[domainNameFromUrl]( @Url AS VARCHAR(500) )
RETURNS VARCHAR(500)
BEGIN
	RETURN replace(dbo.domainNameFromUrl(@Url), ''www.'', '''')
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[domainFromUrl]    Script Date: 04/19/2022 15:39:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[domainFromUrl]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[domainFromUrl](@WebUrl VARCHAR(500))
RETURNS VARCHAR(500)
AS
begin
--DECLARE @WebUrl VARCHAR(35);
--SET @WebUrl = ''http://stackoverflow.com/questions/ask.asp?title=trim''

RETURN (SELECT
       LEFT(SUBSTRING(@WebUrl, 
       (CASE WHEN CHARINDEX(''//'',@WebUrl)=0 
            THEN 5 
            ELSE  CHARINDEX(''//'',@WebUrl) + 2
            END), 35),
       (CASE 
       WHEN CHARINDEX(''/'', SUBSTRING(@WebUrl, CHARINDEX(''//'', @WebUrl) + 2, 35))=0 
       THEN LEN(@WebUrl) 
       else CHARINDEX(''/'', SUBSTRING(@WebUrl, CHARINDEX(''//'', @WebUrl) + 2, 35))- 1
       END)
       ))
end;
' 
END
GO
/****** Object:  Table [dbo].[sis_page]    Script Date: 04/19/2022 15:39:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sis_page]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sis_page](
	[id] [uniqueidentifier] NOT NULL,
	[id_parent] [uniqueidentifier] NOT NULL,
	[url] [varchar](900) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[create_time] [datetime] NOT NULL,
	[id_domain] [uniqueidentifier] NULL,
	[type] [int] NULL,
 CONSTRAINT [PK__sis_link__3213E83F3FAB3E67] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_sis_linkedin_company__url] UNIQUE NONCLUSTERED 
(
	[url] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lnindustryconversion]    Script Date: 04/19/2022 15:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnindustryconversion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnindustryconversion](
	[id] [uniqueidentifier] NOT NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[text] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[id_lnindustry] [uniqueidentifier] NULL,
	[revision_time] [datetime] NULL,
	[revision_id_user] [uniqueidentifier] NULL,
 CONSTRAINT [PK__lnindust__3213E83F37C341F4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_lnindustryconversion__id_domain__text] UNIQUE NONCLUSTERED 
(
	[id_domain] ASC,
	[text] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[buffer_incrawl_lnsearchvariation_result]    Script Date: 04/19/2022 15:40:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[buffer_incrawl_lnsearchvariation_result](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[page] [numeric](18, 0) NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[headline] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[title] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[abstract] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[industry] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[create_time] [datetime] NULL,
	[stat_done] [bit] NULL,
	[copy_reservation_id] [uniqueidentifier] NULL,
	[copy_reservation_time] [datetime] NULL,
	[copy_reservation_times] [numeric](18, 0) NULL,
	[copy_start_time] [datetime] NULL,
	[copy_end_time] [datetime] NULL,
	[id_lnsearchvariationblock] [uniqueidentifier] NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[premium] [int] NULL,
	[open_profile] [int] NULL,
	[post_url] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[post_time] [datetime] NULL,
	[post_html_content] [nvarchar](max) COLLATE Traditional_Spanish_CI_AS NULL,
	[post_reacts] [bigint] NULL,
	[post_comments] [bigint] NULL,
	[id_event_speaker] [uniqueidentifier] NULL,
	[id_event_attendee] [uniqueidentifier] NULL,
 CONSTRAINT [PK__buffer_i__3213E83F1DF06171] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]') AND name = N'IX_buffer_incrawl_lnsearchvariation_result__2')
CREATE NONCLUSTERED INDEX [IX_buffer_incrawl_lnsearchvariation_result__2] ON [dbo].[buffer_incrawl_lnsearchvariation_result] 
(
	[copy_reservation_id] ASC,
	[copy_start_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]') AND name = N'IX_buffer_incrawl_lnsearchvariation_result__copy_end_time__copy_reservation_time')
CREATE NONCLUSTERED INDEX [IX_buffer_incrawl_lnsearchvariation_result__copy_end_time__copy_reservation_time] ON [dbo].[buffer_incrawl_lnsearchvariation_result] 
(
	[copy_end_time] ASC,
	[copy_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]') AND name = N'IX_buffer_incrawl_lnsearchvariation_result__copy_reservation_id__copy_end_time__copy_reservation_times')
CREATE NONCLUSTERED INDEX [IX_buffer_incrawl_lnsearchvariation_result__copy_reservation_id__copy_end_time__copy_reservation_times] ON [dbo].[buffer_incrawl_lnsearchvariation_result] 
(
	[copy_reservation_id] ASC,
	[copy_end_time] ASC,
	[copy_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]') AND name = N'IX_buffer_incrawl_lnsearchvariation_result__copy_reservation_id__copy_start_time')
CREATE NONCLUSTERED INDEX [IX_buffer_incrawl_lnsearchvariation_result__copy_reservation_id__copy_start_time] ON [dbo].[buffer_incrawl_lnsearchvariation_result] 
(
	[copy_reservation_id] ASC,
	[copy_start_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]') AND name = N'IX_buffer_incrawl_lnsearchvariation_result__stat_done__copy_reservation_id')
CREATE NONCLUSTERED INDEX [IX_buffer_incrawl_lnsearchvariation_result__stat_done__copy_reservation_id] ON [dbo].[buffer_incrawl_lnsearchvariation_result] 
(
	[stat_done] ASC,
	[copy_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_division]    Script Date: 04/19/2022 15:41:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[user_division]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[user_division](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_division] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__user_div__3213E83F1CFA3D1F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[tmp_results]    Script Date: 04/19/2022 15:43:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_results]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_results](
	[rid] [uniqueidentifier] NULL,
	[create_time] [datetime] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tmp_results]') AND name = N'IX_tmp_resuts__create_time')
CREATE NONCLUSTERED INDEX [IX_tmp_resuts__create_time] ON [dbo].[tmp_results] 
(
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_mla_profiles]    Script Date: 04/19/2022 15:43:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_mla_profiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_mla_profiles](
	[uuid] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_active_clients]    Script Date: 04/19/2022 15:43:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_active_clients]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_active_clients](
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__tmp_acti__3213E83F0C2B9A61] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[timeoffset]    Script Date: 04/19/2022 15:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[timeoffset]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[timeoffset](
	[id] [uniqueidentifier] NOT NULL,
	[region] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[utc] [numeric](2, 0) NOT NULL,
	[dst] [numeric](2, 0) NULL,
 CONSTRAINT [PK__timeoffs__3213E83F3E3F6D37] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sample_summary]    Script Date: 04/19/2022 15:42:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sample_summary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sample_summary](
	[summary] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[removeNotPrintableChars]    Script Date: 04/19/2022 15:45:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[removeNotPrintableChars]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[removeNotPrintableChars](@S varchar(max))
Returns varchar(max)
Begin
    ;with  cte1(N) As (Select 1 From (Values(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) N(N)),
           cte2(C) As (Select Top (32) Char(Row_Number() over (Order By (Select NULL))-1) From cte1 a,cte1 b)
    Select @S = Replace(@S,C,'' '')
     From  cte2

    Return ltrim(rtrim(replace(replace(replace(@S,'' '',''��''),''��'',''''),''��'','' '')))
End
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[removeNonPrintableChars]    Script Date: 04/19/2022 15:45:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[removeNonPrintableChars]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[removeNonPrintableChars](@S varchar(max))
Returns varchar(max)
Begin
    ;with  cte1(N) As (Select 1 From (Values(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) N(N)),
           cte2(C) As (Select Top (32) Char(Row_Number() over (Order By (Select NULL))-1) From cte1 a,cte1 b)
    Select @S = Replace(@S,C,'' '')
     From  cte2

    Return ltrim(rtrim(replace(replace(replace(@S,'' '',''��''),''��'',''''),''��'','' '')))
End
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[RemoveNonAlphaCharacters]    Script Date: 04/19/2022 15:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RemoveNonAlphaCharacters]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'Create Function [dbo].[RemoveNonAlphaCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = ''%[^a-z]%''
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '''')

    Return @Temp
End
' 
END
GO
/****** Object:  Table [dbo].[zipcode]    Script Date: 04/19/2022 15:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zipcode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[zipcode](
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [UQ__zipcode__40BBEA3A216325D7] UNIQUE NONCLUSTERED 
(
	[value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lnprofile]    Script Date: 04/19/2022 15:47:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnprofile](
	[id] [uniqueidentifier] NOT NULL,
	[url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[code] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[name] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[picture] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[headline] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_lnindustry] [uniqueidentifier] NULL,
	[id_lnlocation] [uniqueidentifier] NULL,
	[crawl_start_time] [datetime] NULL,
	[crawl_end_time] [datetime] NULL,
	[crawl_result] [numeric](18, 0) NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[location] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[industry] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[appendc6_reservation_id] [uniqueidentifier] NULL,
	[appendc6_start_time] [datetime] NULL,
	[appendc6_end_time] [datetime] NULL,
	[create_time] [datetime] NULL,
	[local_picture] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[append2_reservation_id] [uniqueidentifier] NULL,
	[append2_start_time] [datetime] NULL,
	[append2_end_time] [datetime] NULL,
	[append3_reservation_id] [uniqueidentifier] NULL,
	[append3_start_time] [datetime] NULL,
	[append3_end_time] [datetime] NULL,
	[crawl_reservation_time] [datetime] NULL,
	[appendc6_reservation_time] [datetime] NULL,
	[append2_reservation_time] [datetime] NULL,
	[crawl_reservation_times] [numeric](18, 0) NULL,
	[appendc6_reservation_times] [numeric](18, 0) NULL,
	[append2_reservation_times] [numeric](18, 0) NULL,
	[normalized_url] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[available_for_demo] [bit] NULL,
	[selected_by_demo] [bit] NULL,
	[id_lnprofiledirectoryentry] [uniqueidentifier] NULL,
	[html] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[crawl_not_found] [bit] NULL,
	[advice_to_contact] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[id_person] [uniqueidentifier] NULL,
 CONSTRAINT [PK_lnprofile] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_lnprofile__url] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_liprofile__id_person')
CREATE NONCLUSTERED INDEX [IX_liprofile__id_person] ON [dbo].[lnprofile] 
(
	[id_person] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__append2_reservation_id__append2_end_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__append2_reservation_id__append2_end_time] ON [dbo].[lnprofile] 
(
	[append2_reservation_id] ASC,
	[append2_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__append2_reservation_id__append2_end_time__append2_reservation_time__append2_reservation_times')
CREATE NONCLUSTERED INDEX [IX_lnprofile__append2_reservation_id__append2_end_time__append2_reservation_time__append2_reservation_times] ON [dbo].[lnprofile] 
(
	[append2_reservation_id] ASC,
	[append2_end_time] ASC,
	[append2_reservation_time] ASC,
	[append2_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'ix_lnprofile__append2_reservation_id__append2_reservation_time__append2_reservation_times')
CREATE NONCLUSTERED INDEX [ix_lnprofile__append2_reservation_id__append2_reservation_time__append2_reservation_times] ON [dbo].[lnprofile] 
(
	[append2_reservation_id] ASC,
	[append2_reservation_time] ASC,
	[append2_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__append2_reservation_id__append2_start_time__append2_reservation_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__append2_reservation_id__append2_start_time__append2_reservation_time] ON [dbo].[lnprofile] 
(
	[append2_reservation_id] ASC,
	[append2_start_time] ASC,
	[append2_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__append2_reservation_id__crawl_end_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__append2_reservation_id__crawl_end_time] ON [dbo].[lnprofile] 
(
	[append2_reservation_id] ASC,
	[crawl_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__append2_reservation_id__crawl_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_lnprofile__append2_reservation_id__crawl_reservation_id__id] ON [dbo].[lnprofile] 
(
	[append2_reservation_id] ASC,
	[crawl_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__appendc6_reservation_id__appendc6_end_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__appendc6_reservation_id__appendc6_end_time] ON [dbo].[lnprofile] 
(
	[appendc6_reservation_id] ASC,
	[appendc6_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__appendc6_reservation_id__appendc6_end_time__appendc6_reservation_time__appendc6_reservation_times')
CREATE NONCLUSTERED INDEX [IX_lnprofile__appendc6_reservation_id__appendc6_end_time__appendc6_reservation_time__appendc6_reservation_times] ON [dbo].[lnprofile] 
(
	[appendc6_reservation_id] ASC,
	[appendc6_end_time] ASC,
	[appendc6_reservation_time] ASC,
	[appendc6_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'ix_lnprofile__appendc6_reservation_id__appendc6_reservation_time__appendc6_reservation_times')
CREATE NONCLUSTERED INDEX [ix_lnprofile__appendc6_reservation_id__appendc6_reservation_time__appendc6_reservation_times] ON [dbo].[lnprofile] 
(
	[appendc6_reservation_id] ASC,
	[appendc6_reservation_time] ASC,
	[appendc6_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__appendc6_reservation_id__appendc6_start_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__appendc6_reservation_id__appendc6_start_time] ON [dbo].[lnprofile] 
(
	[appendc6_reservation_id] ASC,
	[appendc6_start_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__appendc6_reservation_id__code')
CREATE NONCLUSTERED INDEX [IX_lnprofile__appendc6_reservation_id__code] ON [dbo].[lnprofile] 
(
	[appendc6_reservation_id] ASC,
	[code] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__appendc6_reservation_id__crawl_end_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__appendc6_reservation_id__crawl_end_time] ON [dbo].[lnprofile] 
(
	[appendc6_reservation_id] ASC,
	[crawl_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__appendc6_reservation_id__crawl_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_lnprofile__appendc6_reservation_id__crawl_reservation_id__id] ON [dbo].[lnprofile] 
(
	[appendc6_reservation_id] ASC,
	[crawl_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__available_for_demo')
CREATE NONCLUSTERED INDEX [IX_lnprofile__available_for_demo] ON [dbo].[lnprofile] 
(
	[available_for_demo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__code__id')
CREATE NONCLUSTERED INDEX [IX_lnprofile__code__id] ON [dbo].[lnprofile] 
(
	[code] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__crawl_end_time_desc')
CREATE NONCLUSTERED INDEX [IX_lnprofile__crawl_end_time_desc] ON [dbo].[lnprofile] 
(
	[crawl_end_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__crawl_reservation_id')
CREATE NONCLUSTERED INDEX [IX_lnprofile__crawl_reservation_id] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__crawl_reservation_id__crawl_end_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__crawl_reservation_id__crawl_end_time] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC,
	[crawl_end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__crawl_reservation_id__crawl_end_time__crawl_reservation_time__crawl_reservation_times')
CREATE NONCLUSTERED INDEX [IX_lnprofile__crawl_reservation_id__crawl_end_time__crawl_reservation_time__crawl_reservation_times] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC,
	[crawl_end_time] ASC,
	[crawl_reservation_time] ASC,
	[crawl_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'ix_lnprofile__crawl_reservation_id__crawl_reservation_time__crawl_reservation_times')
CREATE NONCLUSTERED INDEX [ix_lnprofile__crawl_reservation_id__crawl_reservation_time__crawl_reservation_times] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC,
	[crawl_reservation_time] ASC,
	[crawl_reservation_times] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__crawl_reservation_id__crawl_start_time__crawl_reservation_time')
CREATE NONCLUSTERED INDEX [IX_lnprofile__crawl_reservation_id__crawl_start_time__crawl_reservation_time] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC,
	[crawl_start_time] ASC,
	[crawl_reservation_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__crawl_reservation_id__id')
CREATE NONCLUSTERED INDEX [IX_lnprofile__crawl_reservation_id__id] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__id__append2_reservation_id__code')
CREATE NONCLUSTERED INDEX [IX_lnprofile__id__append2_reservation_id__code] ON [dbo].[lnprofile] 
(
	[id] ASC,
	[append2_reservation_id] ASC,
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__id_person')
CREATE NONCLUSTERED INDEX [IX_lnprofile__id_person] ON [dbo].[lnprofile] 
(
	[id_person] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_LNPROFILE__LOCAL_PICTURE__NAME__ID_LNLOCATION__ID_LNINDUSTRY')
CREATE NONCLUSTERED INDEX [IX_LNPROFILE__LOCAL_PICTURE__NAME__ID_LNLOCATION__ID_LNINDUSTRY] ON [dbo].[lnprofile] 
(
	[local_picture] ASC,
	[name] ASC,
	[id_lnlocation] ASC,
	[id_lnindustry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'IX_lnprofile__normalized_url')
CREATE NONCLUSTERED INDEX [IX_lnprofile__normalized_url] ON [dbo].[lnprofile] 
(
	[normalized_url] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'lnprofile__crawl_reservation_id__create_time')
CREATE NONCLUSTERED INDEX [lnprofile__crawl_reservation_id__create_time] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC,
	[create_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'lnprofile__crawl_reservation_id__id')
CREATE NONCLUSTERED INDEX [lnprofile__crawl_reservation_id__id] ON [dbo].[lnprofile] 
(
	[crawl_reservation_id] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'lnprofile__create_time')
CREATE NONCLUSTERED INDEX [lnprofile__create_time] ON [dbo].[lnprofile] 
(
	[create_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofile]') AND name = N'lnprofile__picture__local_picture')
CREATE NONCLUSTERED INDEX [lnprofile__picture__local_picture] ON [dbo].[lnprofile] 
(
	[picture] ASC,
	[local_picture] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnprofile', N'COLUMN',N'code'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key value by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnprofile', @level2type=N'COLUMN',@level2name=N'code'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnprofile', N'COLUMN',N'picture'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'URL of the profile picture.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnprofile', @level2type=N'COLUMN',@level2name=N'picture'
GO
/****** Object:  Table [dbo].[lnsearchresult]    Script Date: 04/19/2022 15:48:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnsearchresult](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnsearch] [uniqueidentifier] NOT NULL,
	[id_lnsearchvariation] [uniqueidentifier] NULL,
	[id_lnsearchvariationjob] [uniqueidentifier] NULL,
	[number] [numeric](18, 0) NULL,
	[create_time] [datetime] NOT NULL,
	[id_lnprofile] [uniqueidentifier] NOT NULL,
	[reservation_id] [uniqueidentifier] NULL,
	[allocation_time] [datetime] NULL,
	[allocation_price] [numeric](18, 4) NULL,
	[allocation_result] [int] NULL,
	[allocation_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[delivery_reservation_id] [uniqueidentifier] NULL,
	[delivery_start_time] [datetime] NULL,
	[delivery_end_time] [datetime] NULL,
	[delivery_price] [numeric](18, 4) NULL,
	[delivery_id_campaign] [uniqueidentifier] NULL,
	[delivery_status] [numeric](18, 0) NULL,
	[delivery_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[pre_allocation_result] [numeric](18, 0) NULL,
	[pre_allocation_time] [datetime] NULL,
	[pre_allocation_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[allocation_export_to_em_description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[search_links_reservation_id] [uniqueidentifier] NULL,
	[search_links_reservation_time] [datetime] NULL,
	[search_links_reservation_times] [numeric](18, 0) NULL,
	[search_links_start_time] [datetime] NULL,
	[search_links_end_time] [datetime] NULL,
	[id_lnsearchresult] [uniqueidentifier] NULL,
	[sync_snapshot_reservation_id] [uniqueidentifier] NULL,
	[sync_snapshot_reservation_time] [datetime] NULL,
	[sync_snapshot_reservation_times] [numeric](18, 0) NULL,
	[sync_snapshot_start_time] [datetime] NULL,
	[sync_snapshot_end_time] [datetime] NULL,
	[id_lisearchresult] [uniqueidentifier] NULL,
	[append1_allocation_result] [numeric](18, 0) NULL,
	[append1_allocation_time] [datetime] NULL,
	[append1_allocation_export_to_em_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[append2_allocation_result] [numeric](18, 0) NULL,
	[append2_allocation_time] [datetime] NULL,
	[append2_allocation_export_to_em_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[append4_allocation_result] [numeric](18, 0) NULL,
	[append4_allocation_time] [datetime] NULL,
	[append4_allocation_export_to_em_description] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_lnresult] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND name = N'IX_lnsearchresult__id_lnsearch')
CREATE NONCLUSTERED INDEX [IX_lnsearchresult__id_lnsearch] ON [dbo].[lnsearchresult] 
(
	[id_lnsearch] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND name = N'IX_lnsearchresult__id_lnsearch__allocation_time__allocation_result')
CREATE NONCLUSTERED INDEX [IX_lnsearchresult__id_lnsearch__allocation_time__allocation_result] ON [dbo].[lnsearchresult] 
(
	[id_lnsearch] ASC,
	[allocation_time] ASC,
	[allocation_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND name = N'IX_lnsearchresult__id_lnsearch__pre_allocation_result__allocation_result__id_lnprofile')
CREATE NONCLUSTERED INDEX [IX_lnsearchresult__id_lnsearch__pre_allocation_result__allocation_result__id_lnprofile] ON [dbo].[lnsearchresult] 
(
	[id_lnsearch] ASC,
	[pre_allocation_result] ASC,
	[allocation_result] ASC,
	[id_lnprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND name = N'IX_lnsearchresult__id_lnsearch__pre_allocation_result__id_lnprofile')
CREATE NONCLUSTERED INDEX [IX_lnsearchresult__id_lnsearch__pre_allocation_result__id_lnprofile] ON [dbo].[lnsearchresult] 
(
	[id_lnsearch] ASC,
	[pre_allocation_result] ASC,
	[id_lnprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND name = N'IX_lnsearchresult__id_lnsearch_id_lnprofile')
CREATE NONCLUSTERED INDEX [IX_lnsearchresult__id_lnsearch_id_lnprofile] ON [dbo].[lnsearchresult] 
(
	[id_lnsearch] ASC,
	[id_lnprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND name = N'IX_lnsearchresult__pre_allocation_result__allocation_result__id_lnprofile')
CREATE NONCLUSTERED INDEX [IX_lnsearchresult__pre_allocation_result__allocation_result__id_lnprofile] ON [dbo].[lnsearchresult] 
(
	[pre_allocation_result] ASC,
	[allocation_result] ASC,
	[id_lnprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchresult]') AND name = N'IX_lnsearchresult__pre_allocation_result__id_lnprofile')
CREATE NONCLUSTERED INDEX [IX_lnsearchresult__pre_allocation_result__id_lnprofile] ON [dbo].[lnsearchresult] 
(
	[pre_allocation_result] ASC,
	[id_lnprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [TR_LNSEARCHRESULT_AFTER_INSERT]    Script Date: 04/19/2022 15:50:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TR_LNSEARCHRESULT_AFTER_INSERT]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [dbo].[TR_LNSEARCHRESULT_AFTER_INSERT]
ON  [dbo].[lnsearchresult]
FOR INSERT
AS 
BEGIN
	DECLARE @oneid UNIQUEIDENTIFIER
	DECLARE the_cursor CURSOR FAST_FORWARD
	FOR SELECT i.id FROM inserted i WITH (NOLOCK)
	OPEN the_cursor
	FETCH NEXT FROM the_cursor INTO @oneid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC dbo.syncInsertLnSearchResult @oneid
		FETCH NEXT FROM the_cursor INTO @oneid
	END
	CLOSE the_cursor
	DEALLOCATE the_cursor
END
'
GO
/****** Object:  Table [dbo].[stat_search_result]    Script Date: 04/19/2022 15:43:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stat_search_result]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[stat_search_result](
	[id_search] [uniqueidentifier] NULL,
	[id_result] [uniqueidentifier] NOT NULL,
	[id_profile] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[headline] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[title] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[location] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[industry] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_phone_appended] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_address_appended] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_email_appended] [varchar](1) COLLATE Traditional_Spanish_CI_AS NULL,
	[companysize] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[companysize_standard] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[location_standard] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[industry_standard] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[last_flood_time] [datetime] NULL,
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__stat_sea__98AF497D29601404] PRIMARY KEY CLUSTERED 
(
	[id_profile] ASC,
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_stat_search_result] UNIQUE NONCLUSTERED 
(
	[id_search] ASC,
	[id_result] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_stat_search_result_2] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_search_result]') AND name = N'IX_stat_lnsearch_result__id_liprofile')
CREATE NONCLUSTERED INDEX [IX_stat_lnsearch_result__id_liprofile] ON [dbo].[stat_search_result] 
(
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_search_result]') AND name = N'IX_stat_lnsearch_result__id_lisearchresult')
CREATE NONCLUSTERED INDEX [IX_stat_lnsearch_result__id_lisearchresult] ON [dbo].[stat_search_result] 
(
	[id_result] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_search_result]') AND name = N'IX_stat_lnsearch_result__id_lnsearch__id_liprofile')
CREATE NONCLUSTERED INDEX [IX_stat_lnsearch_result__id_lnsearch__id_liprofile] ON [dbo].[stat_search_result] 
(
	[id_search] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_search_result]') AND name = N'IX_stat_search_result__id_search__id_profile')
CREATE NONCLUSTERED INDEX [IX_stat_search_result__id_search__id_profile] ON [dbo].[stat_search_result] 
(
	[id_search] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_search_result]') AND name = N'IX_stat_search_result__id_search__stat_email_appended__id_profile')
CREATE NONCLUSTERED INDEX [IX_stat_search_result__id_search__stat_email_appended__id_profile] ON [dbo].[stat_search_result] 
(
	[id_search] ASC,
	[stat_email_appended] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[stat_search_result]') AND name = N'IX_stat_search_result__id_search__stat_phone_appended__id_profile')
CREATE NONCLUSTERED INDEX [IX_stat_search_result__id_search__stat_phone_appended__id_profile] ON [dbo].[stat_search_result] 
(
	[id_search] ASC,
	[stat_phone_appended] ASC,
	[id_profile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [TR_LNSEARCHRESULT_AFTER_UPDATE]    Script Date: 04/19/2022 15:50:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TR_LNSEARCHRESULT_AFTER_UPDATE]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[TR_LNSEARCHRESULT_AFTER_UPDATE]
ON  [dbo].[lnsearchresult]
FOR UPDATE
AS 
BEGIN
	UPDATE stat_lnsearch SET
		lnsearchresult_id_lnsearchresult		= r.id_lnsearchresult,
		lnsearchresult_id_lisearchresult 		= r.id_lisearchresult,
		lnsearchresult_pre_allocation_result		= r.pre_allocation_result,
		lnsearchresult_allocation_result		= r.allocation_result,

		lnsearchresult_pre_allocation_description	= r.pre_allocation_description,
		lnsearchresult_allocation_description		= cast(r.allocation_description as varchar(500))

	FROM stat_lnsearch h
	JOIN lnsearchresult r ON r.id=h.id_lnsearchresult
	WHERE h.id_lnsearchresult IN (select id from inserted);
END
'
GO
/****** Object:  Table [dbo].[stat_lnchat_profile_names]    Script Date: 04/19/2022 15:43:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stat_lnchat_profile_names]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[stat_lnchat_profile_names](
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK_stat_lnchat_profile_names] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[spRemoveNonAlphaCharacters]    Script Date: 04/19/2022 15:43:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRemoveNonAlphaCharacters]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'Create Function [dbo].[spRemoveNonAlphaCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin
    Declare @KeepValues as varchar(50)
    Set @KeepValues = ''%[^a-z0-9]%''
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '''')

    Return @Temp
End
' 
END
GO
/****** Object:  Table [dbo].[temporal_names_for_update_search_stat_fields]    Script Date: 04/19/2022 15:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temporal_names_for_update_search_stat_fields]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[temporal_names_for_update_search_stat_fields](
	[value] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[temporal_names_for_update_search_stat_fields]') AND name = N'IX_temporal_names_for_update_search_stat_fields__value')
CREATE NONCLUSTERED INDEX [IX_temporal_names_for_update_search_stat_fields__value] ON [dbo].[temporal_names_for_update_search_stat_fields] 
(
	[value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temporal_firstname]    Script Date: 04/19/2022 15:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temporal_firstname]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[temporal_firstname](
	[id] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[temporal_firstname]') AND name = N'IX_temporal_firstname__id')
CREATE NONCLUSTERED INDEX [IX_temporal_firstname__id] ON [dbo].[temporal_firstname] 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_profile]    Script Date: 04/19/2022 15:44:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temp_profile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[temp_profile](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime2](3) NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[headline] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_company_from_headline] [uniqueidentifier] NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[crawl_reservation_time] [datetime2](3) NULL,
	[crawl_reservation_times] [decimal](18, 0) NULL,
	[crawl_start_time] [datetime2](3) NULL,
	[crawl_end_time] [datetime2](3) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[temp_company]    Script Date: 04/19/2022 15:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temp_company]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[temp_company](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[website] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[employees] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[revenue] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[crawl_reservation_time] [datetime2](3) NULL,
	[crawl_reservation_times] [decimal](18, 0) NULL,
	[crawl_start_time] [datetime2](3) NULL,
	[crawl_end_time] [datetime2](3) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[temp_buffer_paypal_notification_2]    Script Date: 04/19/2022 15:44:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temp_buffer_paypal_notification_2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[temp_buffer_paypal_notification_2](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[txn_type] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subscr_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_name] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[residence_country] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mc_currency] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_name] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[amount1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[business] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[amount3] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[recurring] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[verify_sign] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payer_status] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[test_ipn] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payer_email] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[first_name] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[receiver_email] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payer_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoice] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[reattempt] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_number] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subscr_date] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[charset] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[notify_version] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[period1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mc_amount1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[period3] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mc_amount3] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ipn_track_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[transaction_subject] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_date] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_gross] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_type] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[txn_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[receiver_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_status] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_fee] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sync_reservation_id] [uniqueidentifier] NULL,
	[sync_reservation_time] [datetime] NULL,
	[sync_reservation_times] [numeric](18, 0) NULL,
	[sync_start_time] [datetime] NULL,
	[sync_end_time] [datetime] NULL,
	[sync_result] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[temp_buffer_paypal_notification]    Script Date: 04/19/2022 15:45:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temp_buffer_paypal_notification]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[temp_buffer_paypal_notification](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[txn_type] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subscr_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_name] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[residence_country] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mc_currency] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_name] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[amount1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[business] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[amount3] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[recurring] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[verify_sign] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payer_status] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[test_ipn] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payer_email] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[first_name] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[receiver_email] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payer_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoice] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[reattempt] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_number] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subscr_date] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[charset] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[notify_version] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[period1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mc_amount1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[period3] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mc_amount3] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ipn_track_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[transaction_subject] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_date] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_gross] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_type] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[txn_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[receiver_id] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_status] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[payment_fee] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sync_reservation_id] [uniqueidentifier] NULL,
	[sync_reservation_time] [datetime] NULL,
	[sync_reservation_times] [numeric](18, 0) NULL,
	[sync_start_time] [datetime] NULL,
	[sync_end_time] [datetime] NULL,
	[sync_result] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sample]    Script Date: 04/19/2022 15:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sample]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sample](
	[id] [uniqueidentifier] NOT NULL,
	[jobtitles] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_lncountry] [uniqueidentifier] NULL,
	[id_lnlocation] [uniqueidentifier] NULL,
	[id_lnindustry] [uniqueidentifier] NULL,
	[id_lnprofile] [uniqueidentifier] NULL,
	[create_time] [datetime] NOT NULL,
	[id_user] [uniqueidentifier] NULL,
 CONSTRAINT [PK__sample__3213E83F66EA454A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[role]    Script Date: 04/19/2022 15:45:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[role]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[role](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__role__3213E83F4668671F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_role__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 04/19/2022 15:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[user_role]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[user_role](
	[id] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_role] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__user_rol__3213E83F4A38F803] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_user_role__id_user__id_role] UNIQUE NONCLUSTERED 
(
	[id_user] ASC,
	[id_role] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[v_pva_available_accounts]    Script Date: 04/19/2022 15:45:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_pva_available_accounts]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[v_pva_available_accounts]
AS
SELECT u.id, u.username, u.status, u.STAT_PURCHASE_PRICE, datediff(mi, u.status_time, getdate()) as last_check_minutes_ago, datediff(mi, u.edit_profile_end_time, getdate()) AS birth_minutes_ago, ISNULL(stat_network_connections,0) AS connections 
FROM lnuser u WITH (NOLOCK) 
JOIN [user] e WITH (NOLOCK) ON e.id=u.id_user

-- Debe pertenecer a un administrador de division
JOIN user_role er WITH (NOLOCK) ON e.id=er.id_user
JOIN role r WITH (NOLOCK) ON (r.id=er.id_role and r.name=''prisma.user'')

WHERE u.delete_time IS NULL -- No debe haber sido eliminado
AND u.id_client_allocated IS NULL -- No debe estar rentado
AND ISNULL(u.disabled_for_heijunka, 0) = 0 -- Debe estar habilitado para heijunka
AND u.signup_end_time IS NOT NULL -- Debe tener signup hecho
AND u.confirm_email_end_time IS NOT NULL -- Debe tener email confirmado
AND u.edit_profile_end_time IS NOT NULL -- Debe tener perfil editado
AND u.stat_purchase_price IS NOT NULL -- QUE TENGA UN PRECIO DEFINIDO
AND u.stat_network_connections IS NOT NULL -- QUE TENGA DEFINIDO EL # DE CONTACTOS
'
GO
/****** Object:  StoredProcedure [dbo].[buy_lnuser]    Script Date: 04/19/2022 15:45:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[buy_lnuser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--
-- 
CREATE PROCEDURE [dbo].[buy_lnuser] @id_lnuser UNIQUEIDENTIFIER, @id_user UNIQUEIDENTIFIER
AS
DECLARE @id UNIQUEIDENTIFIER;
BEGIN TRAN;  
	SELECT @id = u.id 
	FROM lnuser u WITH (XLOCK) 
	JOIN [user] e WITH (XLOCK) ON e.id=u.id_user
	-- Debe pertenecer a un administrador de division
	JOIN user_role er WITH (XLOCK) ON e.id=er.id_user
	JOIN role r WITH (XLOCK) ON (r.id=er.id_role and r.name=''prisma.user'')
	WHERE u.[id]=@id_lnuser 
	AND u.delete_time IS NULL -- No debe haber sido eliminado
	AND u.id_client_allocated IS NULL -- No debe estar rentado
	AND u.disabled_for_heijunka IS NULL -- Debe estar habilitado para heijunka
	AND u.signup_end_time IS NOT NULL -- Debe tener signup hecho
	AND u.confirm_email_end_time IS NOT NULL -- Debe tener email confirmado
	AND u.edit_profile_end_time IS NOT NULL -- Debe tener perfil editado
	AND u.stat_purchase_price IS NOT NULL -- QUE TENGA UN PRECIO DEFINIDO
	AND u.stat_network_connections IS NOT NULL -- QUE TENGA DEFINIDO EL # DE CONTACTOS
	
	-- 
	IF ( @id IS NOT NULL )
	BEGIN
		-- lo asigno al nuevo duenio.
		-- le quito el proxy --> Se eliminara el perfil de MLA.
		-- lo deshabilito para ser vendido.
		UPDATE lnuser SET 
			id_user = @id_user, 
			id_proxy = NULL, 
			disabled_for_heijunka=1 
		WHERE 
			[id]=@id_lnuser;

		-- lo quito de cualquier pipelines que este asignado
		DELETE pipeline_lnuser WHERE id_lnuser=@id_lnuser;

		-- tambien asigno la cuenta forward al nuevo duenio
		UPDATE forward_email SET id_user = @id_user WHERE [id] IN (
			SELECT e.id
			FROM forward_email e
			JOIN forward_domain d ON d.id=e.id_forward_domain
			WHERE UPPER(e.address COLLATE Modern_Spanish_CI_AS + ''@'' + d.name COLLATE Modern_Spanish_CI_AS) = (SELECT UPPER(username COLLATE Modern_Spanish_CI_AS) FROM lnuser WHERE [id]=@id_lnuser)
		);
	END
COMMIT TRAN;' 
END
GO
/****** Object:  Table [dbo].[params]    Script Date: 04/19/2022 15:46:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[params]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[params](
	[id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[type] [int] NOT NULL,
	[description] [text] COLLATE Traditional_Spanish_CI_AS NULL,
	[value_varchar] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[value_numeric] [numeric](18, 0) NULL,
	[value_datetime] [datetime] NULL,
	[value_bit] [bit] NULL,
 CONSTRAINT [PK__params__3213E83F37FA4C37] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_params__name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sample_headline]    Script Date: 04/19/2022 15:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sample_headline]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sample_headline](
	[headline] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[spExtractDomainFromURL]    Script Date: 04/19/2022 15:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spExtractDomainFromURL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[spExtractDomainFromURL] ( @strURL NVARCHAR(1000) )
RETURNS NVARCHAR(100)
AS
BEGIN
    --Strip Protocol
    SELECT  @strURL = SUBSTRING(@strURL, CHARINDEX(''://'', @strURL) + 3, 999)

    -- Strip www subdomain
    IF LEFT(@strURL, 4) = ''www.''
        SELECT  @strURL = SUBSTRING(@strURL, 5, 999)

    -- Strip Path
    IF CHARINDEX(''/'', @strURL) > 0
        SELECT  @strURL = LEFT(@strURL, CHARINDEX(''/'', @strURL) - 1)

    RETURN @strURL
END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[spExtractDomainFromEmail]    Script Date: 04/19/2022 15:46:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spExtractDomainFromEmail]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'Create Function [dbo].[spExtractDomainFromEmail](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin
    Return RIGHT(@Temp, LEN(@Temp) - CHARINDEX(''@'', @Temp))
End
' 
END
GO
/****** Object:  Table [dbo].[sitemap]    Script Date: 04/19/2022 15:46:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sitemap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sitemap](
	[id] [uniqueidentifier] NOT NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[crawl_denied] [bit] NOT NULL,
	[loc] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[lastmod] [datetime] NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[crawl_reservation_time] [datetime] NULL,
	[crawl_reservation_times] [numeric](18, 0) NULL,
	[crawl_start_time] [datetime] NULL,
	[crawl_end_time] [datetime] NULL,
 CONSTRAINT [PK__sitemap__3213E83F4922D820] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_sitemap__id_domain__loc] UNIQUE NONCLUSTERED 
(
	[id_domain] ASC,
	[loc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sitemap]') AND name = N'IX_sitemap__crawl_reservation_id__crawl_denied__id_domain')
CREATE NONCLUSTERED INDEX [IX_sitemap__crawl_reservation_id__crawl_denied__id_domain] ON [dbo].[sitemap] 
(
	[crawl_reservation_id] ASC,
	[crawl_denied] ASC,
	[id_domain] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[companysize]    Script Date: 04/19/2022 15:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[companysize]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[companysize](
	[id] [uniqueidentifier] NOT NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[min] [numeric](18, 0) NOT NULL,
	[max] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK__companys__3213E83F193EBAD4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_companysize__id_domain__name] UNIQUE NONCLUSTERED 
(
	[id_domain] ASC,
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[em_buffer_open]    Script Date: 04/19/2022 15:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[em_buffer_open]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[em_buffer_open](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[did] [uniqueidentifier] NOT NULL,
	[id_division] [uniqueidentifier] NULL,
 CONSTRAINT [PK__em_buffe__3213E83F770B9E7A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [dbo].[getCompanyNameFromHeadline]    Script Date: 04/19/2022 15:49:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getCompanyNameFromHeadline]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[getCompanyNameFromHeadline](@txt varchar(max))
RETURNS varchar(max) 
AS
BEGIN
	DECLARE @ret VARCHAR(8000);
	
	SET @ret = right(@txt, len(@txt)-(select top 1 id from dbo.getPatternPositions(@txt, ''% at %''))-3);
	
	IF @ret IS NULL
	BEGIN
		SET @ret = right(@txt, len(@txt)-(select top 1 id from dbo.getPatternPositions(@txt, ''%,%''))-1);
	END
	
	RETURN @ret;
END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnAliasFromEmail]    Script Date: 04/19/2022 15:49:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnAliasFromEmail]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[fnAliasFromEmail](@email AS varchar(8000))
returns varchar(8000)
begin
	return REPLACE(@email, ''@''+dbo.fnDomainFromEmail(@email), '''')
end;
' 
END
GO
/****** Object:  Table [dbo].[fl_lead]    Script Date: 04/19/2022 15:50:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_lead]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_lead](
	[ID] [int] NOT NULL,
	[position] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_company] [int] NULL,
	[id_industry] [int] NULL,
	[id_location] [int] NULL,
	[stat_has_email] [bit] NULL,
	[stat_has_phone] [bit] NULL,
	[stat_company_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_industry_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
	[stat_location_name] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK__fl_lead__3214EC27245829AD] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[fl_export_lead]    Script Date: 04/19/2022 15:50:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_export_lead]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_export_lead](
	[ID] [int] NOT NULL,
	[id_export] [int] NULL,
	[id_lead] [int] NULL,
 CONSTRAINT [PK__fl_expor__3214EC272B05273C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[em_buffer_click]    Script Date: 04/19/2022 15:49:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[em_buffer_click]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[em_buffer_click](
	[id] [uniqueidentifier] NOT NULL,
	[id_em_buffer_link] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[bid] [uniqueidentifier] NOT NULL,
	[sync_start_time] [datetime] NULL,
	[sync_end_time] [datetime] NULL,
	[sync_id_division] [uniqueidentifier] NULL,
	[sync_times] [numeric](18, 0) NULL,
	[did] [uniqueidentifier] NULL,
	[id_division] [uniqueidentifier] NULL,
 CONSTRAINT [PK__em_buffe__3213E83F57FD0775] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[em_buffer_click]') AND name = N'IX_em_buffer_click__create_time__id_division')
CREATE NONCLUSTERED INDEX [IX_em_buffer_click__create_time__id_division] ON [dbo].[em_buffer_click] 
(
	[create_time] ASC,
	[id_division] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[em_buffer_bounce]    Script Date: 04/19/2022 15:49:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[em_buffer_bounce]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[em_buffer_bounce](
	[id] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[diagnosis] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[status] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[did] [uniqueidentifier] NULL,
	[id_division] [uniqueidentifier] NULL,
	[bounce_time] [datetime] NULL,
	[message_id] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[email] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[soft] [bit] NULL,
 CONSTRAINT [PK__em_buffe__3213E83F75E27017] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[em_buffer_bounce]') AND name = N'IX_em_buffer_bounce__create_time__id_division')
CREATE NONCLUSTERED INDEX [IX_em_buffer_bounce__create_time__id_division] ON [dbo].[em_buffer_bounce] 
(
	[create_time] ASC,
	[id_division] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[peopledirectory]    Script Date: 04/19/2022 15:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[peopledirectory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[peopledirectory](
	[id] [uniqueidentifier] NOT NULL,
	[id_domain] [uniqueidentifier] NOT NULL,
	[create_time] [datetime] NOT NULL,
	[delete_time] [datetime] NULL,
	[crawl_denied] [bit] NOT NULL,
	[code] [varchar](500) COLLATE Traditional_Spanish_CI_AS NOT NULL,
	[crawl_reservation_id] [uniqueidentifier] NULL,
	[crawl_reservation_time] [datetime] NULL,
	[crawl_reservation_times] [numeric](18, 0) NULL,
	[crawl_start_time] [datetime] NULL,
	[crawl_end_time] [datetime] NULL,
 CONSTRAINT [PK__peopledi__3213E83F4EDBB176] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_peopledirectory__id_domain__code] UNIQUE NONCLUSTERED 
(
	[id_domain] ASC,
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_temporal_greg]    Script Date: 04/19/2022 15:48:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[lnprofilejob]    Script Date: 04/19/2022 15:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnprofilejob]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnprofilejob](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnprofile] [uniqueidentifier] NOT NULL,
	[code] [nvarchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
	[headline] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[company] [varchar](5000) COLLATE Traditional_Spanish_CI_AS NULL,
	[id_lncompany] [uniqueidentifier] NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[append1_start_time] [datetime] NULL,
	[append1_end_time] [datetime] NULL,
	[append1_reservation_id] [uniqueidentifier] NULL,
	[append1_reservation_time] [datetime] NULL,
	[append1_reservation_times] [numeric](18, 0) NULL,
	[append4_start_time] [datetime] NULL,
	[append4_end_time] [datetime] NULL,
	[append4_reservation_id] [uniqueidentifier] NULL,
	[append4_reservation_time] [datetime] NULL,
	[append4_reservation_times] [numeric](18, 0) NULL,
	[sync_snapshot_reservation_id] [uniqueidentifier] NULL,
	[sync_snapshot_reservation_time] [datetime] NULL,
	[sync_snapshot_reservation_times] [numeric](18, 0) NULL,
	[sync_snapshot_start_time] [datetime] NULL,
	[sync_snapshot_end_time] [datetime] NULL,
	[append5_reservation_id] [uniqueidentifier] NULL,
	[append5_reservation_time] [datetime] NULL,
	[append5_reservation_times] [numeric](18, 0) NULL,
	[append5_start_time] [datetime] NULL,
	[append5_end_time] [datetime] NULL,
	[append1_bot_class_name] [varchar](500) COLLATE Traditional_Spanish_CI_AS NULL,
 CONSTRAINT [PK_lnprofilejob] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofilejob]') AND name = N'IX_lnprofilejob__end_date__id_lnprofile')
CREATE NONCLUSTERED INDEX [IX_lnprofilejob__end_date__id_lnprofile] ON [dbo].[lnprofilejob] 
(
	[end_date] ASC,
	[id_lnprofile] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofilejob]') AND name = N'IX_lnprofilejob__id_lnprofile__append4_reservation_id__end_date')
CREATE NONCLUSTERED INDEX [IX_lnprofilejob__id_lnprofile__append4_reservation_id__end_date] ON [dbo].[lnprofilejob] 
(
	[id_lnprofile] ASC,
	[append4_reservation_id] ASC,
	[end_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofilejob]') AND name = N'IX_lnprofilejob__id_lnprofile__end_date')
CREATE NONCLUSTERED INDEX [IX_lnprofilejob__id_lnprofile__end_date] ON [dbo].[lnprofilejob] 
(
	[id_lnprofile] ASC,
	[end_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofilejob]') AND name = N'IX_lnprofilejob__id_lnprofile__id')
CREATE NONCLUSTERED INDEX [IX_lnprofilejob__id_lnprofile__id] ON [dbo].[lnprofilejob] 
(
	[id_lnprofile] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnprofilejob]') AND name = N'IX_profilejob__code')
CREATE NONCLUSTERED INDEX [IX_profilejob__code] ON [dbo].[lnprofilejob] 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnprofilejob', N'COLUMN',N'code'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key value by LinkedIn.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnprofilejob', @level2type=N'COLUMN',@level2name=N'code'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'lnprofilejob', N'COLUMN',N'id_lncompany'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LinkedIn company page.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'lnprofilejob', @level2type=N'COLUMN',@level2name=N'id_lncompany'
GO
/****** Object:  StoredProcedure [dbo].[syncUpdateLnSearchResultAppendStats]    Script Date: 04/19/2022 15:48:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[syncUpdateLnSearchResultAppendStats]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[syncUpdateLnSearchResultAppendStats] @rid UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS (
		SELECT *
		FROM lnsearchresult r
		JOIN lnprofile p ON p.id=r.id_lnprofile
		JOIN lnprofilejob j ON p.id=j.id_lnprofile
		JOIN append1 a ON j.id=a.id_lnprofilejob
		WHERE r.id=@rid
	)
	UPDATE stat_lnsearch 
	SET stat_append1_hit=1 
	WHERE id_lnsearchresult=@rid
	AND id_lnprofilejob IN (
		SELECT j.id
		FROM lnsearchresult r
		JOIN lnprofile p ON p.id=r.id_lnprofile
		JOIN lnprofilejob j ON p.id=j.id_lnprofile
		JOIN append1 a ON j.id=a.id_lnprofilejob
		WHERE r.id=@rid
	);

	IF EXISTS (
		SELECT *
		FROM lnsearchresult r
		JOIN lnprofile p ON p.id=r.id_lnprofile
		JOIN append2 a ON p.id=a.id_lnprofile
		WHERE r.id=@rid
	)
	UPDATE stat_lnsearch SET stat_append2_hit=1 WHERE id_lnsearchresult=@rid;

	IF EXISTS (
		SELECT *
		FROM lnsearchresult r
		JOIN lnprofile p ON p.id=r.id_lnprofile
		JOIN lnprofilejob j ON p.id=j.id_lnprofile
		JOIN append4 a ON j.id=a.id_lnprofilejob
		WHERE r.id=@rid
	)
	UPDATE stat_lnsearch 
	SET stat_append4_hit=1 
	WHERE id_lnsearchresult=@rid
	AND id_lnprofilejob IN (
		SELECT j.id
		FROM lnsearchresult r
		JOIN lnprofile p ON p.id=r.id_lnprofile
		JOIN lnprofilejob j ON p.id=j.id_lnprofile
		JOIN append4 a ON j.id=a.id_lnprofilejob
		WHERE r.id=@rid
	);
END -- 
' 
END
GO
/****** Object:  Table [dbo].[search_lnlocation]    Script Date: 04/19/2022 15:48:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[search_lnlocation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[search_lnlocation](
	[id] [uniqueidentifier] NOT NULL,
	[id_search] [uniqueidentifier] NOT NULL,
	[id_lnlocation] [uniqueidentifier] NOT NULL,
	[positive] [bit] NOT NULL,
 CONSTRAINT [PK__search_l__3213E83F6D90DE1B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_search_lnlocation] UNIQUE NONCLUSTERED 
(
	[id_search] ASC,
	[id_lnlocation] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[lnsearchvariationblock_firstname]    Script Date: 04/19/2022 15:49:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock_firstname]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[lnsearchvariationblock_firstname](
	[id] [uniqueidentifier] NOT NULL,
	[id_lnsearchvariationblock] [uniqueidentifier] NOT NULL,
	[id_firstname] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__lnsearch__3213E83F28570FA1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock_firstname]') AND name = N'IX_lnsearchvariationblock_firstname__id_lnsearchvariationblock')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock_firstname__id_lnsearchvariationblock] ON [dbo].[lnsearchvariationblock_firstname] 
(
	[id_lnsearchvariationblock] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock_firstname]') AND name = N'IX_lnsearchvariationblock_firstname__id_lnsearchvariationblock__id_firstname')
CREATE NONCLUSTERED INDEX [IX_lnsearchvariationblock_firstname__id_lnsearchvariationblock__id_firstname] ON [dbo].[lnsearchvariationblock_firstname] 
(
	[id_lnsearchvariationblock] ASC,
	[id_firstname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ipv4blockb]    Script Date: 04/19/2022 15:50:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ipv4blockb]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[ipv4blockb](@ip as varchar(500))
returns varchar(500)
begin	
	return dbo.ipv4blockc(dbo.ipv4blockc(@ip));
end -- function
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[ipv4blocka]    Script Date: 04/19/2022 15:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ipv4blocka]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[ipv4blocka](@ip as varchar(500))
returns varchar(500)
begin	
	return dbo.ipv4blockc(dbo.ipv4blockb(@ip));
end -- function
' 
END
GO
/****** Object:  Table [dbo].[fl_data]    Script Date: 04/19/2022 15:50:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fl_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[fl_data](
	[ID] [int] NOT NULL,
	[id_lead] [int] NULL,
	[type] [int] NOT NULL,
	[value] [varchar](8000) COLLATE Traditional_Spanish_CI_AS NOT NULL,
 CONSTRAINT [PK__fl_data__3214EC2730BE0092] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK__user__id_search__04556E6F]    Script Date: 04/19/2022 15:06:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user__id_search__04556E6F]') AND parent_object_id = OBJECT_ID(N'[dbo].[user]'))
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK__user__id_search__04556E6F] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user__id_search__04556E6F]') AND parent_object_id = OBJECT_ID(N'[dbo].[user]'))
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK__user__id_search__04556E6F]
GO
/****** Object:  ForeignKey [FK_user_client]    Script Date: 04/19/2022 15:06:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_user_client]') AND parent_object_id = OBJECT_ID(N'[dbo].[user]'))
ALTER TABLE [dbo].[user]  WITH NOCHECK ADD  CONSTRAINT [FK_user_client] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_user_client]') AND parent_object_id = OBJECT_ID(N'[dbo].[user]'))
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_client]
GO
/****** Object:  ForeignKey [FK__user_feed__id_us__473911B0]    Script Date: 04/19/2022 15:06:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_feed__id_us__473911B0]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_feedback]'))
ALTER TABLE [dbo].[user_feedback]  WITH CHECK ADD  CONSTRAINT [FK__user_feed__id_us__473911B0] FOREIGN KEY([id_user_from])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_feed__id_us__473911B0]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_feedback]'))
ALTER TABLE [dbo].[user_feedback] CHECK CONSTRAINT [FK__user_feed__id_us__473911B0]
GO
/****** Object:  ForeignKey [FK__user_feed__id_us__482D35E9]    Script Date: 04/19/2022 15:06:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_feed__id_us__482D35E9]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_feedback]'))
ALTER TABLE [dbo].[user_feedback]  WITH CHECK ADD  CONSTRAINT [FK__user_feed__id_us__482D35E9] FOREIGN KEY([id_user_to])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_feed__id_us__482D35E9]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_feedback]'))
ALTER TABLE [dbo].[user_feedback] CHECK CONSTRAINT [FK__user_feed__id_us__482D35E9]
GO
/****** Object:  ForeignKey [FK__user_conf__id_us__2F3FCC74]    Script Date: 04/19/2022 15:06:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_conf__id_us__2F3FCC74]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_config_history]'))
ALTER TABLE [dbo].[user_config_history]  WITH CHECK ADD  CONSTRAINT [FK__user_conf__id_us__2F3FCC74] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_conf__id_us__2F3FCC74]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_config_history]'))
ALTER TABLE [dbo].[user_config_history] CHECK CONSTRAINT [FK__user_conf__id_us__2F3FCC74]
GO
/****** Object:  ForeignKey [FK__user_conf__id_us__2A7B1757]    Script Date: 04/19/2022 15:06:56 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_conf__id_us__2A7B1757]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_config]'))
ALTER TABLE [dbo].[user_config]  WITH CHECK ADD  CONSTRAINT [FK__user_conf__id_us__2A7B1757] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_conf__id_us__2A7B1757]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_config]'))
ALTER TABLE [dbo].[user_config] CHECK CONSTRAINT [FK__user_conf__id_us__2A7B1757]
GO
/****** Object:  ForeignKey [FK__thread_st__id_th__6DA71341]    Script Date: 04/19/2022 15:07:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_st__id_th__6DA71341]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_status_change]'))
ALTER TABLE [dbo].[thread_status_change]  WITH CHECK ADD  CONSTRAINT [FK__thread_st__id_th__6DA71341] FOREIGN KEY([id_thread])
REFERENCES [dbo].[thread] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_st__id_th__6DA71341]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_status_change]'))
ALTER TABLE [dbo].[thread_status_change] CHECK CONSTRAINT [FK__thread_st__id_th__6DA71341]
GO
/****** Object:  ForeignKey [FK__thread_st__id_us__6E9B377A]    Script Date: 04/19/2022 15:07:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_st__id_us__6E9B377A]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_status_change]'))
ALTER TABLE [dbo].[thread_status_change]  WITH CHECK ADD  CONSTRAINT [FK__thread_st__id_us__6E9B377A] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_st__id_us__6E9B377A]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_status_change]'))
ALTER TABLE [dbo].[thread_status_change] CHECK CONSTRAINT [FK__thread_st__id_us__6E9B377A]
GO
/****** Object:  ForeignKey [FK__thread_re__id_th__67EE39EB]    Script Date: 04/19/2022 15:07:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_re__id_th__67EE39EB]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_recipient]'))
ALTER TABLE [dbo].[thread_recipient]  WITH CHECK ADD  CONSTRAINT [FK__thread_re__id_th__67EE39EB] FOREIGN KEY([id_thread])
REFERENCES [dbo].[thread] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_re__id_th__67EE39EB]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_recipient]'))
ALTER TABLE [dbo].[thread_recipient] CHECK CONSTRAINT [FK__thread_re__id_th__67EE39EB]
GO
/****** Object:  ForeignKey [FK__thread_re__id_us__68E25E24]    Script Date: 04/19/2022 15:07:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_re__id_us__68E25E24]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_recipient]'))
ALTER TABLE [dbo].[thread_recipient]  WITH CHECK ADD  CONSTRAINT [FK__thread_re__id_us__68E25E24] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_re__id_us__68E25E24]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_recipient]'))
ALTER TABLE [dbo].[thread_recipient] CHECK CONSTRAINT [FK__thread_re__id_us__68E25E24]
GO
/****** Object:  ForeignKey [FK__thread_po__id_th__735FEC97]    Script Date: 04/19/2022 15:07:09 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_po__id_th__735FEC97]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_post]'))
ALTER TABLE [dbo].[thread_post]  WITH CHECK ADD  CONSTRAINT [FK__thread_po__id_th__735FEC97] FOREIGN KEY([id_thread])
REFERENCES [dbo].[thread] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_po__id_th__735FEC97]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_post]'))
ALTER TABLE [dbo].[thread_post] CHECK CONSTRAINT [FK__thread_po__id_th__735FEC97]
GO
/****** Object:  ForeignKey [FK__thread_po__id_us__745410D0]    Script Date: 04/19/2022 15:07:09 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_po__id_us__745410D0]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_post]'))
ALTER TABLE [dbo].[thread_post]  WITH CHECK ADD  CONSTRAINT [FK__thread_po__id_us__745410D0] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread_po__id_us__745410D0]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread_post]'))
ALTER TABLE [dbo].[thread_post] CHECK CONSTRAINT [FK__thread_po__id_us__745410D0]
GO
/****** Object:  ForeignKey [FK__thread__id_user___632984CE]    Script Date: 04/19/2022 15:07:17 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread__id_user___632984CE]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread]'))
ALTER TABLE [dbo].[thread]  WITH CHECK ADD  CONSTRAINT [FK__thread__id_user___632984CE] FOREIGN KEY([id_user_from])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__thread__id_user___632984CE]') AND parent_object_id = OBJECT_ID(N'[dbo].[thread]'))
ALTER TABLE [dbo].[thread] CHECK CONSTRAINT [FK__thread__id_user___632984CE]
GO
/****** Object:  ForeignKey [FK__sample_se__id_us__1C512311]    Script Date: 04/19/2022 15:07:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sample_se__id_us__1C512311]') AND parent_object_id = OBJECT_ID(N'[dbo].[sample_search]'))
ALTER TABLE [dbo].[sample_search]  WITH CHECK ADD  CONSTRAINT [FK__sample_se__id_us__1C512311] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sample_se__id_us__1C512311]') AND parent_object_id = OBJECT_ID(N'[dbo].[sample_search]'))
ALTER TABLE [dbo].[sample_search] CHECK CONSTRAINT [FK__sample_se__id_us__1C512311]
GO
/****** Object:  ForeignKey [FK__sample_ge__id_us__2115D82E]    Script Date: 04/19/2022 15:07:26 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sample_ge__id_us__2115D82E]') AND parent_object_id = OBJECT_ID(N'[dbo].[sample_get_data]'))
ALTER TABLE [dbo].[sample_get_data]  WITH CHECK ADD  CONSTRAINT [FK__sample_ge__id_us__2115D82E] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sample_ge__id_us__2115D82E]') AND parent_object_id = OBJECT_ID(N'[dbo].[sample_get_data]'))
ALTER TABLE [dbo].[sample_get_data] CHECK CONSTRAINT [FK__sample_ge__id_us__2115D82E]
GO
/****** Object:  ForeignKey [FK__resultrem__done___521EF45D]    Script Date: 04/19/2022 15:07:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__done___521EF45D]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminderhistory]'))
ALTER TABLE [dbo].[resultreminderhistory]  WITH CHECK ADD  CONSTRAINT [FK__resultrem__done___521EF45D] FOREIGN KEY([done_by_id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__done___521EF45D]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminderhistory]'))
ALTER TABLE [dbo].[resultreminderhistory] CHECK CONSTRAINT [FK__resultrem__done___521EF45D]
GO
/****** Object:  ForeignKey [FK__resultrem__id_re__512AD024]    Script Date: 04/19/2022 15:07:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__id_re__512AD024]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminderhistory]'))
ALTER TABLE [dbo].[resultreminderhistory]  WITH CHECK ADD  CONSTRAINT [FK__resultrem__id_re__512AD024] FOREIGN KEY([id_resultreminder])
REFERENCES [dbo].[resultreminder] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__id_re__512AD024]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminderhistory]'))
ALTER TABLE [dbo].[resultreminderhistory] CHECK CONSTRAINT [FK__resultrem__id_re__512AD024]
GO
/****** Object:  ForeignKey [FK__resultrem__done___4C661B07]    Script Date: 04/19/2022 15:07:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__done___4C661B07]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminder]'))
ALTER TABLE [dbo].[resultreminder]  WITH CHECK ADD  CONSTRAINT [FK__resultrem__done___4C661B07] FOREIGN KEY([done_by_id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__done___4C661B07]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminder]'))
ALTER TABLE [dbo].[resultreminder] CHECK CONSTRAINT [FK__resultrem__done___4C661B07]
GO
/****** Object:  ForeignKey [FK__resultrem__id_re__4B71F6CE]    Script Date: 04/19/2022 15:07:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__id_re__4B71F6CE]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminder]'))
ALTER TABLE [dbo].[resultreminder]  WITH CHECK ADD  CONSTRAINT [FK__resultrem__id_re__4B71F6CE] FOREIGN KEY([id_result])
REFERENCES [dbo].[result] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__id_re__4B71F6CE]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminder]'))
ALTER TABLE [dbo].[resultreminder] CHECK CONSTRAINT [FK__resultrem__id_re__4B71F6CE]
GO
/****** Object:  ForeignKey [FK__resultrem__id_us__4A7DD295]    Script Date: 04/19/2022 15:07:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__id_us__4A7DD295]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminder]'))
ALTER TABLE [dbo].[resultreminder]  WITH CHECK ADD  CONSTRAINT [FK__resultrem__id_us__4A7DD295] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__resultrem__id_us__4A7DD295]') AND parent_object_id = OBJECT_ID(N'[dbo].[resultreminder]'))
ALTER TABLE [dbo].[resultreminder] CHECK CONSTRAINT [FK__resultrem__id_us__4A7DD295]
GO
/****** Object:  ForeignKey [FK__uploadedp__id_us__148182CD]    Script Date: 04/19/2022 15:07:43 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__uploadedp__id_us__148182CD]') AND parent_object_id = OBJECT_ID(N'[dbo].[uploadedpicture]'))
ALTER TABLE [dbo].[uploadedpicture]  WITH CHECK ADD  CONSTRAINT [FK__uploadedp__id_us__148182CD] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__uploadedp__id_us__148182CD]') AND parent_object_id = OBJECT_ID(N'[dbo].[uploadedpicture]'))
ALTER TABLE [dbo].[uploadedpicture] CHECK CONSTRAINT [FK__uploadedp__id_us__148182CD]
GO
/****** Object:  ForeignKey [FK__tracking___id_af__71979FB6]    Script Date: 04/19/2022 15:07:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_af__71979FB6]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit]  WITH CHECK ADD  CONSTRAINT [FK__tracking___id_af__71979FB6] FOREIGN KEY([id_affiliate])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_af__71979FB6]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit] CHECK CONSTRAINT [FK__tracking___id_af__71979FB6]
GO
/****** Object:  ForeignKey [FK__tracking___id_re__70A37B7D]    Script Date: 04/19/2022 15:07:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_re__70A37B7D]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit]  WITH CHECK ADD  CONSTRAINT [FK__tracking___id_re__70A37B7D] FOREIGN KEY([id_result])
REFERENCES [dbo].[result] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_re__70A37B7D]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit] CHECK CONSTRAINT [FK__tracking___id_re__70A37B7D]
GO
/****** Object:  ForeignKey [FK__tracking___id_tr__6FAF5744]    Script Date: 04/19/2022 15:07:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_tr__6FAF5744]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit]  WITH CHECK ADD  CONSTRAINT [FK__tracking___id_tr__6FAF5744] FOREIGN KEY([id_tracking_pixel])
REFERENCES [dbo].[tracking_pixel] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_tr__6FAF5744]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit] CHECK CONSTRAINT [FK__tracking___id_tr__6FAF5744]
GO
/****** Object:  ForeignKey [FK__tracking___id_us__12C54971]    Script Date: 04/19/2022 15:07:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_us__12C54971]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit]  WITH CHECK ADD  CONSTRAINT [FK__tracking___id_us__12C54971] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_us__12C54971]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_visit]'))
ALTER TABLE [dbo].[tracking_pixel_visit] CHECK CONSTRAINT [FK__tracking___id_us__12C54971]
GO
/****** Object:  ForeignKey [FK__tracking___id_af__7750790C]    Script Date: 04/19/2022 15:08:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_af__7750790C]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_stats]'))
ALTER TABLE [dbo].[tracking_pixel_stats]  WITH CHECK ADD  CONSTRAINT [FK__tracking___id_af__7750790C] FOREIGN KEY([id_affiliate])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_af__7750790C]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_stats]'))
ALTER TABLE [dbo].[tracking_pixel_stats] CHECK CONSTRAINT [FK__tracking___id_af__7750790C]
GO
/****** Object:  ForeignKey [FK__tracking___id_tr__765C54D3]    Script Date: 04/19/2022 15:08:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_tr__765C54D3]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_stats]'))
ALTER TABLE [dbo].[tracking_pixel_stats]  WITH CHECK ADD  CONSTRAINT [FK__tracking___id_tr__765C54D3] FOREIGN KEY([id_tracking_pixel])
REFERENCES [dbo].[tracking_pixel] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_tr__765C54D3]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel_stats]'))
ALTER TABLE [dbo].[tracking_pixel_stats] CHECK CONSTRAINT [FK__tracking___id_tr__765C54D3]
GO
/****** Object:  ForeignKey [FK__tracking___id_us__6AEAA227]    Script Date: 04/19/2022 15:08:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_us__6AEAA227]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel]'))
ALTER TABLE [dbo].[tracking_pixel]  WITH CHECK ADD  CONSTRAINT [FK__tracking___id_us__6AEAA227] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__tracking___id_us__6AEAA227]') AND parent_object_id = OBJECT_ID(N'[dbo].[tracking_pixel]'))
ALTER TABLE [dbo].[tracking_pixel] CHECK CONSTRAINT [FK__tracking___id_us__6AEAA227]
GO
/****** Object:  ForeignKey [FK__proxyprov__id_us__5DA4B881]    Script Date: 04/19/2022 15:08:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxyprov__id_us__5DA4B881]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxyprovider]'))
ALTER TABLE [dbo].[proxyprovider]  WITH CHECK ADD  CONSTRAINT [FK__proxyprov__id_us__5DA4B881] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxyprov__id_us__5DA4B881]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxyprovider]'))
ALTER TABLE [dbo].[proxyprovider] CHECK CONSTRAINT [FK__proxyprov__id_us__5DA4B881]
GO
/****** Object:  ForeignKey [FK__proxyinve__id_us__4B72905B]    Script Date: 04/19/2022 15:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxyinve__id_us__4B72905B]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxyinventory]'))
ALTER TABLE [dbo].[proxyinventory]  WITH CHECK ADD  CONSTRAINT [FK__proxyinve__id_us__4B72905B] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxyinve__id_us__4B72905B]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxyinventory]'))
ALTER TABLE [dbo].[proxyinventory] CHECK CONSTRAINT [FK__proxyinve__id_us__4B72905B]
GO
/****** Object:  ForeignKey [FK__post__id_profile__3B15FFE4]    Script Date: 04/19/2022 15:08:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__post__id_profile__3B15FFE4]') AND parent_object_id = OBJECT_ID(N'[dbo].[post]'))
ALTER TABLE [dbo].[post]  WITH CHECK ADD  CONSTRAINT [FK__post__id_profile__3B15FFE4] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__post__id_profile__3B15FFE4]') AND parent_object_id = OBJECT_ID(N'[dbo].[post]'))
ALTER TABLE [dbo].[post] CHECK CONSTRAINT [FK__post__id_profile__3B15FFE4]
GO
/****** Object:  ForeignKey [FK__pipeline___id_pi__234D0926]    Script Date: 04/19/2022 15:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_pi__234D0926]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_user]'))
ALTER TABLE [dbo].[pipeline_user]  WITH CHECK ADD  CONSTRAINT [FK__pipeline___id_pi__234D0926] FOREIGN KEY([id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_pi__234D0926]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_user]'))
ALTER TABLE [dbo].[pipeline_user] CHECK CONSTRAINT [FK__pipeline___id_pi__234D0926]
GO
/****** Object:  ForeignKey [FK__pipeline___id_re__2258E4ED]    Script Date: 04/19/2022 15:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_re__2258E4ED]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_user]'))
ALTER TABLE [dbo].[pipeline_user]  WITH CHECK ADD  CONSTRAINT [FK__pipeline___id_re__2258E4ED] FOREIGN KEY([id_receiver])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_re__2258E4ED]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_user]'))
ALTER TABLE [dbo].[pipeline_user] CHECK CONSTRAINT [FK__pipeline___id_re__2258E4ED]
GO
/****** Object:  ForeignKey [FK__pipeline___id_us__2164C0B4]    Script Date: 04/19/2022 15:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_us__2164C0B4]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_user]'))
ALTER TABLE [dbo].[pipeline_user]  WITH CHECK ADD  CONSTRAINT [FK__pipeline___id_us__2164C0B4] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_us__2164C0B4]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_user]'))
ALTER TABLE [dbo].[pipeline_user] CHECK CONSTRAINT [FK__pipeline___id_us__2164C0B4]
GO
/****** Object:  ForeignKey [FK__nbshareco__id_us__02381BD3]    Script Date: 04/19/2022 15:08:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbshareco__id_us__02381BD3]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbsharecommentfile]'))
ALTER TABLE [dbo].[nbsharecommentfile]  WITH CHECK ADD  CONSTRAINT [FK__nbshareco__id_us__02381BD3] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbshareco__id_us__02381BD3]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbsharecommentfile]'))
ALTER TABLE [dbo].[nbsharecommentfile] CHECK CONSTRAINT [FK__nbshareco__id_us__02381BD3]
GO
/****** Object:  ForeignKey [FK__nbshareco__id_sh__06FCD0F0]    Script Date: 04/19/2022 15:08:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbshareco__id_sh__06FCD0F0]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbsharecomment]'))
ALTER TABLE [dbo].[nbsharecomment]  WITH CHECK ADD  CONSTRAINT [FK__nbshareco__id_sh__06FCD0F0] FOREIGN KEY([id_sharecommentfile])
REFERENCES [dbo].[nbsharecommentfile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbshareco__id_sh__06FCD0F0]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbsharecomment]'))
ALTER TABLE [dbo].[nbsharecomment] CHECK CONSTRAINT [FK__nbshareco__id_sh__06FCD0F0]
GO
/****** Object:  ForeignKey [FK__nbrun_his__id_ru__67842597]    Script Date: 04/19/2022 15:09:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun_his__id_ru__67842597]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun_history]'))
ALTER TABLE [dbo].[nbrun_history]  WITH CHECK ADD  CONSTRAINT [FK__nbrun_his__id_ru__67842597] FOREIGN KEY([id_run])
REFERENCES [dbo].[nbrun] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun_his__id_ru__67842597]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun_history]'))
ALTER TABLE [dbo].[nbrun_history] CHECK CONSTRAINT [FK__nbrun_his__id_ru__67842597]
GO
/****** Object:  ForeignKey [FK__nbrun_his__id_us__687849D0]    Script Date: 04/19/2022 15:09:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun_his__id_us__687849D0]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun_history]'))
ALTER TABLE [dbo].[nbrun_history]  WITH CHECK ADD  CONSTRAINT [FK__nbrun_his__id_us__687849D0] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun_his__id_us__687849D0]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun_history]'))
ALTER TABLE [dbo].[nbrun_history] CHECK CONSTRAINT [FK__nbrun_his__id_us__687849D0]
GO
/****** Object:  ForeignKey [FK__nbjob_his__id_us__6E312326]    Script Date: 04/19/2022 15:09:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbjob_his__id_us__6E312326]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbjob_history]'))
ALTER TABLE [dbo].[nbjob_history]  WITH CHECK ADD  CONSTRAINT [FK__nbjob_his__id_us__6E312326] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbjob_his__id_us__6E312326]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbjob_history]'))
ALTER TABLE [dbo].[nbjob_history] CHECK CONSTRAINT [FK__nbjob_his__id_us__6E312326]
GO
/****** Object:  ForeignKey [FK__nbjob__id_run__11AF698D]    Script Date: 04/19/2022 15:09:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbjob__id_run__11AF698D]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbjob]'))
ALTER TABLE [dbo].[nbjob]  WITH CHECK ADD  CONSTRAINT [FK__nbjob__id_run__11AF698D] FOREIGN KEY([id_run])
REFERENCES [dbo].[nbrun] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbjob__id_run__11AF698D]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbjob]'))
ALTER TABLE [dbo].[nbjob] CHECK CONSTRAINT [FK__nbjob__id_run__11AF698D]
GO
/****** Object:  ForeignKey [FK__nbjob__id_user__10BB4554]    Script Date: 04/19/2022 15:09:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbjob__id_user__10BB4554]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbjob]'))
ALTER TABLE [dbo].[nbjob]  WITH CHECK ADD  CONSTRAINT [FK__nbjob__id_user__10BB4554] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbjob__id_user__10BB4554]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbjob]'))
ALTER TABLE [dbo].[nbjob] CHECK CONSTRAINT [FK__nbjob__id_user__10BB4554]
GO
/****** Object:  ForeignKey [FK__nbcomment__id_us__77BA8D60]    Script Date: 04/19/2022 15:09:31 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcomment__id_us__77BA8D60]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommentfile]'))
ALTER TABLE [dbo].[nbcommentfile]  WITH CHECK ADD  CONSTRAINT [FK__nbcomment__id_us__77BA8D60] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcomment__id_us__77BA8D60]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommentfile]'))
ALTER TABLE [dbo].[nbcommentfile] CHECK CONSTRAINT [FK__nbcomment__id_us__77BA8D60]
GO
/****** Object:  ForeignKey [FK__nbcomment__id_co__7C7F427D]    Script Date: 04/19/2022 15:09:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcomment__id_co__7C7F427D]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcomment]'))
ALTER TABLE [dbo].[nbcomment]  WITH CHECK ADD  CONSTRAINT [FK__nbcomment__id_co__7C7F427D] FOREIGN KEY([id_commentfile])
REFERENCES [dbo].[nbcommentfile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcomment__id_co__7C7F427D]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcomment]'))
ALTER TABLE [dbo].[nbcomment] CHECK CONSTRAINT [FK__nbcomment__id_co__7C7F427D]
GO
/****** Object:  ForeignKey [FK__nbmention__id_co__31E72EF5]    Script Date: 04/19/2022 15:09:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbmention__id_co__31E72EF5]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbmention]'))
ALTER TABLE [dbo].[nbmention]  WITH CHECK ADD  CONSTRAINT [FK__nbmention__id_co__31E72EF5] FOREIGN KEY([id_command])
REFERENCES [dbo].[nbcommand] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbmention__id_co__31E72EF5]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbmention]'))
ALTER TABLE [dbo].[nbmention] CHECK CONSTRAINT [FK__nbmention__id_co__31E72EF5]
GO
/****** Object:  ForeignKey [FK__nbmention__id_re__32DB532E]    Script Date: 04/19/2022 15:09:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbmention__id_re__32DB532E]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbmention]'))
ALTER TABLE [dbo].[nbmention]  WITH CHECK ADD  CONSTRAINT [FK__nbmention__id_re__32DB532E] FOREIGN KEY([id_result])
REFERENCES [dbo].[result] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbmention__id_re__32DB532E]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbmention]'))
ALTER TABLE [dbo].[nbmention] CHECK CONSTRAINT [FK__nbmention__id_re__32DB532E]
GO
/****** Object:  ForeignKey [FK__nbcommand__id_co__5FE303CF]    Script Date: 04/19/2022 15:09:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__id_co__5FE303CF]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand_history]'))
ALTER TABLE [dbo].[nbcommand_history]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__id_co__5FE303CF] FOREIGN KEY([id_command])
REFERENCES [dbo].[nbcommand] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__id_co__5FE303CF]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand_history]'))
ALTER TABLE [dbo].[nbcommand_history] CHECK CONSTRAINT [FK__nbcommand__id_co__5FE303CF]
GO
/****** Object:  ForeignKey [FK__sis_linke__id_si__474C602F]    Script Date: 04/19/2022 15:09:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_linke__id_si__474C602F]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_linkedin_directory_of_companies_entry_scraping_history]'))
ALTER TABLE [dbo].[sis_linkedin_directory_of_companies_entry_scraping_history]  WITH CHECK ADD  CONSTRAINT [FK__sis_linke__id_si__474C602F] FOREIGN KEY([id_sis_linkedin_directory_of_companies_entry])
REFERENCES [dbo].[sis_directory_entry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_linke__id_si__474C602F]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_linkedin_directory_of_companies_entry_scraping_history]'))
ALTER TABLE [dbo].[sis_linkedin_directory_of_companies_entry_scraping_history] CHECK CONSTRAINT [FK__sis_linke__id_si__474C602F]
GO
/****** Object:  ForeignKey [FK__lnsearch__id_cam__12C8C788]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_cam__12C8C788]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch__id_cam__12C8C788] FOREIGN KEY([id_campaign])
REFERENCES [dbo].[campaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_cam__12C8C788]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__lnsearch__id_cam__12C8C788]
GO
/****** Object:  ForeignKey [FK__lnsearch__id_crm__0618D7E0]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_crm__0618D7E0]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch__id_crm__0618D7E0] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_crm__0618D7E0]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__lnsearch__id_crm__0618D7E0]
GO
/****** Object:  ForeignKey [FK__lnsearch__id_eml__3E3D3572]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_eml__3E3D3572]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch__id_eml__3E3D3572] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_eml__3E3D3572]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__lnsearch__id_eml__3E3D3572]
GO
/****** Object:  ForeignKey [FK__lnsearch__id_lnc__2F63061D]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_lnc__2F63061D]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch__id_lnc__2F63061D] FOREIGN KEY([id_lncompanysize_drop_me])
REFERENCES [dbo].[lncompanysize] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_lnc__2F63061D]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__lnsearch__id_lnc__2F63061D]
GO
/****** Object:  ForeignKey [FK__lnsearch__id_mes__72DF43B8]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_mes__72DF43B8]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch__id_mes__72DF43B8] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch__id_mes__72DF43B8]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__lnsearch__id_mes__72DF43B8]
GO
/****** Object:  ForeignKey [FK__search__flood_id__769BE432]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search__flood_id__769BE432]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__search__flood_id__769BE432] FOREIGN KEY([flood_id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search__flood_id__769BE432]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__search__flood_id__769BE432]
GO
/****** Object:  ForeignKey [FK__search__id_lncom__7CAE3475]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search__id_lncom__7CAE3475]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__search__id_lncom__7CAE3475] FOREIGN KEY([id_lncompanytype_drop_me])
REFERENCES [dbo].[lncompanytype] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search__id_lncom__7CAE3475]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__search__id_lncom__7CAE3475]
GO
/****** Object:  ForeignKey [FK__search__id_lnyea__10F94EC1]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search__id_lnyea__10F94EC1]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH CHECK ADD  CONSTRAINT [FK__search__id_lnyea__10F94EC1] FOREIGN KEY([id_lnyearsincurrentposition_drop_me])
REFERENCES [dbo].[lnyearsincurrentposition] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search__id_lnyea__10F94EC1]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK__search__id_lnyea__10F94EC1]
GO
/****** Object:  ForeignKey [FK_lnsearch_user]    Script Date: 04/19/2022 15:10:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnsearch_user]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search]  WITH NOCHECK ADD  CONSTRAINT [FK_lnsearch_user] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnsearch_user]') AND parent_object_id = OBJECT_ID(N'[dbo].[search]'))
ALTER TABLE [dbo].[search] CHECK CONSTRAINT [FK_lnsearch_user]
GO
/****** Object:  ForeignKey [FK__signaljob__id_se__36514AC7]    Script Date: 04/19/2022 15:10:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signaljob__id_se__36514AC7]') AND parent_object_id = OBJECT_ID(N'[dbo].[signaljob]'))
ALTER TABLE [dbo].[signaljob]  WITH CHECK ADD  CONSTRAINT [FK__signaljob__id_se__36514AC7] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signaljob__id_se__36514AC7]') AND parent_object_id = OBJECT_ID(N'[dbo].[signaljob]'))
ALTER TABLE [dbo].[signaljob] CHECK CONSTRAINT [FK__signaljob__id_se__36514AC7]
GO
/****** Object:  ForeignKey [FK__lnsearchk__id_ln__51EF2864]    Script Date: 04/19/2022 15:10:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchk__id_ln__51EF2864]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchkeyword]'))
ALTER TABLE [dbo].[searchkeyword]  WITH CHECK ADD  CONSTRAINT [FK__lnsearchk__id_ln__51EF2864] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchk__id_ln__51EF2864]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchkeyword]'))
ALTER TABLE [dbo].[searchkeyword] CHECK CONSTRAINT [FK__lnsearchk__id_ln__51EF2864]
GO
/****** Object:  ForeignKey [FK__nbrun__id_search__2D2279D8]    Script Date: 04/19/2022 15:11:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun__id_search__2D2279D8]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun]'))
ALTER TABLE [dbo].[nbrun]  WITH CHECK ADD  CONSTRAINT [FK__nbrun__id_search__2D2279D8] FOREIGN KEY([id_search_for_tagging])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun__id_search__2D2279D8]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun]'))
ALTER TABLE [dbo].[nbrun] CHECK CONSTRAINT [FK__nbrun__id_search__2D2279D8]
GO
/****** Object:  ForeignKey [FK__nbrun__id_user__0BF69037]    Script Date: 04/19/2022 15:11:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun__id_user__0BF69037]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun]'))
ALTER TABLE [dbo].[nbrun]  WITH CHECK ADD  CONSTRAINT [FK__nbrun__id_user__0BF69037] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbrun__id_user__0BF69037]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbrun]'))
ALTER TABLE [dbo].[nbrun] CHECK CONSTRAINT [FK__nbrun__id_user__0BF69037]
GO
/****** Object:  ForeignKey [FK__milestone__id_pi__1D1B679B]    Script Date: 04/19/2022 15:11:15 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__milestone__id_pi__1D1B679B]') AND parent_object_id = OBJECT_ID(N'[dbo].[milestone_ssm_drx]'))
ALTER TABLE [dbo].[milestone_ssm_drx]  WITH CHECK ADD  CONSTRAINT [FK__milestone__id_pi__1D1B679B] FOREIGN KEY([id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__milestone__id_pi__1D1B679B]') AND parent_object_id = OBJECT_ID(N'[dbo].[milestone_ssm_drx]'))
ALTER TABLE [dbo].[milestone_ssm_drx] CHECK CONSTRAINT [FK__milestone__id_pi__1D1B679B]
GO
/****** Object:  ForeignKey [FK__stat_drl___id_me__1328D9A1]    Script Date: 04/19/2022 15:11:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_drl___id_me__1328D9A1]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_report]'))
ALTER TABLE [dbo].[stat_drl_shared_report]  WITH CHECK ADD  CONSTRAINT [FK__stat_drl___id_me__1328D9A1] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_drl___id_me__1328D9A1]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_report]'))
ALTER TABLE [dbo].[stat_drl_shared_report] CHECK CONSTRAINT [FK__stat_drl___id_me__1328D9A1]
GO
/****** Object:  ForeignKey [FK__lnsearch___id_ln__7E50F664]    Script Date: 04/19/2022 15:11:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch___id_ln__7E50F664]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_message]'))
ALTER TABLE [dbo].[search_message]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch___id_ln__7E50F664] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch___id_ln__7E50F664]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_message]'))
ALTER TABLE [dbo].[search_message] CHECK CONSTRAINT [FK__lnsearch___id_ln__7E50F664]
GO
/****** Object:  ForeignKey [FK__lnsearch___id_me__7F451A9D]    Script Date: 04/19/2022 15:11:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch___id_me__7F451A9D]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_message]'))
ALTER TABLE [dbo].[search_message]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch___id_me__7F451A9D] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch___id_me__7F451A9D]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_message]'))
ALTER TABLE [dbo].[search_message] CHECK CONSTRAINT [FK__lnsearch___id_me__7F451A9D]
GO
/****** Object:  ForeignKey [FK__lnsearch___id_us__7D5CD22B]    Script Date: 04/19/2022 15:11:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch___id_us__7D5CD22B]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_message]'))
ALTER TABLE [dbo].[search_message]  WITH CHECK ADD  CONSTRAINT [FK__lnsearch___id_us__7D5CD22B] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearch___id_us__7D5CD22B]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_message]'))
ALTER TABLE [dbo].[search_message] CHECK CONSTRAINT [FK__lnsearch___id_us__7D5CD22B]
GO
/****** Object:  ForeignKey [FK__message_k__id_me__661F0981]    Script Date: 04/19/2022 15:11:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message_k__id_me__661F0981]') AND parent_object_id = OBJECT_ID(N'[dbo].[message_keyword]'))
ALTER TABLE [dbo].[message_keyword]  WITH CHECK ADD  CONSTRAINT [FK__message_k__id_me__661F0981] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message_k__id_me__661F0981]') AND parent_object_id = OBJECT_ID(N'[dbo].[message_keyword]'))
ALTER TABLE [dbo].[message_keyword] CHECK CONSTRAINT [FK__message_k__id_me__661F0981]
GO
/****** Object:  ForeignKey [FK__login__id_user__6CA31EA0]    Script Date: 04/19/2022 15:11:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__login__id_user__6CA31EA0]') AND parent_object_id = OBJECT_ID(N'[dbo].[login]'))
ALTER TABLE [dbo].[login]  WITH CHECK ADD  CONSTRAINT [FK__login__id_user__6CA31EA0] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__login__id_user__6CA31EA0]') AND parent_object_id = OBJECT_ID(N'[dbo].[login]'))
ALTER TABLE [dbo].[login] CHECK CONSTRAINT [FK__login__id_user__6CA31EA0]
GO
/****** Object:  ForeignKey [FK__client__billing___74C22206]    Script Date: 04/19/2022 15:12:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__billing___74C22206]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [FK__client__billing___74C22206] FOREIGN KEY([billing_id_lncountry])
REFERENCES [dbo].[lncountry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__billing___74C22206]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [FK__client__billing___74C22206]
GO
/****** Object:  ForeignKey [FK__client__id_timez__21D400D5]    Script Date: 04/19/2022 15:12:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__id_timez__21D400D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [FK__client__id_timez__21D400D5] FOREIGN KEY([id_timezone])
REFERENCES [dbo].[timezone] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__id_timez__21D400D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [FK__client__id_timez__21D400D5]
GO
/****** Object:  ForeignKey [FK__client__shm_aler__6CE7F932]    Script Date: 04/19/2022 15:12:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__shm_aler__6CE7F932]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [FK__client__shm_aler__6CE7F932] FOREIGN KEY([shm_alerts_id_user_1])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__shm_aler__6CE7F932]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [FK__client__shm_aler__6CE7F932]
GO
/****** Object:  ForeignKey [FK__client__shm_aler__6DDC1D6B]    Script Date: 04/19/2022 15:12:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__shm_aler__6DDC1D6B]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [FK__client__shm_aler__6DDC1D6B] FOREIGN KEY([shm_alerts_id_user_2])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__shm_aler__6DDC1D6B]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [FK__client__shm_aler__6DDC1D6B]
GO
/****** Object:  ForeignKey [FK__client__shm_aler__6ED041A4]    Script Date: 04/19/2022 15:12:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__shm_aler__6ED041A4]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [FK__client__shm_aler__6ED041A4] FOREIGN KEY([shm_alerts_id_user_3])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__client__shm_aler__6ED041A4]') AND parent_object_id = OBJECT_ID(N'[dbo].[client]'))
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [FK__client__shm_aler__6ED041A4]
GO
/****** Object:  ForeignKey [FK__lnuser__id_clien__1CEC120F]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_clien__1CEC120F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_clien__1CEC120F] FOREIGN KEY([id_client_allocated_for_crowdtrust])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_clien__1CEC120F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_clien__1CEC120F]
GO
/****** Object:  ForeignKey [FK__lnuser__id_clien__7B361889]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_clien__7B361889]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_clien__7B361889] FOREIGN KEY([id_client_allocated])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_clien__7B361889]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_clien__7B361889]
GO
/****** Object:  ForeignKey [FK__lnuser__id_lncou__330D7282]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_lncou__330D7282]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_lncou__330D7282] FOREIGN KEY([id_lncountry])
REFERENCES [dbo].[lncountry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_lncou__330D7282]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_lncou__330D7282]
GO
/****** Object:  ForeignKey [FK__lnuser__id_lnind__340196BB]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_lnind__340196BB]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_lnind__340196BB] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_lnind__340196BB]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_lnind__340196BB]
GO
/****** Object:  ForeignKey [FK__lnuser__id_lnuse__55628A86]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_lnuse__55628A86]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_lnuse__55628A86] FOREIGN KEY([id_lnusertemplate])
REFERENCES [dbo].[lnusertemplate] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_lnuse__55628A86]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_lnuse__55628A86]
GO
/****** Object:  ForeignKey [FK__lnuser__id_proxy__574CF277]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_proxy__574CF277]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_proxy__574CF277] FOREIGN KEY([id_proxy_for_email])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_proxy__574CF277]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_proxy__574CF277]
GO
/****** Object:  ForeignKey [FK__lnuser__id_proxy__676D910C]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_proxy__676D910C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_proxy__676D910C] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_proxy__676D910C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_proxy__676D910C]
GO
/****** Object:  ForeignKey [FK__lnuser__id_user__000AF8CF]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_user__000AF8CF]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_user__000AF8CF] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_user__000AF8CF]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_user__000AF8CF]
GO
/****** Object:  ForeignKey [FK__lnuser__id_worke__52F31D05]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_worke__52F31D05]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_worke__52F31D05] FOREIGN KEY([id_worker_for_botting])
REFERENCES [dbo].[worker] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_worke__52F31D05]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_worke__52F31D05]
GO
/****** Object:  ForeignKey [FK__lnuser__id_worke__6FC465DD]    Script Date: 04/19/2022 15:13:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_worke__6FC465DD]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser]  WITH CHECK ADD  CONSTRAINT [FK__lnuser__id_worke__6FC465DD] FOREIGN KEY([id_worker])
REFERENCES [dbo].[worker] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuser__id_worke__6FC465DD]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuser]'))
ALTER TABLE [dbo].[lnuser] CHECK CONSTRAINT [FK__lnuser__id_worke__6FC465DD]
GO
/****** Object:  ForeignKey [FK__paypal_su__id_bu__0FE5F61F]    Script Date: 04/19/2022 15:14:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__paypal_su__id_bu__0FE5F61F]') AND parent_object_id = OBJECT_ID(N'[dbo].[paypal_subscription]'))
ALTER TABLE [dbo].[paypal_subscription]  WITH CHECK ADD  CONSTRAINT [FK__paypal_su__id_bu__0FE5F61F] FOREIGN KEY([id_buffer_paypal_notification])
REFERENCES [dbo].[buffer_paypal_notification] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__paypal_su__id_bu__0FE5F61F]') AND parent_object_id = OBJECT_ID(N'[dbo].[paypal_subscription]'))
ALTER TABLE [dbo].[paypal_subscription] CHECK CONSTRAINT [FK__paypal_su__id_bu__0FE5F61F]
GO
/****** Object:  ForeignKey [FK__paypal_su__id_cl__10DA1A58]    Script Date: 04/19/2022 15:14:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__paypal_su__id_cl__10DA1A58]') AND parent_object_id = OBJECT_ID(N'[dbo].[paypal_subscription]'))
ALTER TABLE [dbo].[paypal_subscription]  WITH CHECK ADD  CONSTRAINT [FK__paypal_su__id_cl__10DA1A58] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__paypal_su__id_cl__10DA1A58]') AND parent_object_id = OBJECT_ID(N'[dbo].[paypal_subscription]'))
ALTER TABLE [dbo].[paypal_subscription] CHECK CONSTRAINT [FK__paypal_su__id_cl__10DA1A58]
GO
/****** Object:  ForeignKey [FK__log__id_peer__4277DAAA]    Script Date: 04/19/2022 15:14:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__log__id_peer__4277DAAA]') AND parent_object_id = OBJECT_ID(N'[dbo].[log]'))
ALTER TABLE [dbo].[log]  WITH CHECK ADD  CONSTRAINT [FK__log__id_peer__4277DAAA] FOREIGN KEY([id_worker])
REFERENCES [dbo].[worker] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__log__id_peer__4277DAAA]') AND parent_object_id = OBJECT_ID(N'[dbo].[log]'))
ALTER TABLE [dbo].[log] CHECK CONSTRAINT [FK__log__id_peer__4277DAAA]
GO
/****** Object:  ForeignKey [FK__pipeline__id_lnu__5CB09448]    Script Date: 04/19/2022 15:14:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline__id_lnu__5CB09448]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline]'))
ALTER TABLE [dbo].[pipeline]  WITH CHECK ADD  CONSTRAINT [FK__pipeline__id_lnu__5CB09448] FOREIGN KEY([id_lnusertemplate])
REFERENCES [dbo].[lnusertemplate] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline__id_lnu__5CB09448]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline]'))
ALTER TABLE [dbo].[pipeline] CHECK CONSTRAINT [FK__pipeline__id_lnu__5CB09448]
GO
/****** Object:  ForeignKey [FK__pipeline__id_use__4A0CDAB8]    Script Date: 04/19/2022 15:14:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline__id_use__4A0CDAB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline]'))
ALTER TABLE [dbo].[pipeline]  WITH CHECK ADD  CONSTRAINT [FK__pipeline__id_use__4A0CDAB8] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline__id_use__4A0CDAB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline]'))
ALTER TABLE [dbo].[pipeline] CHECK CONSTRAINT [FK__pipeline__id_use__4A0CDAB8]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_ln__47146B2F]    Script Date: 04/19/2022 15:14:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__47146B2F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplateschool]'))
ALTER TABLE [dbo].[lnusertemplateschool]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_ln__47146B2F] FOREIGN KEY([id_lnusertemplate])
REFERENCES [dbo].[lnusertemplate] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__47146B2F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplateschool]'))
ALTER TABLE [dbo].[lnusertemplateschool] CHECK CONSTRAINT [FK__lnusertem__id_ln__47146B2F]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_us__48088F68]    Script Date: 04/19/2022 15:14:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_us__48088F68]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplateschool]'))
ALTER TABLE [dbo].[lnusertemplateschool]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_us__48088F68] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_us__48088F68]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplateschool]'))
ALTER TABLE [dbo].[lnusertemplateschool] CHECK CONSTRAINT [FK__lnusertem__id_us__48088F68]
GO
/****** Object:  ForeignKey [FK__lnuserdom__id_us__5A273FA3]    Script Date: 04/19/2022 15:14:52 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserdom__id_us__5A273FA3]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserdomain]'))
ALTER TABLE [dbo].[lnuserdomain]  WITH CHECK ADD  CONSTRAINT [FK__lnuserdom__id_us__5A273FA3] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserdom__id_us__5A273FA3]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserdomain]'))
ALTER TABLE [dbo].[lnuserdomain] CHECK CONSTRAINT [FK__lnuserdom__id_us__5A273FA3]
GO
/****** Object:  ForeignKey [FK__pipeline___id_ln__51ADFC80]    Script Date: 04/19/2022 15:15:15 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_ln__51ADFC80]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]'))
ALTER TABLE [dbo].[pipeline_lnuser]  WITH CHECK ADD  CONSTRAINT [FK__pipeline___id_ln__51ADFC80] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_ln__51ADFC80]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]'))
ALTER TABLE [dbo].[pipeline_lnuser] CHECK CONSTRAINT [FK__pipeline___id_ln__51ADFC80]
GO
/****** Object:  ForeignKey [FK__pipeline___id_pi__50B9D847]    Script Date: 04/19/2022 15:15:15 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_pi__50B9D847]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]'))
ALTER TABLE [dbo].[pipeline_lnuser]  WITH CHECK ADD  CONSTRAINT [FK__pipeline___id_pi__50B9D847] FOREIGN KEY([id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_pi__50B9D847]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]'))
ALTER TABLE [dbo].[pipeline_lnuser] CHECK CONSTRAINT [FK__pipeline___id_pi__50B9D847]
GO
/****** Object:  ForeignKey [FK__pipeline___id_us__4FC5B40E]    Script Date: 04/19/2022 15:15:15 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_us__4FC5B40E]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]'))
ALTER TABLE [dbo].[pipeline_lnuser]  WITH CHECK ADD  CONSTRAINT [FK__pipeline___id_us__4FC5B40E] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pipeline___id_us__4FC5B40E]') AND parent_object_id = OBJECT_ID(N'[dbo].[pipeline_lnuser]'))
ALTER TABLE [dbo].[pipeline_lnuser] CHECK CONSTRAINT [FK__pipeline___id_us__4FC5B40E]
GO
/****** Object:  ForeignKey [FK__proxy__cosmos_id__2DC19856]    Script Date: 04/19/2022 15:15:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxy__cosmos_id__2DC19856]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxy]'))
ALTER TABLE [dbo].[proxy]  WITH CHECK ADD  CONSTRAINT [FK__proxy__cosmos_id__2DC19856] FOREIGN KEY([cosmos_id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxy__cosmos_id__2DC19856]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxy]'))
ALTER TABLE [dbo].[proxy] CHECK CONSTRAINT [FK__proxy__cosmos_id__2DC19856]
GO
/****** Object:  ForeignKey [FK__proxy__id_user__2E0BC1D5]    Script Date: 04/19/2022 15:15:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxy__id_user__2E0BC1D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxy]'))
ALTER TABLE [dbo].[proxy]  WITH CHECK ADD  CONSTRAINT [FK__proxy__id_user__2E0BC1D5] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__proxy__id_user__2E0BC1D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[proxy]'))
ALTER TABLE [dbo].[proxy] CHECK CONSTRAINT [FK__proxy__id_user__2E0BC1D5]
GO
/****** Object:  ForeignKey [FK__lnusersch__id_ln__537A4214]    Script Date: 04/19/2022 15:15:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusersch__id_ln__537A4214]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserschool]'))
ALTER TABLE [dbo].[lnuserschool]  WITH CHECK ADD  CONSTRAINT [FK__lnusersch__id_ln__537A4214] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusersch__id_ln__537A4214]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserschool]'))
ALTER TABLE [dbo].[lnuserschool] CHECK CONSTRAINT [FK__lnusersch__id_ln__537A4214]
GO
/****** Object:  ForeignKey [FK__lnusersch__id_us__546E664D]    Script Date: 04/19/2022 15:15:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusersch__id_us__546E664D]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserschool]'))
ALTER TABLE [dbo].[lnuserschool]  WITH CHECK ADD  CONSTRAINT [FK__lnusersch__id_us__546E664D] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusersch__id_us__546E664D]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserschool]'))
ALTER TABLE [dbo].[lnuserschool] CHECK CONSTRAINT [FK__lnusersch__id_us__546E664D]
GO
/****** Object:  ForeignKey [FK__lnuseract__id_ln__39CD8610]    Script Date: 04/19/2022 15:16:05 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuseract__id_ln__39CD8610]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuseractivity]'))
ALTER TABLE [dbo].[lnuseractivity]  WITH CHECK ADD  CONSTRAINT [FK__lnuseract__id_ln__39CD8610] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuseract__id_ln__39CD8610]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuseractivity]'))
ALTER TABLE [dbo].[lnuseractivity] CHECK CONSTRAINT [FK__lnuseract__id_ln__39CD8610]
GO
/****** Object:  ForeignKey [FK__lnuseract__id_wo__55E4B528]    Script Date: 04/19/2022 15:16:05 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuseract__id_wo__55E4B528]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuseractivity]'))
ALTER TABLE [dbo].[lnuseractivity]  WITH CHECK ADD  CONSTRAINT [FK__lnuseract__id_wo__55E4B528] FOREIGN KEY([id_worker])
REFERENCES [dbo].[worker] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuseract__id_wo__55E4B528]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuseractivity]'))
ALTER TABLE [dbo].[lnuseractivity] CHECK CONSTRAINT [FK__lnuseract__id_wo__55E4B528]
GO
/****** Object:  ForeignKey [FK__lngroup__id_lngr__2077C861]    Script Date: 04/19/2022 15:16:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroup__id_lngr__2077C861]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroup]'))
ALTER TABLE [dbo].[lngroup]  WITH CHECK ADD  CONSTRAINT [FK__lngroup__id_lngr__2077C861] FOREIGN KEY([id_lngroupdirectoryentry])
REFERENCES [dbo].[lngroupdirectoryentry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroup__id_lngr__2077C861]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroup]'))
ALTER TABLE [dbo].[lngroup] CHECK CONSTRAINT [FK__lngroup__id_lngr__2077C861]
GO
/****** Object:  ForeignKey [FK__lngroup__id_user__75035A77]    Script Date: 04/19/2022 15:16:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroup__id_user__75035A77]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroup]'))
ALTER TABLE [dbo].[lngroup]  WITH CHECK ADD  CONSTRAINT [FK__lngroup__id_user__75035A77] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroup__id_user__75035A77]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroup]'))
ALTER TABLE [dbo].[lngroup] CHECK CONSTRAINT [FK__lngroup__id_user__75035A77]
GO
/****** Object:  ForeignKey [FK__search_ln__id_ln__3DF842A5]    Script Date: 04/19/2022 15:16:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__3DF842A5]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lngroup]'))
ALTER TABLE [dbo].[search_lngroup]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_ln__3DF842A5] FOREIGN KEY([id_lngroup])
REFERENCES [dbo].[lngroup] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__3DF842A5]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lngroup]'))
ALTER TABLE [dbo].[search_lngroup] CHECK CONSTRAINT [FK__search_ln__id_ln__3DF842A5]
GO
/****** Object:  ForeignKey [FK__search_ln__id_se__3D041E6C]    Script Date: 04/19/2022 15:16:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__3D041E6C]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lngroup]'))
ALTER TABLE [dbo].[search_lngroup]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_se__3D041E6C] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__3D041E6C]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lngroup]'))
ALTER TABLE [dbo].[search_lngroup] CHECK CONSTRAINT [FK__search_ln__id_se__3D041E6C]
GO
/****** Object:  ForeignKey [FK__search_ln__id_us__3C0FFA33]    Script Date: 04/19/2022 15:16:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_us__3C0FFA33]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lngroup]'))
ALTER TABLE [dbo].[search_lngroup]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_us__3C0FFA33] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_us__3C0FFA33]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lngroup]'))
ALTER TABLE [dbo].[search_lngroup] CHECK CONSTRAINT [FK__search_ln__id_us__3C0FFA33]
GO
/****** Object:  ForeignKey [FK__milestone__id_ln__1856B27E]    Script Date: 04/19/2022 15:16:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__milestone__id_ln__1856B27E]') AND parent_object_id = OBJECT_ID(N'[dbo].[milestone_ipj_lgb]'))
ALTER TABLE [dbo].[milestone_ipj_lgb]  WITH CHECK ADD  CONSTRAINT [FK__milestone__id_ln__1856B27E] FOREIGN KEY([id_lngroup])
REFERENCES [dbo].[lngroup] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__milestone__id_ln__1856B27E]') AND parent_object_id = OBJECT_ID(N'[dbo].[milestone_ipj_lgb]'))
ALTER TABLE [dbo].[milestone_ipj_lgb] CHECK CONSTRAINT [FK__milestone__id_ln__1856B27E]
GO
/****** Object:  ForeignKey [FK__lngroupgr__id_ln__1F2E9E6D]    Script Date: 04/19/2022 15:16:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroupgr__id_ln__1F2E9E6D]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroupgrowth]'))
ALTER TABLE [dbo].[lngroupgrowth]  WITH CHECK ADD  CONSTRAINT [FK__lngroupgr__id_ln__1F2E9E6D] FOREIGN KEY([id_lngroup])
REFERENCES [dbo].[lngroup] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroupgr__id_ln__1F2E9E6D]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroupgrowth]'))
ALTER TABLE [dbo].[lngroupgrowth] CHECK CONSTRAINT [FK__lngroupgr__id_ln__1F2E9E6D]
GO
/****** Object:  ForeignKey [FK__company__id_doma__46466B75]    Script Date: 04/19/2022 15:17:10 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__company__id_doma__46466B75]') AND parent_object_id = OBJECT_ID(N'[dbo].[company]'))
ALTER TABLE [dbo].[company]  WITH CHECK ADD  CONSTRAINT [FK__company__id_doma__46466B75] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__company__id_doma__46466B75]') AND parent_object_id = OBJECT_ID(N'[dbo].[company]'))
ALTER TABLE [dbo].[company] CHECK CONSTRAINT [FK__company__id_doma__46466B75]
GO
/****** Object:  ForeignKey [FK__drl_minut__gct_1__1397B1FF]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__gct_1__1397B1FF]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__gct_1__1397B1FF] FOREIGN KEY([gct_1_id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__gct_1__1397B1FF]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__gct_1__1397B1FF]
GO
/****** Object:  ForeignKey [FK__drl_minut__gct_2__148BD638]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__gct_2__148BD638]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__gct_2__148BD638] FOREIGN KEY([gct_2_id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__gct_2__148BD638]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__gct_2__148BD638]
GO
/****** Object:  ForeignKey [FK__drl_minut__gct_i__16741EAA]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__gct_i__16741EAA]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__gct_i__16741EAA] FOREIGN KEY([gct_id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__gct_i__16741EAA]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__gct_i__16741EAA]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_cl__2C139268]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_cl__2C139268]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__id_cl__2C139268] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_cl__2C139268]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_cl__2C139268]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_ln__30D84785]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_ln__30D84785]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH NOCHECK ADD  CONSTRAINT [FK__drl_minut__id_ln__30D84785] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_ln__30D84785]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_ln__30D84785]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_me__0084DD8B]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_me__0084DD8B]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__id_me__0084DD8B] FOREIGN KEY([id_message_1])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_me__0084DD8B]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_me__0084DD8B]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_me__2FE4234C]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_me__2FE4234C]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__id_me__2FE4234C] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_me__2FE4234C]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_me__2FE4234C]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_me__5C3B6561]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_me__5C3B6561]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__id_me__5C3B6561] FOREIGN KEY([id_message_2])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_me__5C3B6561]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_me__5C3B6561]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_pi__2EEFFF13]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_pi__2EEFFF13]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__id_pi__2EEFFF13] FOREIGN KEY([id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_pi__2EEFFF13]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_pi__2EEFFF13]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_pr__32C08FF7]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_pr__32C08FF7]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__id_pr__32C08FF7] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_pr__32C08FF7]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_pr__32C08FF7]
GO
/****** Object:  ForeignKey [FK__drl_minut__id_se__2D07B6A1]    Script Date: 04/19/2022 15:18:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_se__2D07B6A1]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__drl_minut__id_se__2D07B6A1] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__drl_minut__id_se__2D07B6A1]') AND parent_object_id = OBJECT_ID(N'[dbo].[drl_minutely_stats]'))
ALTER TABLE [dbo].[drl_minutely_stats] CHECK CONSTRAINT [FK__drl_minut__id_se__2D07B6A1]
GO
/****** Object:  ForeignKey [FK__message__id_lngr__71EB1F7F]    Script Date: 04/19/2022 15:18:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_lngr__71EB1F7F]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message]  WITH CHECK ADD  CONSTRAINT [FK__message__id_lngr__71EB1F7F] FOREIGN KEY([id_lngroup])
REFERENCES [dbo].[lngroup] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_lngr__71EB1F7F]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message] CHECK CONSTRAINT [FK__message__id_lngr__71EB1F7F]
GO
/****** Object:  ForeignKey [FK__message__id_pipe__4B00FEF1]    Script Date: 04/19/2022 15:18:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_pipe__4B00FEF1]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message]  WITH CHECK ADD  CONSTRAINT [FK__message__id_pipe__4B00FEF1] FOREIGN KEY([id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_pipe__4B00FEF1]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message] CHECK CONSTRAINT [FK__message__id_pipe__4B00FEF1]
GO
/****** Object:  ForeignKey [FK__message__id_temp__29BBFD48]    Script Date: 04/19/2022 15:18:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_temp__29BBFD48]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message]  WITH CHECK ADD  CONSTRAINT [FK__message__id_temp__29BBFD48] FOREIGN KEY([id_template])
REFERENCES [dbo].[template] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_temp__29BBFD48]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message] CHECK CONSTRAINT [FK__message__id_temp__29BBFD48]
GO
/****** Object:  ForeignKey [FK__message__id_user__70F6FB46]    Script Date: 04/19/2022 15:18:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_user__70F6FB46]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message]  WITH CHECK ADD  CONSTRAINT [FK__message__id_user__70F6FB46] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__message__id_user__70F6FB46]') AND parent_object_id = OBJECT_ID(N'[dbo].[message]'))
ALTER TABLE [dbo].[message] CHECK CONSTRAINT [FK__message__id_user__70F6FB46]
GO
/****** Object:  ForeignKey [FK__liprofile__id_ln__13A7DD28]    Script Date: 04/19/2022 15:19:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liprofile__id_ln__13A7DD28]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile]  WITH CHECK ADD  CONSTRAINT [FK__liprofile__id_ln__13A7DD28] FOREIGN KEY([id_company_from_headline])
REFERENCES [dbo].[company] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liprofile__id_ln__13A7DD28]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile] CHECK CONSTRAINT [FK__liprofile__id_ln__13A7DD28]
GO
/****** Object:  ForeignKey [FK__liprofile__id_ln__149C0161]    Script Date: 04/19/2022 15:19:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liprofile__id_ln__149C0161]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile]  WITH CHECK ADD  CONSTRAINT [FK__liprofile__id_ln__149C0161] FOREIGN KEY([id_company_from_title])
REFERENCES [dbo].[company] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liprofile__id_ln__149C0161]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile] CHECK CONSTRAINT [FK__liprofile__id_ln__149C0161]
GO
/****** Object:  ForeignKey [FK__liprofile__id_pe__2F4FF79D]    Script Date: 04/19/2022 15:19:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liprofile__id_pe__2F4FF79D]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile]  WITH CHECK ADD  CONSTRAINT [FK__liprofile__id_pe__2F4FF79D] FOREIGN KEY([id_person])
REFERENCES [dbo].[person] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liprofile__id_pe__2F4FF79D]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile] CHECK CONSTRAINT [FK__liprofile__id_pe__2F4FF79D]
GO
/****** Object:  ForeignKey [FK__profile__id_doma__4552473C]    Script Date: 04/19/2022 15:19:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__profile__id_doma__4552473C]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile]  WITH CHECK ADD  CONSTRAINT [FK__profile__id_doma__4552473C] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__profile__id_doma__4552473C]') AND parent_object_id = OBJECT_ID(N'[dbo].[profile]'))
ALTER TABLE [dbo].[profile] CHECK CONSTRAINT [FK__profile__id_doma__4552473C]
GO
/****** Object:  ForeignKey [FK__lisearchr__id_li__7B113988]    Script Date: 04/19/2022 15:19:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_li__7B113988]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result]  WITH NOCHECK ADD  CONSTRAINT [FK__lisearchr__id_li__7B113988] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_li__7B113988]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [FK__lisearchr__id_li__7B113988]
GO
/****** Object:  ForeignKey [FK__lisearchr__id_ln__2D128FEC]    Script Date: 04/19/2022 15:19:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_ln__2D128FEC]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result]  WITH NOCHECK ADD  CONSTRAINT [FK__lisearchr__id_ln__2D128FEC] FOREIGN KEY([id_lnsearchvariationblock])
REFERENCES [dbo].[lnsearchvariationblock] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_ln__2D128FEC]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [FK__lisearchr__id_ln__2D128FEC]
GO
/****** Object:  ForeignKey [FK__lisearchr__id_ln__3AC1AA49]    Script Date: 04/19/2022 15:19:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_ln__3AC1AA49]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result]  WITH NOCHECK ADD  CONSTRAINT [FK__lisearchr__id_ln__3AC1AA49] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_ln__3AC1AA49]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [FK__lisearchr__id_ln__3AC1AA49]
GO
/****** Object:  ForeignKey [FK__lisearchr__id_ln__7A1D154F]    Script Date: 04/19/2022 15:19:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_ln__7A1D154F]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result]  WITH NOCHECK ADD  CONSTRAINT [FK__lisearchr__id_ln__7A1D154F] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lisearchr__id_ln__7A1D154F]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [FK__lisearchr__id_ln__7A1D154F]
GO
/****** Object:  ForeignKey [FK__result__blast_id__2C2E559F]    Script Date: 04/19/2022 15:19:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__result__blast_id__2C2E559F]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result]  WITH CHECK ADD  CONSTRAINT [FK__result__blast_id__2C2E559F] FOREIGN KEY([blast_id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__result__blast_id__2C2E559F]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [FK__result__blast_id__2C2E559F]
GO
/****** Object:  ForeignKey [FK__result__crowdtru__33CF7767]    Script Date: 04/19/2022 15:19:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__result__crowdtru__33CF7767]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result]  WITH CHECK ADD  CONSTRAINT [FK__result__crowdtru__33CF7767] FOREIGN KEY([crowdtrust_id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__result__crowdtru__33CF7767]') AND parent_object_id = OBJECT_ID(N'[dbo].[result]'))
ALTER TABLE [dbo].[result] CHECK CONSTRAINT [FK__result__crowdtru__33CF7767]
GO
/****** Object:  ForeignKey [FK__lnchat__gct_id_u__51C9EEA2]    Script Date: 04/19/2022 15:20:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__gct_id_u__51C9EEA2]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat]  WITH CHECK ADD  CONSTRAINT [FK__lnchat__gct_id_u__51C9EEA2] FOREIGN KEY([gct_id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__gct_id_u__51C9EEA2]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat] CHECK CONSTRAINT [FK__lnchat__gct_id_u__51C9EEA2]
GO
/****** Object:  ForeignKey [FK__lnchat__id_lisea__0E875E2D]    Script Date: 04/19/2022 15:20:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_lisea__0E875E2D]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat]  WITH NOCHECK ADD  CONSTRAINT [FK__lnchat__id_lisea__0E875E2D] FOREIGN KEY([id_result])
REFERENCES [dbo].[result] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_lisea__0E875E2D]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat] CHECK CONSTRAINT [FK__lnchat__id_lisea__0E875E2D]
GO
/****** Object:  ForeignKey [FK__lnchat__id_lncha__1163CAD8]    Script Date: 04/19/2022 15:20:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_lncha__1163CAD8]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat]  WITH CHECK ADD  CONSTRAINT [FK__lnchat__id_lncha__1163CAD8] FOREIGN KEY([id_lnchat_previous])
REFERENCES [dbo].[lnchat] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_lncha__1163CAD8]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat] CHECK CONSTRAINT [FK__lnchat__id_lncha__1163CAD8]
GO
/****** Object:  ForeignKey [FK__lnchat__id_lnuse__0F7B8266]    Script Date: 04/19/2022 15:20:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_lnuse__0F7B8266]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat]  WITH CHECK ADD  CONSTRAINT [FK__lnchat__id_lnuse__0F7B8266] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_lnuse__0F7B8266]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat] CHECK CONSTRAINT [FK__lnchat__id_lnuse__0F7B8266]
GO
/****** Object:  ForeignKey [FK__lnchat__id_messa__106FA69F]    Script Date: 04/19/2022 15:20:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_messa__106FA69F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat]  WITH CHECK ADD  CONSTRAINT [FK__lnchat__id_messa__106FA69F] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_messa__106FA69F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat] CHECK CONSTRAINT [FK__lnchat__id_messa__106FA69F]
GO
/****** Object:  ForeignKey [FK__lnchat__id_user__321C391F]    Script Date: 04/19/2022 15:20:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_user__321C391F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat]  WITH CHECK ADD  CONSTRAINT [FK__lnchat__id_user__321C391F] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchat__id_user__321C391F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchat]'))
ALTER TABLE [dbo].[lnchat] CHECK CONSTRAINT [FK__lnchat__id_user__321C391F]
GO
/****** Object:  ForeignKey [FK__stat_drl___id_ln__780ACF11]    Script Date: 04/19/2022 15:21:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_drl___id_ln__780ACF11]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_responses]'))
ALTER TABLE [dbo].[stat_drl_shared_responses]  WITH CHECK ADD  CONSTRAINT [FK__stat_drl___id_ln__780ACF11] FOREIGN KEY([id_lnchat])
REFERENCES [dbo].[lnchat] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_drl___id_ln__780ACF11]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_responses]'))
ALTER TABLE [dbo].[stat_drl_shared_responses] CHECK CONSTRAINT [FK__stat_drl___id_ln__780ACF11]
GO
/****** Object:  ForeignKey [FK__stat_drl___id_me__7BDB5FF5]    Script Date: 04/19/2022 15:21:04 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_drl___id_me__7BDB5FF5]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_responses]'))
ALTER TABLE [dbo].[stat_drl_shared_responses]  WITH CHECK ADD  CONSTRAINT [FK__stat_drl___id_me__7BDB5FF5] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_drl___id_me__7BDB5FF5]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_drl_shared_responses]'))
ALTER TABLE [dbo].[stat_drl_shared_responses] CHECK CONSTRAINT [FK__stat_drl___id_me__7BDB5FF5]
GO
/****** Object:  ForeignKey [FK__lnchatope__id_ln__36E0EE3C]    Script Date: 04/19/2022 15:21:09 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchatope__id_ln__36E0EE3C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchatopen]'))
ALTER TABLE [dbo].[lnchatopen]  WITH CHECK ADD  CONSTRAINT [FK__lnchatope__id_ln__36E0EE3C] FOREIGN KEY([id_lnchat])
REFERENCES [dbo].[lnchat] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchatope__id_ln__36E0EE3C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchatopen]'))
ALTER TABLE [dbo].[lnchatopen] CHECK CONSTRAINT [FK__lnchatope__id_ln__36E0EE3C]
GO
/****** Object:  ForeignKey [FK__lnchatope__id_us__37D51275]    Script Date: 04/19/2022 15:21:09 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchatope__id_us__37D51275]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchatopen]'))
ALTER TABLE [dbo].[lnchatopen]  WITH CHECK ADD  CONSTRAINT [FK__lnchatope__id_us__37D51275] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnchatope__id_us__37D51275]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnchatopen]'))
ALTER TABLE [dbo].[lnchatopen] CHECK CONSTRAINT [FK__lnchatope__id_us__37D51275]
GO
/****** Object:  ForeignKey [FK__crmtaskco__id_cr__42875549]    Script Date: 04/19/2022 15:21:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtaskco__id_cr__42875549]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtaskcomment]'))
ALTER TABLE [dbo].[crmtaskcomment]  WITH CHECK ADD  CONSTRAINT [FK__crmtaskco__id_cr__42875549] FOREIGN KEY([id_crmtask])
REFERENCES [dbo].[crmtask] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtaskco__id_cr__42875549]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtaskcomment]'))
ALTER TABLE [dbo].[crmtaskcomment] CHECK CONSTRAINT [FK__crmtaskco__id_cr__42875549]
GO
/****** Object:  ForeignKey [FK__crmtaskco__id_us__437B7982]    Script Date: 04/19/2022 15:21:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtaskco__id_us__437B7982]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtaskcomment]'))
ALTER TABLE [dbo].[crmtaskcomment]  WITH CHECK ADD  CONSTRAINT [FK__crmtaskco__id_us__437B7982] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtaskco__id_us__437B7982]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtaskcomment]'))
ALTER TABLE [dbo].[crmtaskcomment] CHECK CONSTRAINT [FK__crmtaskco__id_us__437B7982]
GO
/****** Object:  ForeignKey [FK__crmlistfi__id_cr__278CDA2B]    Script Date: 04/19/2022 15:21:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlistfi__id_cr__278CDA2B]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlistfilejob]'))
ALTER TABLE [dbo].[crmlistfilejob]  WITH CHECK ADD  CONSTRAINT [FK__crmlistfi__id_cr__278CDA2B] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlistfi__id_cr__278CDA2B]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlistfilejob]'))
ALTER TABLE [dbo].[crmlistfilejob] CHECK CONSTRAINT [FK__crmlistfi__id_cr__278CDA2B]
GO
/****** Object:  ForeignKey [FK__crmlistfi__id_us__2698B5F2]    Script Date: 04/19/2022 15:21:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlistfi__id_us__2698B5F2]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlistfilejob]'))
ALTER TABLE [dbo].[crmlistfilejob]  WITH CHECK ADD  CONSTRAINT [FK__crmlistfi__id_us__2698B5F2] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlistfi__id_us__2698B5F2]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlistfilejob]'))
ALTER TABLE [dbo].[crmlistfilejob] CHECK CONSTRAINT [FK__crmlistfi__id_us__2698B5F2]
GO
/****** Object:  ForeignKey [FK__crmlist__id_user__25077354]    Script Date: 04/19/2022 15:21:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlist__id_user__25077354]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlist]'))
ALTER TABLE [dbo].[crmlist]  WITH CHECK ADD  CONSTRAINT [FK__crmlist__id_user__25077354] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlist__id_user__25077354]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlist]'))
ALTER TABLE [dbo].[crmlist] CHECK CONSTRAINT [FK__crmlist__id_user__25077354]
GO
/****** Object:  ForeignKey [FK__crmtask__id_crml__79B9C73B]    Script Date: 04/19/2022 15:21:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtask__id_crml__79B9C73B]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtask]'))
ALTER TABLE [dbo].[crmtask]  WITH CHECK ADD  CONSTRAINT [FK__crmtask__id_crml__79B9C73B] FOREIGN KEY([id_crmlead])
REFERENCES [dbo].[crmlead] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtask__id_crml__79B9C73B]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtask]'))
ALTER TABLE [dbo].[crmtask] CHECK CONSTRAINT [FK__crmtask__id_crml__79B9C73B]
GO
/****** Object:  ForeignKey [FK__crmtask__id_user__7AADEB74]    Script Date: 04/19/2022 15:21:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtask__id_user__7AADEB74]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtask]'))
ALTER TABLE [dbo].[crmtask]  WITH CHECK ADD  CONSTRAINT [FK__crmtask__id_user__7AADEB74] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmtask__id_user__7AADEB74]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmtask]'))
ALTER TABLE [dbo].[crmtask] CHECK CONSTRAINT [FK__crmtask__id_user__7AADEB74]
GO
/****** Object:  ForeignKey [FK__crmlead__id_crml__3BEAD8AC]    Script Date: 04/19/2022 15:21:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead__id_crml__3BEAD8AC]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead]'))
ALTER TABLE [dbo].[crmlead]  WITH CHECK ADD  CONSTRAINT [FK__crmlead__id_crml__3BEAD8AC] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead__id_crml__3BEAD8AC]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead]'))
ALTER TABLE [dbo].[crmlead] CHECK CONSTRAINT [FK__crmlead__id_crml__3BEAD8AC]
GO
/****** Object:  ForeignKey [FK__crmlead__id_user__3CDEFCE5]    Script Date: 04/19/2022 15:21:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead__id_user__3CDEFCE5]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead]'))
ALTER TABLE [dbo].[crmlead]  WITH CHECK ADD  CONSTRAINT [FK__crmlead__id_user__3CDEFCE5] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead__id_user__3CDEFCE5]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead]'))
ALTER TABLE [dbo].[crmlead] CHECK CONSTRAINT [FK__crmlead__id_user__3CDEFCE5]
GO
/****** Object:  ForeignKey [FK__crmdata__id_crml__41A3B202]    Script Date: 04/19/2022 15:21:52 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmdata__id_crml__41A3B202]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmdata]'))
ALTER TABLE [dbo].[crmdata]  WITH CHECK ADD  CONSTRAINT [FK__crmdata__id_crml__41A3B202] FOREIGN KEY([id_crmlead])
REFERENCES [dbo].[crmlead] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmdata__id_crml__41A3B202]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmdata]'))
ALTER TABLE [dbo].[crmdata] CHECK CONSTRAINT [FK__crmdata__id_crml__41A3B202]
GO
/****** Object:  ForeignKey [FK__crmdata__id_user__4297D63B]    Script Date: 04/19/2022 15:21:52 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmdata__id_user__4297D63B]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmdata]'))
ALTER TABLE [dbo].[crmdata]  WITH CHECK ADD  CONSTRAINT [FK__crmdata__id_user__4297D63B] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmdata__id_user__4297D63B]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmdata]'))
ALTER TABLE [dbo].[crmdata] CHECK CONSTRAINT [FK__crmdata__id_user__4297D63B]
GO
/****** Object:  ForeignKey [FK__crmlead_c__id_cr__4872E2E7]    Script Date: 04/19/2022 15:21:56 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead_c__id_cr__4872E2E7]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead_crmaccount]'))
ALTER TABLE [dbo].[crmlead_crmaccount]  WITH CHECK ADD  CONSTRAINT [FK__crmlead_c__id_cr__4872E2E7] FOREIGN KEY([id_crmlead])
REFERENCES [dbo].[crmlead] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead_c__id_cr__4872E2E7]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead_crmaccount]'))
ALTER TABLE [dbo].[crmlead_crmaccount] CHECK CONSTRAINT [FK__crmlead_c__id_cr__4872E2E7]
GO
/****** Object:  ForeignKey [FK__crmlead_c__id_cr__49670720]    Script Date: 04/19/2022 15:21:56 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead_c__id_cr__49670720]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead_crmaccount]'))
ALTER TABLE [dbo].[crmlead_crmaccount]  WITH CHECK ADD  CONSTRAINT [FK__crmlead_c__id_cr__49670720] FOREIGN KEY([id_crmaccount])
REFERENCES [dbo].[crmaccount] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmlead_c__id_cr__49670720]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmlead_crmaccount]'))
ALTER TABLE [dbo].[crmlead_crmaccount] CHECK CONSTRAINT [FK__crmlead_c__id_cr__49670720]
GO
/****** Object:  ForeignKey [FK__crmaccoun__id_cr__1F2C9E54]    Script Date: 04/19/2022 15:22:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmaccoun__id_cr__1F2C9E54]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmaccountdata]'))
ALTER TABLE [dbo].[crmaccountdata]  WITH CHECK ADD  CONSTRAINT [FK__crmaccoun__id_cr__1F2C9E54] FOREIGN KEY([id_crmaccount])
REFERENCES [dbo].[crmaccount] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmaccoun__id_cr__1F2C9E54]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmaccountdata]'))
ALTER TABLE [dbo].[crmaccountdata] CHECK CONSTRAINT [FK__crmaccoun__id_cr__1F2C9E54]
GO
/****** Object:  ForeignKey [FK__crmaccoun__id_us__42BA0991]    Script Date: 04/19/2022 15:22:13 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmaccoun__id_us__42BA0991]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmaccount]'))
ALTER TABLE [dbo].[crmaccount]  WITH CHECK ADD  CONSTRAINT [FK__crmaccoun__id_us__42BA0991] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__crmaccoun__id_us__42BA0991]') AND parent_object_id = OBJECT_ID(N'[dbo].[crmaccount]'))
ALTER TABLE [dbo].[crmaccount] CHECK CONSTRAINT [FK__crmaccoun__id_us__42BA0991]
GO
/****** Object:  ForeignKey [FK__cosmos_sh__id_pr__3D03DBE6]    Script Date: 04/19/2022 15:22:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_sh__id_pr__3D03DBE6]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_sharing]'))
ALTER TABLE [dbo].[cosmos_sharing]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_sh__id_pr__3D03DBE6] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_sh__id_pr__3D03DBE6]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_sharing]'))
ALTER TABLE [dbo].[cosmos_sharing] CHECK CONSTRAINT [FK__cosmos_sh__id_pr__3D03DBE6]
GO
/****** Object:  ForeignKey [FK__cosmos_sh__id_se__3DF8001F]    Script Date: 04/19/2022 15:22:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_sh__id_se__3DF8001F]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_sharing]'))
ALTER TABLE [dbo].[cosmos_sharing]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_sh__id_se__3DF8001F] FOREIGN KEY([id_service])
REFERENCES [dbo].[cosmos_service] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_sh__id_se__3DF8001F]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_sharing]'))
ALTER TABLE [dbo].[cosmos_sharing] CHECK CONSTRAINT [FK__cosmos_sh__id_se__3DF8001F]
GO
/****** Object:  ForeignKey [FK__cosmos_sh__id_us__3C0FB7AD]    Script Date: 04/19/2022 15:22:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_sh__id_us__3C0FB7AD]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_sharing]'))
ALTER TABLE [dbo].[cosmos_sharing]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_sh__id_us__3C0FB7AD] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_sh__id_us__3C0FB7AD]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_sharing]'))
ALTER TABLE [dbo].[cosmos_sharing] CHECK CONSTRAINT [FK__cosmos_sh__id_us__3C0FB7AD]
GO
/****** Object:  ForeignKey [FK__cosmos_se__id_us__374B0290]    Script Date: 04/19/2022 15:22:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_se__id_us__374B0290]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_service]'))
ALTER TABLE [dbo].[cosmos_service]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_se__id_us__374B0290] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_se__id_us__374B0290]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_service]'))
ALTER TABLE [dbo].[cosmos_service] CHECK CONSTRAINT [FK__cosmos_se__id_us__374B0290]
GO
/****** Object:  ForeignKey [FK__cosmos_pr__id_pr__32864D73]    Script Date: 04/19/2022 15:22:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_pr__id_pr__32864D73]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_proxy_uptime]'))
ALTER TABLE [dbo].[cosmos_proxy_uptime]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_pr__id_pr__32864D73] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_pr__id_pr__32864D73]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_proxy_uptime]'))
ALTER TABLE [dbo].[cosmos_proxy_uptime] CHECK CONSTRAINT [FK__cosmos_pr__id_pr__32864D73]
GO
/****** Object:  ForeignKey [FK__cosmos_cr__id_cr__48758E92]    Script Date: 04/19/2022 15:22:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_cr__48758E92]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential_service]'))
ALTER TABLE [dbo].[cosmos_credential_service]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_cr__id_cr__48758E92] FOREIGN KEY([id_credential])
REFERENCES [dbo].[cosmos_credential] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_cr__48758E92]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential_service]'))
ALTER TABLE [dbo].[cosmos_credential_service] CHECK CONSTRAINT [FK__cosmos_cr__id_cr__48758E92]
GO
/****** Object:  ForeignKey [FK__cosmos_cr__id_se__4969B2CB]    Script Date: 04/19/2022 15:22:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_se__4969B2CB]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential_service]'))
ALTER TABLE [dbo].[cosmos_credential_service]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_cr__id_se__4969B2CB] FOREIGN KEY([id_service])
REFERENCES [dbo].[cosmos_service] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_se__4969B2CB]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential_service]'))
ALTER TABLE [dbo].[cosmos_credential_service] CHECK CONSTRAINT [FK__cosmos_cr__id_se__4969B2CB]
GO
/****** Object:  ForeignKey [FK__signal__id_conne__6625ED0A]    Script Date: 04/19/2022 15:22:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signal__id_conne__6625ED0A]') AND parent_object_id = OBJECT_ID(N'[dbo].[signal]'))
ALTER TABLE [dbo].[signal]  WITH CHECK ADD  CONSTRAINT [FK__signal__id_conne__6625ED0A] FOREIGN KEY([id_connection_request_to_user])
REFERENCES [dbo].[connection_request_to_user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signal__id_conne__6625ED0A]') AND parent_object_id = OBJECT_ID(N'[dbo].[signal]'))
ALTER TABLE [dbo].[signal] CHECK CONSTRAINT [FK__signal__id_conne__6625ED0A]
GO
/****** Object:  ForeignKey [FK__signal__id_lnuse__39534693]    Script Date: 04/19/2022 15:22:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signal__id_lnuse__39534693]') AND parent_object_id = OBJECT_ID(N'[dbo].[signal]'))
ALTER TABLE [dbo].[signal]  WITH CHECK ADD  CONSTRAINT [FK__signal__id_lnuse__39534693] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signal__id_lnuse__39534693]') AND parent_object_id = OBJECT_ID(N'[dbo].[signal]'))
ALTER TABLE [dbo].[signal] CHECK CONSTRAINT [FK__signal__id_lnuse__39534693]
GO
/****** Object:  ForeignKey [FK__signal__id_resul__3A476ACC]    Script Date: 04/19/2022 15:22:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signal__id_resul__3A476ACC]') AND parent_object_id = OBJECT_ID(N'[dbo].[signal]'))
ALTER TABLE [dbo].[signal]  WITH CHECK ADD  CONSTRAINT [FK__signal__id_resul__3A476ACC] FOREIGN KEY([id_result])
REFERENCES [dbo].[result] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__signal__id_resul__3A476ACC]') AND parent_object_id = OBJECT_ID(N'[dbo].[signal]'))
ALTER TABLE [dbo].[signal] CHECK CONSTRAINT [FK__signal__id_resul__3A476ACC]
GO
/****** Object:  ForeignKey [FK__connectio__id_ln__4EED81F7]    Script Date: 04/19/2022 15:22:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__connectio__id_ln__4EED81F7]') AND parent_object_id = OBJECT_ID(N'[dbo].[connection_request_to_user]'))
ALTER TABLE [dbo].[connection_request_to_user]  WITH CHECK ADD  CONSTRAINT [FK__connectio__id_ln__4EED81F7] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__connectio__id_ln__4EED81F7]') AND parent_object_id = OBJECT_ID(N'[dbo].[connection_request_to_user]'))
ALTER TABLE [dbo].[connection_request_to_user] CHECK CONSTRAINT [FK__connectio__id_ln__4EED81F7]
GO
/****** Object:  ForeignKey [FK__connectio__id_us__4FE1A630]    Script Date: 04/19/2022 15:22:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__connectio__id_us__4FE1A630]') AND parent_object_id = OBJECT_ID(N'[dbo].[connection_request_to_user]'))
ALTER TABLE [dbo].[connection_request_to_user]  WITH CHECK ADD  CONSTRAINT [FK__connectio__id_us__4FE1A630] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__connectio__id_us__4FE1A630]') AND parent_object_id = OBJECT_ID(N'[dbo].[connection_request_to_user]'))
ALTER TABLE [dbo].[connection_request_to_user] CHECK CONSTRAINT [FK__connectio__id_us__4FE1A630]
GO
/****** Object:  ForeignKey [FK__browserac__id_ln__05544DD6]    Script Date: 04/19/2022 15:23:10 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_ln__05544DD6]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity]  WITH CHECK ADD  CONSTRAINT [FK__browserac__id_ln__05544DD6] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_ln__05544DD6]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity] CHECK CONSTRAINT [FK__browserac__id_ln__05544DD6]
GO
/****** Object:  ForeignKey [FK__browserac__id_pr__0460299D]    Script Date: 04/19/2022 15:23:10 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__0460299D]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity]  WITH CHECK ADD  CONSTRAINT [FK__browserac__id_pr__0460299D] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__0460299D]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity] CHECK CONSTRAINT [FK__browserac__id_pr__0460299D]
GO
/****** Object:  ForeignKey [FK__browserac__id_pr__0648720F]    Script Date: 04/19/2022 15:23:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__0648720F]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity]  WITH CHECK ADD  CONSTRAINT [FK__browserac__id_pr__0648720F] FOREIGN KEY([id_previous_activity_of_same_proxy])
REFERENCES [dbo].[browseractivity] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__0648720F]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity] CHECK CONSTRAINT [FK__browserac__id_pr__0648720F]
GO
/****** Object:  ForeignKey [FK__browserac__id_pr__073C9648]    Script Date: 04/19/2022 15:23:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__073C9648]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity]  WITH CHECK ADD  CONSTRAINT [FK__browserac__id_pr__073C9648] FOREIGN KEY([id_previous_activity_of_same_lnuser])
REFERENCES [dbo].[browseractivity] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__073C9648]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity] CHECK CONSTRAINT [FK__browserac__id_pr__073C9648]
GO
/****** Object:  ForeignKey [FK__browserac__id_pr__0830BA81]    Script Date: 04/19/2022 15:23:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__0830BA81]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity]  WITH CHECK ADD  CONSTRAINT [FK__browserac__id_pr__0830BA81] FOREIGN KEY([id_previous_activity_of_same_worker])
REFERENCES [dbo].[browseractivity] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_pr__0830BA81]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity] CHECK CONSTRAINT [FK__browserac__id_pr__0830BA81]
GO
/****** Object:  ForeignKey [FK__browserac__id_wo__036C0564]    Script Date: 04/19/2022 15:23:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_wo__036C0564]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity]  WITH CHECK ADD  CONSTRAINT [FK__browserac__id_wo__036C0564] FOREIGN KEY([id_worker])
REFERENCES [dbo].[worker] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_wo__036C0564]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity] CHECK CONSTRAINT [FK__browserac__id_wo__036C0564]
GO
/****** Object:  ForeignKey [FK__browserac__id_wo__6BF3D4F9]    Script Date: 04/19/2022 15:23:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_wo__6BF3D4F9]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity]  WITH CHECK ADD  CONSTRAINT [FK__browserac__id_wo__6BF3D4F9] FOREIGN KEY([id_workerjob])
REFERENCES [dbo].[workerjob] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__browserac__id_wo__6BF3D4F9]') AND parent_object_id = OBJECT_ID(N'[dbo].[browseractivity]'))
ALTER TABLE [dbo].[browseractivity] CHECK CONSTRAINT [FK__browserac__id_wo__6BF3D4F9]
GO
/****** Object:  ForeignKey [FK__boterrorl__id_ln__34DA0F1D]    Script Date: 04/19/2022 15:23:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__boterrorl__id_ln__34DA0F1D]') AND parent_object_id = OBJECT_ID(N'[dbo].[boterrorlog]'))
ALTER TABLE [dbo].[boterrorlog]  WITH CHECK ADD  CONSTRAINT [FK__boterrorl__id_ln__34DA0F1D] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__boterrorl__id_ln__34DA0F1D]') AND parent_object_id = OBJECT_ID(N'[dbo].[boterrorlog]'))
ALTER TABLE [dbo].[boterrorlog] CHECK CONSTRAINT [FK__boterrorl__id_ln__34DA0F1D]
GO
/****** Object:  ForeignKey [FK__boterrorl__id_wo__35CE3356]    Script Date: 04/19/2022 15:23:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__boterrorl__id_wo__35CE3356]') AND parent_object_id = OBJECT_ID(N'[dbo].[boterrorlog]'))
ALTER TABLE [dbo].[boterrorlog]  WITH CHECK ADD  CONSTRAINT [FK__boterrorl__id_wo__35CE3356] FOREIGN KEY([id_worker])
REFERENCES [dbo].[worker] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__boterrorl__id_wo__35CE3356]') AND parent_object_id = OBJECT_ID(N'[dbo].[boterrorlog]'))
ALTER TABLE [dbo].[boterrorlog] CHECK CONSTRAINT [FK__boterrorl__id_wo__35CE3356]
GO
/****** Object:  ForeignKey [FK__blending___id_bl__6E662D50]    Script Date: 04/19/2022 15:23:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_bl__6E662D50]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_task_parameter]'))
ALTER TABLE [dbo].[blending_task_parameter]  WITH CHECK ADD  CONSTRAINT [FK__blending___id_bl__6E662D50] FOREIGN KEY([id_blending_task])
REFERENCES [dbo].[blending_task] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_bl__6E662D50]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_task_parameter]'))
ALTER TABLE [dbo].[blending_task_parameter] CHECK CONSTRAINT [FK__blending___id_bl__6E662D50]
GO
/****** Object:  ForeignKey [FK__blending___id_ln__6F5A5189]    Script Date: 04/19/2022 15:23:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_ln__6F5A5189]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_task_parameter]'))
ALTER TABLE [dbo].[blending_task_parameter]  WITH CHECK ADD  CONSTRAINT [FK__blending___id_ln__6F5A5189] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_ln__6F5A5189]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_task_parameter]'))
ALTER TABLE [dbo].[blending_task_parameter] CHECK CONSTRAINT [FK__blending___id_ln__6F5A5189]
GO
/****** Object:  ForeignKey [FK__blending___id_ln__5B5358DC]    Script Date: 04/19/2022 15:23:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_ln__5B5358DC]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_task]'))
ALTER TABLE [dbo].[blending_task]  WITH CHECK ADD  CONSTRAINT [FK__blending___id_ln__5B5358DC] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_ln__5B5358DC]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_task]'))
ALTER TABLE [dbo].[blending_task] CHECK CONSTRAINT [FK__blending___id_ln__5B5358DC]
GO
/****** Object:  ForeignKey [FK__blending___id_ln__568EA3BF]    Script Date: 04/19/2022 15:23:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_ln__568EA3BF]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_cookie]'))
ALTER TABLE [dbo].[blending_cookie]  WITH CHECK ADD  CONSTRAINT [FK__blending___id_ln__568EA3BF] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__blending___id_ln__568EA3BF]') AND parent_object_id = OBJECT_ID(N'[dbo].[blending_cookie]'))
ALTER TABLE [dbo].[blending_cookie] CHECK CONSTRAINT [FK__blending___id_ln__568EA3BF]
GO
/****** Object:  ForeignKey [FK__profilejo__id_co__43B11BFB]    Script Date: 04/19/2022 15:23:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__profilejo__id_co__43B11BFB]') AND parent_object_id = OBJECT_ID(N'[dbo].[profilejob]'))
ALTER TABLE [dbo].[profilejob]  WITH CHECK ADD  CONSTRAINT [FK__profilejo__id_co__43B11BFB] FOREIGN KEY([id_company])
REFERENCES [dbo].[company] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__profilejo__id_co__43B11BFB]') AND parent_object_id = OBJECT_ID(N'[dbo].[profilejob]'))
ALTER TABLE [dbo].[profilejob] CHECK CONSTRAINT [FK__profilejo__id_co__43B11BFB]
GO
/****** Object:  ForeignKey [FK__profilejo__id_pr__42BCF7C2]    Script Date: 04/19/2022 15:23:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__profilejo__id_pr__42BCF7C2]') AND parent_object_id = OBJECT_ID(N'[dbo].[profilejob]'))
ALTER TABLE [dbo].[profilejob]  WITH CHECK ADD  CONSTRAINT [FK__profilejo__id_pr__42BCF7C2] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__profilejo__id_pr__42BCF7C2]') AND parent_object_id = OBJECT_ID(N'[dbo].[profilejob]'))
ALTER TABLE [dbo].[profilejob] CHECK CONSTRAINT [FK__profilejo__id_pr__42BCF7C2]
GO
/****** Object:  ForeignKey [FK__workerjob__id_cl__794DD017]    Script Date: 04/19/2022 15:23:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_cl__794DD017]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob]  WITH CHECK ADD  CONSTRAINT [FK__workerjob__id_cl__794DD017] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_cl__794DD017]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob] CHECK CONSTRAINT [FK__workerjob__id_cl__794DD017]
GO
/****** Object:  ForeignKey [FK__workerjob__id_ln__6A0B8C87]    Script Date: 04/19/2022 15:23:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_ln__6A0B8C87]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob]  WITH CHECK ADD  CONSTRAINT [FK__workerjob__id_ln__6A0B8C87] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_ln__6A0B8C87]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob] CHECK CONSTRAINT [FK__workerjob__id_ln__6A0B8C87]
GO
/****** Object:  ForeignKey [FK__workerjob__id_pr__6917684E]    Script Date: 04/19/2022 15:23:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_pr__6917684E]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob]  WITH CHECK ADD  CONSTRAINT [FK__workerjob__id_pr__6917684E] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_pr__6917684E]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob] CHECK CONSTRAINT [FK__workerjob__id_pr__6917684E]
GO
/****** Object:  ForeignKey [FK__workerjob__id_wo__68234415]    Script Date: 04/19/2022 15:23:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_wo__68234415]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob]  WITH CHECK ADD  CONSTRAINT [FK__workerjob__id_wo__68234415] FOREIGN KEY([id_worker])
REFERENCES [dbo].[worker] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__workerjob__id_wo__68234415]') AND parent_object_id = OBJECT_ID(N'[dbo].[workerjob]'))
ALTER TABLE [dbo].[workerjob] CHECK CONSTRAINT [FK__workerjob__id_wo__68234415]
GO
/****** Object:  ForeignKey [FK__stat_bala__id_cl__77307D7B]    Script Date: 04/19/2022 15:24:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_bala__id_cl__77307D7B]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_balance]'))
ALTER TABLE [dbo].[stat_balance]  WITH CHECK ADD  CONSTRAINT [FK__stat_bala__id_cl__77307D7B] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_bala__id_cl__77307D7B]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_balance]'))
ALTER TABLE [dbo].[stat_balance] CHECK CONSTRAINT [FK__stat_bala__id_cl__77307D7B]
GO
/****** Object:  ForeignKey [FK__mimic_pro__id_cl__126E839C]    Script Date: 04/19/2022 15:24:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_cl__126E839C]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile_history]'))
ALTER TABLE [dbo].[mimic_profile_history]  WITH CHECK ADD  CONSTRAINT [FK__mimic_pro__id_cl__126E839C] FOREIGN KEY([id_client_allocated])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_cl__126E839C]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile_history]'))
ALTER TABLE [dbo].[mimic_profile_history] CHECK CONSTRAINT [FK__mimic_pro__id_cl__126E839C]
GO
/****** Object:  ForeignKey [FK__mimic_pro__id_pr__1362A7D5]    Script Date: 04/19/2022 15:24:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_pr__1362A7D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile_history]'))
ALTER TABLE [dbo].[mimic_profile_history]  WITH CHECK ADD  CONSTRAINT [FK__mimic_pro__id_pr__1362A7D5] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_pr__1362A7D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile_history]'))
ALTER TABLE [dbo].[mimic_profile_history] CHECK CONSTRAINT [FK__mimic_pro__id_pr__1362A7D5]
GO
/****** Object:  ForeignKey [FK__mimic_pro__id_cl__0CB5AA46]    Script Date: 04/19/2022 15:24:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_cl__0CB5AA46]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile]'))
ALTER TABLE [dbo].[mimic_profile]  WITH CHECK ADD  CONSTRAINT [FK__mimic_pro__id_cl__0CB5AA46] FOREIGN KEY([id_client_allocated])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_cl__0CB5AA46]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile]'))
ALTER TABLE [dbo].[mimic_profile] CHECK CONSTRAINT [FK__mimic_pro__id_cl__0CB5AA46]
GO
/****** Object:  ForeignKey [FK__mimic_pro__id_ln__6CC8F693]    Script Date: 04/19/2022 15:24:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_ln__6CC8F693]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile]'))
ALTER TABLE [dbo].[mimic_profile]  WITH CHECK ADD  CONSTRAINT [FK__mimic_pro__id_ln__6CC8F693] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_ln__6CC8F693]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile]'))
ALTER TABLE [dbo].[mimic_profile] CHECK CONSTRAINT [FK__mimic_pro__id_ln__6CC8F693]
GO
/****** Object:  ForeignKey [FK__mimic_pro__id_pr__0DA9CE7F]    Script Date: 04/19/2022 15:24:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_pr__0DA9CE7F]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile]'))
ALTER TABLE [dbo].[mimic_profile]  WITH CHECK ADD  CONSTRAINT [FK__mimic_pro__id_pr__0DA9CE7F] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__mimic_pro__id_pr__0DA9CE7F]') AND parent_object_id = OBJECT_ID(N'[dbo].[mimic_profile]'))
ALTER TABLE [dbo].[mimic_profile] CHECK CONSTRAINT [FK__mimic_pro__id_pr__0DA9CE7F]
GO
/****** Object:  ForeignKey [FK__custom_pl__id_cl__7986D723]    Script Date: 04/19/2022 15:24:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__custom_pl__id_cl__7986D723]') AND parent_object_id = OBJECT_ID(N'[dbo].[custom_plan]'))
ALTER TABLE [dbo].[custom_plan]  WITH CHECK ADD  CONSTRAINT [FK__custom_pl__id_cl__7986D723] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__custom_pl__id_cl__7986D723]') AND parent_object_id = OBJECT_ID(N'[dbo].[custom_plan]'))
ALTER TABLE [dbo].[custom_plan] CHECK CONSTRAINT [FK__custom_pl__id_cl__7986D723]
GO
/****** Object:  ForeignKey [FK__cosmos_cr__id_cl__43B0D975]    Script Date: 04/19/2022 15:24:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_cl__43B0D975]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential]'))
ALTER TABLE [dbo].[cosmos_credential]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_cr__id_cl__43B0D975] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_cl__43B0D975]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential]'))
ALTER TABLE [dbo].[cosmos_credential] CHECK CONSTRAINT [FK__cosmos_cr__id_cl__43B0D975]
GO
/****** Object:  ForeignKey [FK__cosmos_cr__id_pr__42BCB53C]    Script Date: 04/19/2022 15:24:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_pr__42BCB53C]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential]'))
ALTER TABLE [dbo].[cosmos_credential]  WITH CHECK ADD  CONSTRAINT [FK__cosmos_cr__id_pr__42BCB53C] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__cosmos_cr__id_pr__42BCB53C]') AND parent_object_id = OBJECT_ID(N'[dbo].[cosmos_credential]'))
ALTER TABLE [dbo].[cosmos_credential] CHECK CONSTRAINT [FK__cosmos_cr__id_pr__42BCB53C]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_ln__3AAE944A]    Script Date: 04/19/2022 15:25:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__3AAE944A]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_ln__3AAE944A] FOREIGN KEY([id_lncountry])
REFERENCES [dbo].[lncountry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__3AAE944A]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate] CHECK CONSTRAINT [FK__lnusertem__id_ln__3AAE944A]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_ln__3BA2B883]    Script Date: 04/19/2022 15:25:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__3BA2B883]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_ln__3BA2B883] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__3BA2B883]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate] CHECK CONSTRAINT [FK__lnusertem__id_ln__3BA2B883]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_te__2AB02181]    Script Date: 04/19/2022 15:25:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_te__2AB02181]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_te__2AB02181] FOREIGN KEY([id_template_headline])
REFERENCES [dbo].[template] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_te__2AB02181]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate] CHECK CONSTRAINT [FK__lnusertem__id_te__2AB02181]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_te__2BA445BA]    Script Date: 04/19/2022 15:25:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_te__2BA445BA]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_te__2BA445BA] FOREIGN KEY([id_template_summary])
REFERENCES [dbo].[template] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_te__2BA445BA]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate] CHECK CONSTRAINT [FK__lnusertem__id_te__2BA445BA]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_us__39BA7011]    Script Date: 04/19/2022 15:25:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_us__39BA7011]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_us__39BA7011] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_us__39BA7011]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplate]'))
ALTER TABLE [dbo].[lnusertemplate] CHECK CONSTRAINT [FK__lnusertem__id_us__39BA7011]
GO
/****** Object:  ForeignKey [FK__campaign__id_lng__436BFEE3]    Script Date: 04/19/2022 15:26:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__campaign__id_lng__436BFEE3]') AND parent_object_id = OBJECT_ID(N'[dbo].[campaign]'))
ALTER TABLE [dbo].[campaign]  WITH CHECK ADD  CONSTRAINT [FK__campaign__id_lng__436BFEE3] FOREIGN KEY([id_lngroup])
REFERENCES [dbo].[lngroup] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__campaign__id_lng__436BFEE3]') AND parent_object_id = OBJECT_ID(N'[dbo].[campaign]'))
ALTER TABLE [dbo].[campaign] CHECK CONSTRAINT [FK__campaign__id_lng__436BFEE3]
GO
/****** Object:  ForeignKey [FK__campaign__id_use__11D4A34F]    Script Date: 04/19/2022 15:26:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__campaign__id_use__11D4A34F]') AND parent_object_id = OBJECT_ID(N'[dbo].[campaign]'))
ALTER TABLE [dbo].[campaign]  WITH CHECK ADD  CONSTRAINT [FK__campaign__id_use__11D4A34F] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__campaign__id_use__11D4A34F]') AND parent_object_id = OBJECT_ID(N'[dbo].[campaign]'))
ALTER TABLE [dbo].[campaign] CHECK CONSTRAINT [FK__campaign__id_use__11D4A34F]
GO
/****** Object:  ForeignKey [FK__emserver__id_use__62CF9BA3]    Script Date: 04/19/2022 15:26:56 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emserver__id_use__62CF9BA3]') AND parent_object_id = OBJECT_ID(N'[dbo].[emserver]'))
ALTER TABLE [dbo].[emserver]  WITH CHECK ADD  CONSTRAINT [FK__emserver__id_use__62CF9BA3] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emserver__id_use__62CF9BA3]') AND parent_object_id = OBJECT_ID(N'[dbo].[emserver]'))
ALTER TABLE [dbo].[emserver] CHECK CONSTRAINT [FK__emserver__id_use__62CF9BA3]
GO
/****** Object:  ForeignKey [FK__emlist__id_user__1BE81D6E]    Script Date: 04/19/2022 15:27:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emlist__id_user__1BE81D6E]') AND parent_object_id = OBJECT_ID(N'[dbo].[emlist]'))
ALTER TABLE [dbo].[emlist]  WITH CHECK ADD  CONSTRAINT [FK__emlist__id_user__1BE81D6E] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emlist__id_user__1BE81D6E]') AND parent_object_id = OBJECT_ID(N'[dbo].[emlist]'))
ALTER TABLE [dbo].[emlist] CHECK CONSTRAINT [FK__emlist__id_user__1BE81D6E]
GO
/****** Object:  ForeignKey [FK__lnsearcha__id_cr__0DB9F9A8]    Script Date: 04/19/2022 15:27:31 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearcha__id_cr__0DB9F9A8]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchallocationjob]'))
ALTER TABLE [dbo].[searchallocationjob]  WITH CHECK ADD  CONSTRAINT [FK__lnsearcha__id_cr__0DB9F9A8] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearcha__id_cr__0DB9F9A8]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchallocationjob]'))
ALTER TABLE [dbo].[searchallocationjob] CHECK CONSTRAINT [FK__lnsearcha__id_cr__0DB9F9A8]
GO
/****** Object:  ForeignKey [FK__lnsearcha__id_em__0CC5D56F]    Script Date: 04/19/2022 15:27:31 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearcha__id_em__0CC5D56F]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchallocationjob]'))
ALTER TABLE [dbo].[searchallocationjob]  WITH CHECK ADD  CONSTRAINT [FK__lnsearcha__id_em__0CC5D56F] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearcha__id_em__0CC5D56F]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchallocationjob]'))
ALTER TABLE [dbo].[searchallocationjob] CHECK CONSTRAINT [FK__lnsearcha__id_em__0CC5D56F]
GO
/****** Object:  ForeignKey [FK__lnsearcha__id_ln__0BD1B136]    Script Date: 04/19/2022 15:27:31 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearcha__id_ln__0BD1B136]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchallocationjob]'))
ALTER TABLE [dbo].[searchallocationjob]  WITH CHECK ADD  CONSTRAINT [FK__lnsearcha__id_ln__0BD1B136] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearcha__id_ln__0BD1B136]') AND parent_object_id = OBJECT_ID(N'[dbo].[searchallocationjob]'))
ALTER TABLE [dbo].[searchallocationjob] CHECK CONSTRAINT [FK__lnsearcha__id_ln__0BD1B136]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_cr__7B315CDD]    Script Date: 04/19/2022 15:27:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_cr__7B315CDD]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_cr__7B315CDD] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_cr__7B315CDD]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance] CHECK CONSTRAINT [FK__on_wlt_fr__id_cr__7B315CDD]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_em__7949146B]    Script Date: 04/19/2022 15:27:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_em__7949146B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_em__7949146B] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_em__7949146B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance] CHECK CONSTRAINT [FK__on_wlt_fr__id_em__7949146B]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_ln__7854F032]    Script Date: 04/19/2022 15:27:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_ln__7854F032]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_ln__7854F032] FOREIGN KEY([id_lnchat])
REFERENCES [dbo].[lnchat] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_ln__7854F032]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance] CHECK CONSTRAINT [FK__on_wlt_fr__id_ln__7854F032]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_on__7760CBF9]    Script Date: 04/19/2022 15:27:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_on__7760CBF9]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_on__7760CBF9] FOREIGN KEY([id_on_wlt_from_message_action])
REFERENCES [dbo].[on_wlt_from_message_action] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_on__7760CBF9]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance] CHECK CONSTRAINT [FK__on_wlt_fr__id_on__7760CBF9]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_se__7A3D38A4]    Script Date: 04/19/2022 15:27:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_se__7A3D38A4]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_se__7A3D38A4] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_se__7A3D38A4]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action_instance]'))
ALTER TABLE [dbo].[on_wlt_from_message_action_instance] CHECK CONSTRAINT [FK__on_wlt_fr__id_se__7A3D38A4]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_cr__729C16DC]    Script Date: 04/19/2022 15:27:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_cr__729C16DC]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_cr__729C16DC] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_cr__729C16DC]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action] CHECK CONSTRAINT [FK__on_wlt_fr__id_cr__729C16DC]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_em__70B3CE6A]    Script Date: 04/19/2022 15:27:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_em__70B3CE6A]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_em__70B3CE6A] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_em__70B3CE6A]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action] CHECK CONSTRAINT [FK__on_wlt_fr__id_em__70B3CE6A]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_pi__6FBFAA31]    Script Date: 04/19/2022 15:27:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_pi__6FBFAA31]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_pi__6FBFAA31] FOREIGN KEY([id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_pi__6FBFAA31]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action] CHECK CONSTRAINT [FK__on_wlt_fr__id_pi__6FBFAA31]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_se__71A7F2A3]    Script Date: 04/19/2022 15:27:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_se__71A7F2A3]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_se__71A7F2A3] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_se__71A7F2A3]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action] CHECK CONSTRAINT [FK__on_wlt_fr__id_se__71A7F2A3]
GO
/****** Object:  ForeignKey [FK__on_wlt_fr__id_us__6ECB85F8]    Script Date: 04/19/2022 15:27:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_us__6ECB85F8]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_wlt_fr__id_us__6ECB85F8] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_wlt_fr__id_us__6ECB85F8]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_wlt_from_message_action]'))
ALTER TABLE [dbo].[on_wlt_from_message_action] CHECK CONSTRAINT [FK__on_wlt_fr__id_us__6ECB85F8]
GO
/****** Object:  ForeignKey [FK__on_messag__id_cr__0ED0120C]    Script Date: 04/19/2022 15:27:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_cr__0ED0120C]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_cr__0ED0120C] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_cr__0ED0120C]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance] CHECK CONSTRAINT [FK__on_messag__id_cr__0ED0120C]
GO
/****** Object:  ForeignKey [FK__on_messag__id_em__0CE7C99A]    Script Date: 04/19/2022 15:27:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_em__0CE7C99A]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_em__0CE7C99A] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_em__0CE7C99A]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance] CHECK CONSTRAINT [FK__on_messag__id_em__0CE7C99A]
GO
/****** Object:  ForeignKey [FK__on_messag__id_ln__0BF3A561]    Script Date: 04/19/2022 15:27:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_ln__0BF3A561]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_ln__0BF3A561] FOREIGN KEY([id_lnchat])
REFERENCES [dbo].[lnchat] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_ln__0BF3A561]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance] CHECK CONSTRAINT [FK__on_messag__id_ln__0BF3A561]
GO
/****** Object:  ForeignKey [FK__on_messag__id_on__0AFF8128]    Script Date: 04/19/2022 15:27:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_on__0AFF8128]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_on__0AFF8128] FOREIGN KEY([id_on_message_action])
REFERENCES [dbo].[on_message_action] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_on__0AFF8128]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance] CHECK CONSTRAINT [FK__on_messag__id_on__0AFF8128]
GO
/****** Object:  ForeignKey [FK__on_messag__id_se__0DDBEDD3]    Script Date: 04/19/2022 15:27:53 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_se__0DDBEDD3]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_se__0DDBEDD3] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_se__0DDBEDD3]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action_instance]'))
ALTER TABLE [dbo].[on_message_action_instance] CHECK CONSTRAINT [FK__on_messag__id_se__0DDBEDD3]
GO
/****** Object:  ForeignKey [FK__on_messag__id_cr__063ACC0B]    Script Date: 04/19/2022 15:28:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_cr__063ACC0B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_cr__063ACC0B] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_cr__063ACC0B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action] CHECK CONSTRAINT [FK__on_messag__id_cr__063ACC0B]
GO
/****** Object:  ForeignKey [FK__on_messag__id_em__04528399]    Script Date: 04/19/2022 15:28:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_em__04528399]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_em__04528399] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_em__04528399]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action] CHECK CONSTRAINT [FK__on_messag__id_em__04528399]
GO
/****** Object:  ForeignKey [FK__on_messag__id_me__035E5F60]    Script Date: 04/19/2022 15:28:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_me__035E5F60]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_me__035E5F60] FOREIGN KEY([id_message])
REFERENCES [dbo].[message] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_me__035E5F60]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action] CHECK CONSTRAINT [FK__on_messag__id_me__035E5F60]
GO
/****** Object:  ForeignKey [FK__on_messag__id_se__0546A7D2]    Script Date: 04/19/2022 15:28:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_se__0546A7D2]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_se__0546A7D2] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_se__0546A7D2]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action] CHECK CONSTRAINT [FK__on_messag__id_se__0546A7D2]
GO
/****** Object:  ForeignKey [FK__on_messag__id_us__026A3B27]    Script Date: 04/19/2022 15:28:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_us__026A3B27]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action]  WITH CHECK ADD  CONSTRAINT [FK__on_messag__id_us__026A3B27] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_messag__id_us__026A3B27]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_message_action]'))
ALTER TABLE [dbo].[on_message_action] CHECK CONSTRAINT [FK__on_messag__id_us__026A3B27]
GO
/****** Object:  ForeignKey [FK__emsubscri__id_em__20ACD28B]    Script Date: 04/19/2022 15:28:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emsubscri__id_em__20ACD28B]') AND parent_object_id = OBJECT_ID(N'[dbo].[emsubscriber]'))
ALTER TABLE [dbo].[emsubscriber]  WITH CHECK ADD  CONSTRAINT [FK__emsubscri__id_em__20ACD28B] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emsubscri__id_em__20ACD28B]') AND parent_object_id = OBJECT_ID(N'[dbo].[emsubscriber]'))
ALTER TABLE [dbo].[emsubscriber] CHECK CONSTRAINT [FK__emsubscri__id_em__20ACD28B]
GO
/****** Object:  ForeignKey [FK__on_emclic__id_cr__288FE40F]    Script Date: 04/19/2022 15:28:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_cr__288FE40F]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emclic__id_cr__288FE40F] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_cr__288FE40F]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action] CHECK CONSTRAINT [FK__on_emclic__id_cr__288FE40F]
GO
/****** Object:  ForeignKey [FK__on_emclic__id_em__25B37764]    Script Date: 04/19/2022 15:28:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_em__25B37764]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emclic__id_em__25B37764] FOREIGN KEY([id_emlink])
REFERENCES [dbo].[emlink] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_em__25B37764]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action] CHECK CONSTRAINT [FK__on_emclic__id_em__25B37764]
GO
/****** Object:  ForeignKey [FK__on_emclic__id_em__26A79B9D]    Script Date: 04/19/2022 15:28:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_em__26A79B9D]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emclic__id_em__26A79B9D] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_em__26A79B9D]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action] CHECK CONSTRAINT [FK__on_emclic__id_em__26A79B9D]
GO
/****** Object:  ForeignKey [FK__on_emclic__id_se__279BBFD6]    Script Date: 04/19/2022 15:28:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_se__279BBFD6]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emclic__id_se__279BBFD6] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_se__279BBFD6]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action] CHECK CONSTRAINT [FK__on_emclic__id_se__279BBFD6]
GO
/****** Object:  ForeignKey [FK__on_emclic__id_us__24BF532B]    Script Date: 04/19/2022 15:28:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_us__24BF532B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emclic__id_us__24BF532B] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emclic__id_us__24BF532B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emclick_action]'))
ALTER TABLE [dbo].[on_emclick_action] CHECK CONSTRAINT [FK__on_emclic__id_us__24BF532B]
GO
/****** Object:  ForeignKey [FK__emfollowu__id_us__6FD49106]    Script Date: 04/19/2022 15:28:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emfollowu__id_us__6FD49106]') AND parent_object_id = OBJECT_ID(N'[dbo].[emfollowup]'))
ALTER TABLE [dbo].[emfollowup]  WITH CHECK ADD  CONSTRAINT [FK__emfollowu__id_us__6FD49106] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emfollowu__id_us__6FD49106]') AND parent_object_id = OBJECT_ID(N'[dbo].[emfollowup]'))
ALTER TABLE [dbo].[emfollowup] CHECK CONSTRAINT [FK__emfollowu__id_us__6FD49106]
GO
/****** Object:  ForeignKey [FK__emfieldde__id_em__257187A8]    Script Date: 04/19/2022 15:28:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emfieldde__id_em__257187A8]') AND parent_object_id = OBJECT_ID(N'[dbo].[emfielddef]'))
ALTER TABLE [dbo].[emfielddef]  WITH CHECK ADD  CONSTRAINT [FK__emfieldde__id_em__257187A8] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emfieldde__id_em__257187A8]') AND parent_object_id = OBJECT_ID(N'[dbo].[emfielddef]'))
ALTER TABLE [dbo].[emfielddef] CHECK CONSTRAINT [FK__emfieldde__id_em__257187A8]
GO
/****** Object:  ForeignKey [FK__emfield__id_emsu__2B2A60FE]    Script Date: 04/19/2022 15:28:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emfield__id_emsu__2B2A60FE]') AND parent_object_id = OBJECT_ID(N'[dbo].[emfield]'))
ALTER TABLE [dbo].[emfield]  WITH CHECK ADD  CONSTRAINT [FK__emfield__id_emsu__2B2A60FE] FOREIGN KEY([id_emsubscriber])
REFERENCES [dbo].[emsubscriber] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emfield__id_emsu__2B2A60FE]') AND parent_object_id = OBJECT_ID(N'[dbo].[emfield]'))
ALTER TABLE [dbo].[emfield] CHECK CONSTRAINT [FK__emfield__id_emsu__2B2A60FE]
GO
/****** Object:  ForeignKey [FK__on_emopen__id_cr__1FFA9E0E]    Script Date: 04/19/2022 15:28:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_cr__1FFA9E0E]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emopen__id_cr__1FFA9E0E] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_cr__1FFA9E0E]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action] CHECK CONSTRAINT [FK__on_emopen__id_cr__1FFA9E0E]
GO
/****** Object:  ForeignKey [FK__on_emopen__id_em__1D1E3163]    Script Date: 04/19/2022 15:28:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_em__1D1E3163]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emopen__id_em__1D1E3163] FOREIGN KEY([id_emcampaign])
REFERENCES [dbo].[emdelivery] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_em__1D1E3163]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action] CHECK CONSTRAINT [FK__on_emopen__id_em__1D1E3163]
GO
/****** Object:  ForeignKey [FK__on_emopen__id_em__1E12559C]    Script Date: 04/19/2022 15:28:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_em__1E12559C]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emopen__id_em__1E12559C] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_em__1E12559C]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action] CHECK CONSTRAINT [FK__on_emopen__id_em__1E12559C]
GO
/****** Object:  ForeignKey [FK__on_emopen__id_se__1F0679D5]    Script Date: 04/19/2022 15:28:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_se__1F0679D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emopen__id_se__1F0679D5] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_se__1F0679D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action] CHECK CONSTRAINT [FK__on_emopen__id_se__1F0679D5]
GO
/****** Object:  ForeignKey [FK__on_emopen__id_us__1C2A0D2A]    Script Date: 04/19/2022 15:28:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_us__1C2A0D2A]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emopen__id_us__1C2A0D2A] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emopen__id_us__1C2A0D2A]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emopen_action]'))
ALTER TABLE [dbo].[on_emopen_action] CHECK CONSTRAINT [FK__on_emopen__id_us__1C2A0D2A]
GO
/****** Object:  ForeignKey [FK__emunsubsc__id_em__164F3FA9]    Script Date: 04/19/2022 15:28:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emunsubsc__id_em__164F3FA9]') AND parent_object_id = OBJECT_ID(N'[dbo].[emunsubscribe]'))
ALTER TABLE [dbo].[emunsubscribe]  WITH CHECK ADD  CONSTRAINT [FK__emunsubsc__id_em__164F3FA9] FOREIGN KEY([id_emdelivery])
REFERENCES [dbo].[emdelivery] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emunsubsc__id_em__164F3FA9]') AND parent_object_id = OBJECT_ID(N'[dbo].[emunsubscribe]'))
ALTER TABLE [dbo].[emunsubscribe] CHECK CONSTRAINT [FK__emunsubsc__id_em__164F3FA9]
GO
/****** Object:  ForeignKey [FK__emunsubsc__id_em__6462DE5A]    Script Date: 04/19/2022 15:28:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emunsubsc__id_em__6462DE5A]') AND parent_object_id = OBJECT_ID(N'[dbo].[emunsubscribe]'))
ALTER TABLE [dbo].[emunsubscribe]  WITH CHECK ADD  CONSTRAINT [FK__emunsubsc__id_em__6462DE5A] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emunsubsc__id_em__6462DE5A]') AND parent_object_id = OBJECT_ID(N'[dbo].[emunsubscribe]'))
ALTER TABLE [dbo].[emunsubscribe] CHECK CONSTRAINT [FK__emunsubsc__id_em__6462DE5A]
GO
/****** Object:  ForeignKey [FK__emreply__id_emde__3427BB3A]    Script Date: 04/19/2022 15:28:52 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emreply__id_emde__3427BB3A]') AND parent_object_id = OBJECT_ID(N'[dbo].[emreply]'))
ALTER TABLE [dbo].[emreply]  WITH CHECK ADD  CONSTRAINT [FK__emreply__id_emde__3427BB3A] FOREIGN KEY([id_emdelivery])
REFERENCES [dbo].[emdelivery] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emreply__id_emde__3427BB3A]') AND parent_object_id = OBJECT_ID(N'[dbo].[emreply]'))
ALTER TABLE [dbo].[emreply] CHECK CONSTRAINT [FK__emreply__id_emde__3427BB3A]
GO
/****** Object:  ForeignKey [FK__emopen__id_emdel__32616E72]    Script Date: 04/19/2022 15:28:56 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emopen__id_emdel__32616E72]') AND parent_object_id = OBJECT_ID(N'[dbo].[emopen]'))
ALTER TABLE [dbo].[emopen]  WITH CHECK ADD  CONSTRAINT [FK__emopen__id_emdel__32616E72] FOREIGN KEY([id_emdelivery])
REFERENCES [dbo].[emdelivery] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emopen__id_emdel__32616E72]') AND parent_object_id = OBJECT_ID(N'[dbo].[emopen]'))
ALTER TABLE [dbo].[emopen] CHECK CONSTRAINT [FK__emopen__id_emdel__32616E72]
GO
/****** Object:  ForeignKey [FK__emclick__id_emde__64B7E415]    Script Date: 04/19/2022 15:29:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emclick__id_emde__64B7E415]') AND parent_object_id = OBJECT_ID(N'[dbo].[emclick]'))
ALTER TABLE [dbo].[emclick]  WITH CHECK ADD  CONSTRAINT [FK__emclick__id_emde__64B7E415] FOREIGN KEY([id_emdelivery])
REFERENCES [dbo].[emdelivery] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emclick__id_emde__64B7E415]') AND parent_object_id = OBJECT_ID(N'[dbo].[emclick]'))
ALTER TABLE [dbo].[emclick] CHECK CONSTRAINT [FK__emclick__id_emde__64B7E415]
GO
/****** Object:  ForeignKey [FK__emclick__id_emli__6A1BB7B0]    Script Date: 04/19/2022 15:29:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emclick__id_emli__6A1BB7B0]') AND parent_object_id = OBJECT_ID(N'[dbo].[emclick]'))
ALTER TABLE [dbo].[emclick]  WITH CHECK ADD  CONSTRAINT [FK__emclick__id_emli__6A1BB7B0] FOREIGN KEY([id_emlink])
REFERENCES [dbo].[emlink] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emclick__id_emli__6A1BB7B0]') AND parent_object_id = OBJECT_ID(N'[dbo].[emclick]'))
ALTER TABLE [dbo].[emclick] CHECK CONSTRAINT [FK__emclick__id_emli__6A1BB7B0]
GO
/****** Object:  ForeignKey [FK__emclick__id_emsu__6B0FDBE9]    Script Date: 04/19/2022 15:29:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emclick__id_emsu__6B0FDBE9]') AND parent_object_id = OBJECT_ID(N'[dbo].[emclick]'))
ALTER TABLE [dbo].[emclick]  WITH CHECK ADD  CONSTRAINT [FK__emclick__id_emsu__6B0FDBE9] FOREIGN KEY([id_emsubscriber])
REFERENCES [dbo].[emsubscriber] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emclick__id_emsu__6B0FDBE9]') AND parent_object_id = OBJECT_ID(N'[dbo].[emclick]'))
ALTER TABLE [dbo].[emclick] CHECK CONSTRAINT [FK__emclick__id_emsu__6B0FDBE9]
GO
/****** Object:  ForeignKey [FK__emcampaig__id_em__30E33A54]    Script Date: 04/19/2022 15:29:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_em__30E33A54]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign]  WITH CHECK ADD  CONSTRAINT [FK__emcampaig__id_em__30E33A54] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_em__30E33A54]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign] CHECK CONSTRAINT [FK__emcampaig__id_em__30E33A54]
GO
/****** Object:  ForeignKey [FK__emcampaig__id_em__63C3BFDC]    Script Date: 04/19/2022 15:29:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_em__63C3BFDC]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign]  WITH CHECK ADD  CONSTRAINT [FK__emcampaig__id_em__63C3BFDC] FOREIGN KEY([id_emserver])
REFERENCES [dbo].[emserver] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_em__63C3BFDC]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign] CHECK CONSTRAINT [FK__emcampaig__id_em__63C3BFDC]
GO
/****** Object:  ForeignKey [FK__emcampaig__id_fo__70C8B53F]    Script Date: 04/19/2022 15:29:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_fo__70C8B53F]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign]  WITH CHECK ADD  CONSTRAINT [FK__emcampaig__id_fo__70C8B53F] FOREIGN KEY([id_emfollowup])
REFERENCES [dbo].[emfollowup] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_fo__70C8B53F]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign] CHECK CONSTRAINT [FK__emcampaig__id_fo__70C8B53F]
GO
/****** Object:  ForeignKey [FK__emcampaig__id_ln__335592AB]    Script Date: 04/19/2022 15:29:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_ln__335592AB]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign]  WITH CHECK ADD  CONSTRAINT [FK__emcampaig__id_ln__335592AB] FOREIGN KEY([id_lngroup])
REFERENCES [dbo].[lngroup] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_ln__335592AB]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign] CHECK CONSTRAINT [FK__emcampaig__id_ln__335592AB]
GO
/****** Object:  ForeignKey [FK__emcampaig__id_us__2FEF161B]    Script Date: 04/19/2022 15:29:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_us__2FEF161B]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign]  WITH CHECK ADD  CONSTRAINT [FK__emcampaig__id_us__2FEF161B] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emcampaig__id_us__2FEF161B]') AND parent_object_id = OBJECT_ID(N'[dbo].[emcampaign]'))
ALTER TABLE [dbo].[emcampaign] CHECK CONSTRAINT [FK__emcampaig__id_us__2FEF161B]
GO
/****** Object:  ForeignKey [FK__on_emdeli__id_cr__1765580D]    Script Date: 04/19/2022 15:29:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_cr__1765580D]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emdeli__id_cr__1765580D] FOREIGN KEY([id_crmlist])
REFERENCES [dbo].[crmlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_cr__1765580D]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action] CHECK CONSTRAINT [FK__on_emdeli__id_cr__1765580D]
GO
/****** Object:  ForeignKey [FK__on_emdeli__id_em__1488EB62]    Script Date: 04/19/2022 15:29:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_em__1488EB62]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emdeli__id_em__1488EB62] FOREIGN KEY([id_emcampaign])
REFERENCES [dbo].[emcampaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_em__1488EB62]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action] CHECK CONSTRAINT [FK__on_emdeli__id_em__1488EB62]
GO
/****** Object:  ForeignKey [FK__on_emdeli__id_em__157D0F9B]    Script Date: 04/19/2022 15:29:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_em__157D0F9B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emdeli__id_em__157D0F9B] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_em__157D0F9B]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action] CHECK CONSTRAINT [FK__on_emdeli__id_em__157D0F9B]
GO
/****** Object:  ForeignKey [FK__on_emdeli__id_se__167133D4]    Script Date: 04/19/2022 15:29:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_se__167133D4]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emdeli__id_se__167133D4] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_se__167133D4]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action] CHECK CONSTRAINT [FK__on_emdeli__id_se__167133D4]
GO
/****** Object:  ForeignKey [FK__on_emdeli__id_us__1394C729]    Script Date: 04/19/2022 15:29:57 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_us__1394C729]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action]  WITH CHECK ADD  CONSTRAINT [FK__on_emdeli__id_us__1394C729] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__on_emdeli__id_us__1394C729]') AND parent_object_id = OBJECT_ID(N'[dbo].[on_emdelivery_action]'))
ALTER TABLE [dbo].[on_emdelivery_action] CHECK CONSTRAINT [FK__on_emdeli__id_us__1394C729]
GO
/****** Object:  ForeignKey [FK__emlink__id_emcam__515009E6]    Script Date: 04/19/2022 15:30:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emlink__id_emcam__515009E6]') AND parent_object_id = OBJECT_ID(N'[dbo].[emlink]'))
ALTER TABLE [dbo].[emlink]  WITH CHECK ADD  CONSTRAINT [FK__emlink__id_emcam__515009E6] FOREIGN KEY([id_emcampaign])
REFERENCES [dbo].[emcampaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emlink__id_emcam__515009E6]') AND parent_object_id = OBJECT_ID(N'[dbo].[emlink]'))
ALTER TABLE [dbo].[emlink] CHECK CONSTRAINT [FK__emlink__id_emcam__515009E6]
GO
/****** Object:  ForeignKey [FK__emdeliver__id_em__30AE302A]    Script Date: 04/19/2022 15:30:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__30AE302A]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdeliveryjob]'))
ALTER TABLE [dbo].[emdeliveryjob]  WITH CHECK ADD  CONSTRAINT [FK__emdeliver__id_em__30AE302A] FOREIGN KEY([id_emcampaign])
REFERENCES [dbo].[emcampaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__30AE302A]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdeliveryjob]'))
ALTER TABLE [dbo].[emdeliveryjob] CHECK CONSTRAINT [FK__emdeliver__id_em__30AE302A]
GO
/****** Object:  ForeignKey [FK__emdeliver__id_em__31A25463]    Script Date: 04/19/2022 15:30:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__31A25463]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdelivery]'))
ALTER TABLE [dbo].[emdelivery]  WITH CHECK ADD  CONSTRAINT [FK__emdeliver__id_em__31A25463] FOREIGN KEY([id_emdeliveryjob])
REFERENCES [dbo].[emdeliveryjob] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__31A25463]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdelivery]'))
ALTER TABLE [dbo].[emdelivery] CHECK CONSTRAINT [FK__emdeliver__id_em__31A25463]
GO
/****** Object:  ForeignKey [FK__emdeliver__id_em__35A7EF71]    Script Date: 04/19/2022 15:30:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__35A7EF71]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdelivery]'))
ALTER TABLE [dbo].[emdelivery]  WITH CHECK ADD  CONSTRAINT [FK__emdeliver__id_em__35A7EF71] FOREIGN KEY([id_emcampaign])
REFERENCES [dbo].[emcampaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__35A7EF71]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdelivery]'))
ALTER TABLE [dbo].[emdelivery] CHECK CONSTRAINT [FK__emdeliver__id_em__35A7EF71]
GO
/****** Object:  ForeignKey [FK__emdeliver__id_em__369C13AA]    Script Date: 04/19/2022 15:30:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__369C13AA]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdelivery]'))
ALTER TABLE [dbo].[emdelivery]  WITH CHECK ADD  CONSTRAINT [FK__emdeliver__id_em__369C13AA] FOREIGN KEY([id_emsubscriber])
REFERENCES [dbo].[emsubscriber] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__emdeliver__id_em__369C13AA]') AND parent_object_id = OBJECT_ID(N'[dbo].[emdelivery]'))
ALTER TABLE [dbo].[emdelivery] CHECK CONSTRAINT [FK__emdeliver__id_em__369C13AA]
GO
/****** Object:  ForeignKey [FK__embedded___id_tr__03B64FF1]    Script Date: 04/19/2022 15:30:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embedded___id_tr__03B64FF1]') AND parent_object_id = OBJECT_ID(N'[dbo].[embedded_link]'))
ALTER TABLE [dbo].[embedded_link]  WITH CHECK ADD  CONSTRAINT [FK__embedded___id_tr__03B64FF1] FOREIGN KEY([id_tracking_pixel])
REFERENCES [dbo].[tracking_pixel] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embedded___id_tr__03B64FF1]') AND parent_object_id = OBJECT_ID(N'[dbo].[embedded_link]'))
ALTER TABLE [dbo].[embedded_link] CHECK CONSTRAINT [FK__embedded___id_tr__03B64FF1]
GO
/****** Object:  ForeignKey [FK__embedded___id_us__02C22BB8]    Script Date: 04/19/2022 15:30:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embedded___id_us__02C22BB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[embedded_link]'))
ALTER TABLE [dbo].[embedded_link]  WITH CHECK ADD  CONSTRAINT [FK__embedded___id_us__02C22BB8] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embedded___id_us__02C22BB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[embedded_link]'))
ALTER TABLE [dbo].[embedded_link] CHECK CONSTRAINT [FK__embedded___id_us__02C22BB8]
GO
/****** Object:  ForeignKey [FK__em_minute__id_em__481BA567]    Script Date: 04/19/2022 15:30:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_minute__id_em__481BA567]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_minutely_stats]'))
ALTER TABLE [dbo].[em_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__em_minute__id_em__481BA567] FOREIGN KEY([id_emlist])
REFERENCES [dbo].[emlist] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_minute__id_em__481BA567]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_minutely_stats]'))
ALTER TABLE [dbo].[em_minutely_stats] CHECK CONSTRAINT [FK__em_minute__id_em__481BA567]
GO
/****** Object:  ForeignKey [FK__em_minute__id_em__490FC9A0]    Script Date: 04/19/2022 15:30:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_minute__id_em__490FC9A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_minutely_stats]'))
ALTER TABLE [dbo].[em_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__em_minute__id_em__490FC9A0] FOREIGN KEY([id_emcampaign])
REFERENCES [dbo].[emcampaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_minute__id_em__490FC9A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_minutely_stats]'))
ALTER TABLE [dbo].[em_minutely_stats] CHECK CONSTRAINT [FK__em_minute__id_em__490FC9A0]
GO
/****** Object:  ForeignKey [FK__lncompany__id_ln__29AA2CC7]    Script Date: 04/19/2022 15:31:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lncompany__id_ln__29AA2CC7]') AND parent_object_id = OBJECT_ID(N'[dbo].[company_sics]'))
ALTER TABLE [dbo].[company_sics]  WITH CHECK ADD  CONSTRAINT [FK__lncompany__id_ln__29AA2CC7] FOREIGN KEY([id_company])
REFERENCES [dbo].[company] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lncompany__id_ln__29AA2CC7]') AND parent_object_id = OBJECT_ID(N'[dbo].[company_sics]'))
ALTER TABLE [dbo].[company_sics] CHECK CONSTRAINT [FK__lncompany__id_ln__29AA2CC7]
GO
/****** Object:  ForeignKey [FK__lncompany__id_ln__2E6EE1E4]    Script Date: 04/19/2022 15:31:07 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lncompany__id_ln__2E6EE1E4]') AND parent_object_id = OBJECT_ID(N'[dbo].[company_naics]'))
ALTER TABLE [dbo].[company_naics]  WITH CHECK ADD  CONSTRAINT [FK__lncompany__id_ln__2E6EE1E4] FOREIGN KEY([id_company])
REFERENCES [dbo].[company] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lncompany__id_ln__2E6EE1E4]') AND parent_object_id = OBJECT_ID(N'[dbo].[company_naics]'))
ALTER TABLE [dbo].[company_naics] CHECK CONSTRAINT [FK__lncompany__id_ln__2E6EE1E4]
GO
/****** Object:  ForeignKey [FK__liappend4__id_li__1E256B9B]    Script Date: 04/19/2022 15:31:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liappend4__id_li__1E256B9B]') AND parent_object_id = OBJECT_ID(N'[dbo].[append]'))
ALTER TABLE [dbo].[append]  WITH CHECK ADD  CONSTRAINT [FK__liappend4__id_li__1E256B9B] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__liappend4__id_li__1E256B9B]') AND parent_object_id = OBJECT_ID(N'[dbo].[append]'))
ALTER TABLE [dbo].[append] CHECK CONSTRAINT [FK__liappend4__id_li__1E256B9B]
GO
/****** Object:  ForeignKey [FK__affiliate__id_us__7DFD769B]    Script Date: 04/19/2022 15:31:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__affiliate__id_us__7DFD769B]') AND parent_object_id = OBJECT_ID(N'[dbo].[affiliate_link]'))
ALTER TABLE [dbo].[affiliate_link]  WITH CHECK ADD  CONSTRAINT [FK__affiliate__id_us__7DFD769B] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__affiliate__id_us__7DFD769B]') AND parent_object_id = OBJECT_ID(N'[dbo].[affiliate_link]'))
ALTER TABLE [dbo].[affiliate_link] CHECK CONSTRAINT [FK__affiliate__id_us__7DFD769B]
GO
/****** Object:  ForeignKey [FK__buffer_ap__id_ln__64D48445]    Script Date: 04/19/2022 15:31:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_ap__id_ln__64D48445]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_append_liprofile_6_output]'))
ALTER TABLE [dbo].[buffer_append_liprofile_6_output]  WITH CHECK ADD  CONSTRAINT [FK__buffer_ap__id_ln__64D48445] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_ap__id_ln__64D48445]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_append_liprofile_6_output]'))
ALTER TABLE [dbo].[buffer_append_liprofile_6_output] CHECK CONSTRAINT [FK__buffer_ap__id_ln__64D48445]
GO
/****** Object:  ForeignKey [FK__filejobdr__id_pi__1D221D89]    Script Date: 04/19/2022 15:31:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__filejobdr__id_pi__1D221D89]') AND parent_object_id = OBJECT_ID(N'[dbo].[filejobdrlwlt]'))
ALTER TABLE [dbo].[filejobdrlwlt]  WITH CHECK ADD  CONSTRAINT [FK__filejobdr__id_pi__1D221D89] FOREIGN KEY([id_pipeline])
REFERENCES [dbo].[pipeline] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__filejobdr__id_pi__1D221D89]') AND parent_object_id = OBJECT_ID(N'[dbo].[filejobdrlwlt]'))
ALTER TABLE [dbo].[filejobdrlwlt] CHECK CONSTRAINT [FK__filejobdr__id_pi__1D221D89]
GO
/****** Object:  ForeignKey [FK__filejobdr__id_us__1E1641C2]    Script Date: 04/19/2022 15:31:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__filejobdr__id_us__1E1641C2]') AND parent_object_id = OBJECT_ID(N'[dbo].[filejobdrlwlt]'))
ALTER TABLE [dbo].[filejobdrlwlt]  WITH CHECK ADD  CONSTRAINT [FK__filejobdr__id_us__1E1641C2] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__filejobdr__id_us__1E1641C2]') AND parent_object_id = OBJECT_ID(N'[dbo].[filejobdrlwlt]'))
ALTER TABLE [dbo].[filejobdrlwlt] CHECK CONSTRAINT [FK__filejobdr__id_us__1E1641C2]
GO
/****** Object:  ForeignKey [FK__fielddef__id_sea__05AEEB50]    Script Date: 04/19/2022 15:31:54 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fielddef__id_sea__05AEEB50]') AND parent_object_id = OBJECT_ID(N'[dbo].[fielddef]'))
ALTER TABLE [dbo].[fielddef]  WITH CHECK ADD  CONSTRAINT [FK__fielddef__id_sea__05AEEB50] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fielddef__id_sea__05AEEB50]') AND parent_object_id = OBJECT_ID(N'[dbo].[fielddef]'))
ALTER TABLE [dbo].[fielddef] CHECK CONSTRAINT [FK__fielddef__id_sea__05AEEB50]
GO
/****** Object:  ForeignKey [FK__field__id_result__0A73A06D]    Script Date: 04/19/2022 15:32:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__field__id_result__0A73A06D]') AND parent_object_id = OBJECT_ID(N'[dbo].[field]'))
ALTER TABLE [dbo].[field]  WITH NOCHECK ADD  CONSTRAINT [FK__field__id_result__0A73A06D] FOREIGN KEY([id_result])
REFERENCES [dbo].[result] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__field__id_result__0A73A06D]') AND parent_object_id = OBJECT_ID(N'[dbo].[field]'))
ALTER TABLE [dbo].[field] CHECK CONSTRAINT [FK__field__id_result__0A73A06D]
GO
/****** Object:  ForeignKey [FK__notificat__id_ho__7A41F450]    Script Date: 04/19/2022 15:32:10 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__notificat__id_ho__7A41F450]') AND parent_object_id = OBJECT_ID(N'[dbo].[notification]'))
ALTER TABLE [dbo].[notification]  WITH CHECK ADD  CONSTRAINT [FK__notificat__id_ho__7A41F450] FOREIGN KEY([id_host])
REFERENCES [dbo].[host] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__notificat__id_ho__7A41F450]') AND parent_object_id = OBJECT_ID(N'[dbo].[notification]'))
ALTER TABLE [dbo].[notification] CHECK CONSTRAINT [FK__notificat__id_ho__7A41F450]
GO
/****** Object:  ForeignKey [FK__notificat__id_us__0F824689]    Script Date: 04/19/2022 15:32:10 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__notificat__id_us__0F824689]') AND parent_object_id = OBJECT_ID(N'[dbo].[notification]'))
ALTER TABLE [dbo].[notification]  WITH CHECK ADD  CONSTRAINT [FK__notificat__id_us__0F824689] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__notificat__id_us__0F824689]') AND parent_object_id = OBJECT_ID(N'[dbo].[notification]'))
ALTER TABLE [dbo].[notification] CHECK CONSTRAINT [FK__notificat__id_us__0F824689]
GO
/****** Object:  ForeignKey [FK__hosthisto__id_ho__5BBD6D30]    Script Date: 04/19/2022 15:32:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__hosthisto__id_ho__5BBD6D30]') AND parent_object_id = OBJECT_ID(N'[dbo].[hosthistory]'))
ALTER TABLE [dbo].[hosthistory]  WITH CHECK ADD  CONSTRAINT [FK__hosthisto__id_ho__5BBD6D30] FOREIGN KEY([id_host])
REFERENCES [dbo].[host] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__hosthisto__id_ho__5BBD6D30]') AND parent_object_id = OBJECT_ID(N'[dbo].[hosthistory]'))
ALTER TABLE [dbo].[hosthistory] CHECK CONSTRAINT [FK__hosthisto__id_ho__5BBD6D30]
GO
/****** Object:  ForeignKey [FK__hostalert__id_ho__626A6ABF]    Script Date: 04/19/2022 15:32:29 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__hostalert__id_ho__626A6ABF]') AND parent_object_id = OBJECT_ID(N'[dbo].[hostalert]'))
ALTER TABLE [dbo].[hostalert]  WITH CHECK ADD  CONSTRAINT [FK__hostalert__id_ho__626A6ABF] FOREIGN KEY([id_host])
REFERENCES [dbo].[host] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__hostalert__id_ho__626A6ABF]') AND parent_object_id = OBJECT_ID(N'[dbo].[hostalert]'))
ALTER TABLE [dbo].[hostalert] CHECK CONSTRAINT [FK__hostalert__id_ho__626A6ABF]
GO
/****** Object:  ForeignKey [FK__hostalert__id_us__61764686]    Script Date: 04/19/2022 15:32:29 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__hostalert__id_us__61764686]') AND parent_object_id = OBJECT_ID(N'[dbo].[hostalert]'))
ALTER TABLE [dbo].[hostalert]  WITH CHECK ADD  CONSTRAINT [FK__hostalert__id_us__61764686] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__hostalert__id_us__61764686]') AND parent_object_id = OBJECT_ID(N'[dbo].[hostalert]'))
ALTER TABLE [dbo].[hostalert] CHECK CONSTRAINT [FK__hostalert__id_us__61764686]
GO
/****** Object:  ForeignKey [FK__host__id_client__5CB19169]    Script Date: 04/19/2022 15:32:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__host__id_client__5CB19169]') AND parent_object_id = OBJECT_ID(N'[dbo].[host]'))
ALTER TABLE [dbo].[host]  WITH CHECK ADD  CONSTRAINT [FK__host__id_client__5CB19169] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__host__id_client__5CB19169]') AND parent_object_id = OBJECT_ID(N'[dbo].[host]'))
ALTER TABLE [dbo].[host] CHECK CONSTRAINT [FK__host__id_client__5CB19169]
GO
/****** Object:  ForeignKey [FK__forward_e__id_fo__079BEF6E]    Script Date: 04/19/2022 15:33:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__forward_e__id_fo__079BEF6E]') AND parent_object_id = OBJECT_ID(N'[dbo].[forward_email]'))
ALTER TABLE [dbo].[forward_email]  WITH CHECK ADD  CONSTRAINT [FK__forward_e__id_fo__079BEF6E] FOREIGN KEY([id_forward_domain])
REFERENCES [dbo].[forward_domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__forward_e__id_fo__079BEF6E]') AND parent_object_id = OBJECT_ID(N'[dbo].[forward_email]'))
ALTER TABLE [dbo].[forward_email] CHECK CONSTRAINT [FK__forward_e__id_fo__079BEF6E]
GO
/****** Object:  ForeignKey [FK__forward_e__id_us__06A7CB35]    Script Date: 04/19/2022 15:33:00 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__forward_e__id_us__06A7CB35]') AND parent_object_id = OBJECT_ID(N'[dbo].[forward_email]'))
ALTER TABLE [dbo].[forward_email]  WITH CHECK ADD  CONSTRAINT [FK__forward_e__id_us__06A7CB35] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__forward_e__id_us__06A7CB35]') AND parent_object_id = OBJECT_ID(N'[dbo].[forward_email]'))
ALTER TABLE [dbo].[forward_email] CHECK CONSTRAINT [FK__forward_e__id_us__06A7CB35]
GO
/****** Object:  ForeignKey [FK__forward_d__id_us__01E31618]    Script Date: 04/19/2022 15:33:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__forward_d__id_us__01E31618]') AND parent_object_id = OBJECT_ID(N'[dbo].[forward_domain]'))
ALTER TABLE [dbo].[forward_domain]  WITH CHECK ADD  CONSTRAINT [FK__forward_d__id_us__01E31618] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__forward_d__id_us__01E31618]') AND parent_object_id = OBJECT_ID(N'[dbo].[forward_domain]'))
ALTER TABLE [dbo].[forward_domain] CHECK CONSTRAINT [FK__forward_d__id_us__01E31618]
GO
/****** Object:  ForeignKey [FK__movement__id_cli__29CC2871]    Script Date: 04/19/2022 15:33:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__movement__id_cli__29CC2871]') AND parent_object_id = OBJECT_ID(N'[dbo].[movement]'))
ALTER TABLE [dbo].[movement]  WITH CHECK ADD  CONSTRAINT [FK__movement__id_cli__29CC2871] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__movement__id_cli__29CC2871]') AND parent_object_id = OBJECT_ID(N'[dbo].[movement]'))
ALTER TABLE [dbo].[movement] CHECK CONSTRAINT [FK__movement__id_cli__29CC2871]
GO
/****** Object:  ForeignKey [FK__movement__id_inv__7130C97A]    Script Date: 04/19/2022 15:33:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__movement__id_inv__7130C97A]') AND parent_object_id = OBJECT_ID(N'[dbo].[movement]'))
ALTER TABLE [dbo].[movement]  WITH CHECK ADD  CONSTRAINT [FK__movement__id_inv__7130C97A] FOREIGN KEY([id_invoice_item])
REFERENCES [dbo].[invoice_item] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__movement__id_inv__7130C97A]') AND parent_object_id = OBJECT_ID(N'[dbo].[movement]'))
ALTER TABLE [dbo].[movement] CHECK CONSTRAINT [FK__movement__id_inv__7130C97A]
GO
/****** Object:  ForeignKey [FK__movement__id_use__2AC04CAA]    Script Date: 04/19/2022 15:33:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__movement__id_use__2AC04CAA]') AND parent_object_id = OBJECT_ID(N'[dbo].[movement]'))
ALTER TABLE [dbo].[movement]  WITH CHECK ADD  CONSTRAINT [FK__movement__id_use__2AC04CAA] FOREIGN KEY([id_user_creator])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__movement__id_use__2AC04CAA]') AND parent_object_id = OBJECT_ID(N'[dbo].[movement]'))
ALTER TABLE [dbo].[movement] CHECK CONSTRAINT [FK__movement__id_use__2AC04CAA]
GO
/****** Object:  ForeignKey [FK__fl_invite__id_us__17F252C8]    Script Date: 04/19/2022 15:33:54 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_invite__id_us__17F252C8]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_invite]'))
ALTER TABLE [dbo].[fl_invite]  WITH CHECK ADD  CONSTRAINT [FK__fl_invite__id_us__17F252C8] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_invite__id_us__17F252C8]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_invite]'))
ALTER TABLE [dbo].[fl_invite] CHECK CONSTRAINT [FK__fl_invite__id_us__17F252C8]
GO
/****** Object:  ForeignKey [FK__fl_search__id_se__132D9DAB]    Script Date: 04/19/2022 15:33:58 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_se__132D9DAB]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_position]'))
ALTER TABLE [dbo].[fl_search_position]  WITH CHECK ADD  CONSTRAINT [FK__fl_search__id_se__132D9DAB] FOREIGN KEY([id_search])
REFERENCES [dbo].[fl_search] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_se__132D9DAB]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_position]'))
ALTER TABLE [dbo].[fl_search_position] CHECK CONSTRAINT [FK__fl_search__id_se__132D9DAB]
GO
/****** Object:  ForeignKey [FK__fl_export__id_se__1CB707E5]    Script Date: 04/19/2022 15:34:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_se__1CB707E5]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export]'))
ALTER TABLE [dbo].[fl_export]  WITH CHECK ADD  CONSTRAINT [FK__fl_export__id_se__1CB707E5] FOREIGN KEY([id_search])
REFERENCES [dbo].[fl_search] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_se__1CB707E5]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export]'))
ALTER TABLE [dbo].[fl_export] CHECK CONSTRAINT [FK__fl_export__id_se__1CB707E5]
GO
/****** Object:  ForeignKey [FK__fl_export__id_us__1DAB2C1E]    Script Date: 04/19/2022 15:34:03 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_us__1DAB2C1E]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export]'))
ALTER TABLE [dbo].[fl_export]  WITH CHECK ADD  CONSTRAINT [FK__fl_export__id_us__1DAB2C1E] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_us__1DAB2C1E]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export]'))
ALTER TABLE [dbo].[fl_export] CHECK CONSTRAINT [FK__fl_export__id_us__1DAB2C1E]
GO
/****** Object:  ForeignKey [FK__fl_search__id_us__7B56141A]    Script Date: 04/19/2022 15:34:11 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_us__7B56141A]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search]'))
ALTER TABLE [dbo].[fl_search]  WITH CHECK ADD  CONSTRAINT [FK__fl_search__id_us__7B56141A] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_us__7B56141A]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search]'))
ALTER TABLE [dbo].[fl_search] CHECK CONSTRAINT [FK__fl_search__id_us__7B56141A]
GO
/****** Object:  ForeignKey [FK__lnallocat__id_ln__55DFB4D9]    Script Date: 04/19/2022 15:34:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnallocat__id_ln__55DFB4D9]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnallocationjob]'))
ALTER TABLE [dbo].[lnallocationjob]  WITH CHECK ADD  CONSTRAINT [FK__lnallocat__id_ln__55DFB4D9] FOREIGN KEY([id_lnsearch])
REFERENCES [dbo].[emcampaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnallocat__id_ln__55DFB4D9]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnallocationjob]'))
ALTER TABLE [dbo].[lnallocationjob] CHECK CONSTRAINT [FK__lnallocat__id_ln__55DFB4D9]
GO
/****** Object:  ForeignKey [FK__lcappend__id_lnc__333F85B3]    Script Date: 04/19/2022 15:34:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lcappend__id_lnc__333F85B3]') AND parent_object_id = OBJECT_ID(N'[dbo].[lcappend]'))
ALTER TABLE [dbo].[lcappend]  WITH CHECK ADD  CONSTRAINT [FK__lcappend__id_lnc__333F85B3] FOREIGN KEY([id_company])
REFERENCES [dbo].[company] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lcappend__id_lnc__333F85B3]') AND parent_object_id = OBJECT_ID(N'[dbo].[lcappend]'))
ALTER TABLE [dbo].[lcappend] CHECK CONSTRAINT [FK__lcappend__id_lnc__333F85B3]
GO
/****** Object:  ForeignKey [FK__lnconnect__id_ln__2D54992C]    Script Date: 04/19/2022 15:34:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnconnect__id_ln__2D54992C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnconnection]'))
ALTER TABLE [dbo].[lnconnection]  WITH NOCHECK ADD  CONSTRAINT [FK__lnconnect__id_ln__2D54992C] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnconnect__id_ln__2D54992C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnconnection]'))
ALTER TABLE [dbo].[lnconnection] CHECK CONSTRAINT [FK__lnconnect__id_ln__2D54992C]
GO
/****** Object:  ForeignKey [FK__lnconnect__id_pr__2E48BD65]    Script Date: 04/19/2022 15:34:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnconnect__id_pr__2E48BD65]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnconnection]'))
ALTER TABLE [dbo].[lnconnection]  WITH CHECK ADD  CONSTRAINT [FK__lnconnect__id_pr__2E48BD65] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnconnect__id_pr__2E48BD65]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnconnection]'))
ALTER TABLE [dbo].[lnconnection] CHECK CONSTRAINT [FK__lnconnect__id_pr__2E48BD65]
GO
/****** Object:  ForeignKey [FK__ln_minute__id_ln__062DE679]    Script Date: 04/19/2022 15:35:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ln_minute__id_ln__062DE679]') AND parent_object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]'))
ALTER TABLE [dbo].[pulqui_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__ln_minute__id_ln__062DE679] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ln_minute__id_ln__062DE679]') AND parent_object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]'))
ALTER TABLE [dbo].[pulqui_minutely_stats] CHECK CONSTRAINT [FK__ln_minute__id_ln__062DE679]
GO
/****** Object:  ForeignKey [FK__ln_minutel__date__0539C240]    Script Date: 04/19/2022 15:35:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ln_minutel__date__0539C240]') AND parent_object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]'))
ALTER TABLE [dbo].[pulqui_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__ln_minutel__date__0539C240] FOREIGN KEY([date])
REFERENCES [dbo].[daily] ([date])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ln_minutel__date__0539C240]') AND parent_object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]'))
ALTER TABLE [dbo].[pulqui_minutely_stats] CHECK CONSTRAINT [FK__ln_minutel__date__0539C240]
GO
/****** Object:  ForeignKey [FK__pulqui_mi__id_do__0AF09B7D]    Script Date: 04/19/2022 15:35:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pulqui_mi__id_do__0AF09B7D]') AND parent_object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]'))
ALTER TABLE [dbo].[pulqui_minutely_stats]  WITH CHECK ADD  CONSTRAINT [FK__pulqui_mi__id_do__0AF09B7D] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__pulqui_mi__id_do__0AF09B7D]') AND parent_object_id = OBJECT_ID(N'[dbo].[pulqui_minutely_stats]'))
ALTER TABLE [dbo].[pulqui_minutely_stats] CHECK CONSTRAINT [FK__pulqui_mi__id_do__0AF09B7D]
GO
/****** Object:  ForeignKey [FK__search_ln__id_ln__7DC745E4]    Script Date: 04/19/2022 15:35:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__7DC745E4]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanytype]'))
ALTER TABLE [dbo].[search_lncompanytype]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_ln__7DC745E4] FOREIGN KEY([id_lncompanytype])
REFERENCES [dbo].[lncompanytype] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__7DC745E4]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanytype]'))
ALTER TABLE [dbo].[search_lncompanytype] CHECK CONSTRAINT [FK__search_ln__id_ln__7DC745E4]
GO
/****** Object:  ForeignKey [FK__search_ln__id_se__7CD321AB]    Script Date: 04/19/2022 15:35:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__7CD321AB]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanytype]'))
ALTER TABLE [dbo].[search_lncompanytype]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_se__7CD321AB] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__7CD321AB]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanytype]'))
ALTER TABLE [dbo].[search_lncompanytype] CHECK CONSTRAINT [FK__search_ln__id_se__7CD321AB]
GO
/****** Object:  ForeignKey [FK__search_ln__id_ln__771A4855]    Script Date: 04/19/2022 15:35:50 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__771A4855]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanysize]'))
ALTER TABLE [dbo].[search_lncompanysize]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_ln__771A4855] FOREIGN KEY([id_lncompanysize])
REFERENCES [dbo].[lncompanysize] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__771A4855]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanysize]'))
ALTER TABLE [dbo].[search_lncompanysize] CHECK CONSTRAINT [FK__search_ln__id_ln__771A4855]
GO
/****** Object:  ForeignKey [FK__search_ln__id_se__7626241C]    Script Date: 04/19/2022 15:35:50 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__7626241C]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanysize]'))
ALTER TABLE [dbo].[search_lncompanysize]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_se__7626241C] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__7626241C]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lncompanysize]'))
ALTER TABLE [dbo].[search_lncompanysize] CHECK CONSTRAINT [FK__search_ln__id_se__7626241C]
GO
/****** Object:  ForeignKey [FK__fl_search__id_lo__0D74C455]    Script Date: 04/19/2022 15:36:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_lo__0D74C455]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_location]'))
ALTER TABLE [dbo].[fl_search_location]  WITH CHECK ADD  CONSTRAINT [FK__fl_search__id_lo__0D74C455] FOREIGN KEY([id_location])
REFERENCES [dbo].[fl_location] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_lo__0D74C455]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_location]'))
ALTER TABLE [dbo].[fl_search_location] CHECK CONSTRAINT [FK__fl_search__id_lo__0D74C455]
GO
/****** Object:  ForeignKey [FK__fl_search__id_se__0E68E88E]    Script Date: 04/19/2022 15:36:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_se__0E68E88E]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_location]'))
ALTER TABLE [dbo].[fl_search_location]  WITH CHECK ADD  CONSTRAINT [FK__fl_search__id_se__0E68E88E] FOREIGN KEY([id_search])
REFERENCES [dbo].[fl_search] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_se__0E68E88E]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_location]'))
ALTER TABLE [dbo].[fl_search_location] CHECK CONSTRAINT [FK__fl_search__id_se__0E68E88E]
GO
/****** Object:  ForeignKey [FK__fl_search__id_in__07BBEAFF]    Script Date: 04/19/2022 15:36:15 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_in__07BBEAFF]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_industry]'))
ALTER TABLE [dbo].[fl_search_industry]  WITH CHECK ADD  CONSTRAINT [FK__fl_search__id_in__07BBEAFF] FOREIGN KEY([id_industry])
REFERENCES [dbo].[fl_industry] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_in__07BBEAFF]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_industry]'))
ALTER TABLE [dbo].[fl_search_industry] CHECK CONSTRAINT [FK__fl_search__id_in__07BBEAFF]
GO
/****** Object:  ForeignKey [FK__fl_search__id_se__08B00F38]    Script Date: 04/19/2022 15:36:15 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_se__08B00F38]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_industry]'))
ALTER TABLE [dbo].[fl_search_industry]  WITH CHECK ADD  CONSTRAINT [FK__fl_search__id_se__08B00F38] FOREIGN KEY([id_search])
REFERENCES [dbo].[fl_search] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_search__id_se__08B00F38]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_search_industry]'))
ALTER TABLE [dbo].[fl_search_industry] CHECK CONSTRAINT [FK__fl_search__id_se__08B00F38]
GO
/****** Object:  ForeignKey [FK__event_spe__id_ev__486FFB02]    Script Date: 04/19/2022 15:36:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_spe__id_ev__486FFB02]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_speaker]'))
ALTER TABLE [dbo].[event_speaker]  WITH CHECK ADD  CONSTRAINT [FK__event_spe__id_ev__486FFB02] FOREIGN KEY([id_event])
REFERENCES [dbo].[event] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_spe__id_ev__486FFB02]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_speaker]'))
ALTER TABLE [dbo].[event_speaker] CHECK CONSTRAINT [FK__event_spe__id_ev__486FFB02]
GO
/****** Object:  ForeignKey [FK__event_spe__id_pr__477BD6C9]    Script Date: 04/19/2022 15:36:55 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_spe__id_pr__477BD6C9]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_speaker]'))
ALTER TABLE [dbo].[event_speaker]  WITH CHECK ADD  CONSTRAINT [FK__event_spe__id_pr__477BD6C9] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_spe__id_pr__477BD6C9]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_speaker]'))
ALTER TABLE [dbo].[event_speaker] CHECK CONSTRAINT [FK__event_spe__id_pr__477BD6C9]
GO
/****** Object:  ForeignKey [FK__event_att__id_ev__4E28D458]    Script Date: 04/19/2022 15:36:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_att__id_ev__4E28D458]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_attendee]'))
ALTER TABLE [dbo].[event_attendee]  WITH CHECK ADD  CONSTRAINT [FK__event_att__id_ev__4E28D458] FOREIGN KEY([id_event])
REFERENCES [dbo].[event] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_att__id_ev__4E28D458]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_attendee]'))
ALTER TABLE [dbo].[event_attendee] CHECK CONSTRAINT [FK__event_att__id_ev__4E28D458]
GO
/****** Object:  ForeignKey [FK__event_att__id_pr__4D34B01F]    Script Date: 04/19/2022 15:36:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_att__id_pr__4D34B01F]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_attendee]'))
ALTER TABLE [dbo].[event_attendee]  WITH CHECK ADD  CONSTRAINT [FK__event_att__id_pr__4D34B01F] FOREIGN KEY([id_profile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__event_att__id_pr__4D34B01F]') AND parent_object_id = OBJECT_ID(N'[dbo].[event_attendee]'))
ALTER TABLE [dbo].[event_attendee] CHECK CONSTRAINT [FK__event_att__id_pr__4D34B01F]
GO
/****** Object:  ForeignKey [FK__sis_linke__id_pa__4287AB12]    Script Date: 04/19/2022 15:39:52 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_linke__id_pa__4287AB12]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_page]'))
ALTER TABLE [dbo].[sis_page]  WITH CHECK ADD  CONSTRAINT [FK__sis_linke__id_pa__4287AB12] FOREIGN KEY([id_parent])
REFERENCES [dbo].[sis_directory_entry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_linke__id_pa__4287AB12]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_page]'))
ALTER TABLE [dbo].[sis_page] CHECK CONSTRAINT [FK__sis_linke__id_pa__4287AB12]
GO
/****** Object:  ForeignKey [FK__sis_page__id_dom__4934A8A1]    Script Date: 04/19/2022 15:39:52 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_page__id_dom__4934A8A1]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_page]'))
ALTER TABLE [dbo].[sis_page]  WITH CHECK ADD  CONSTRAINT [FK__sis_page__id_dom__4934A8A1] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_page__id_dom__4934A8A1]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_page]'))
ALTER TABLE [dbo].[sis_page] CHECK CONSTRAINT [FK__sis_page__id_dom__4934A8A1]
GO
/****** Object:  ForeignKey [FK__sis_direc__id_do__48408468]    Script Date: 04/19/2022 15:40:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_direc__id_do__48408468]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]'))
ALTER TABLE [dbo].[sis_directory_entry]  WITH CHECK ADD  CONSTRAINT [FK__sis_direc__id_do__48408468] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_direc__id_do__48408468]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]'))
ALTER TABLE [dbo].[sis_directory_entry] CHECK CONSTRAINT [FK__sis_direc__id_do__48408468]
GO
/****** Object:  ForeignKey [FK__sis_direc__scrap__4A28CCDA]    Script Date: 04/19/2022 15:40:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_direc__scrap__4A28CCDA]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]'))
ALTER TABLE [dbo].[sis_directory_entry]  WITH CHECK ADD  CONSTRAINT [FK__sis_direc__scrap__4A28CCDA] FOREIGN KEY([scrape_reservation_id])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_direc__scrap__4A28CCDA]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]'))
ALTER TABLE [dbo].[sis_directory_entry] CHECK CONSTRAINT [FK__sis_direc__scrap__4A28CCDA]
GO
/****** Object:  ForeignKey [FK__sis_linke__id_pa__3CCED1BC]    Script Date: 04/19/2022 15:40:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_linke__id_pa__3CCED1BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]'))
ALTER TABLE [dbo].[sis_directory_entry]  WITH CHECK ADD  CONSTRAINT [FK__sis_linke__id_pa__3CCED1BC] FOREIGN KEY([id_parent])
REFERENCES [dbo].[sis_directory_entry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sis_linke__id_pa__3CCED1BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[sis_directory_entry]'))
ALTER TABLE [dbo].[sis_directory_entry] CHECK CONSTRAINT [FK__sis_linke__id_pa__3CCED1BC]
GO
/****** Object:  ForeignKey [FK__nbcommand__id_jo__12A38DC6]    Script Date: 04/19/2022 15:40:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__id_jo__12A38DC6]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__id_jo__12A38DC6] FOREIGN KEY([id_job])
REFERENCES [dbo].[nbjob] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__id_jo__12A38DC6]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand] CHECK CONSTRAINT [FK__nbcommand__id_jo__12A38DC6]
GO
/****** Object:  ForeignKey [FK__nbcommand__id_ln__03614A36]    Script Date: 04/19/2022 15:40:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__id_ln__03614A36]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__id_ln__03614A36] FOREIGN KEY([id_lnuser_for_remote])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__id_ln__03614A36]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand] CHECK CONSTRAINT [FK__nbcommand__id_ln__03614A36]
GO
/****** Object:  ForeignKey [FK__nbcommand__param__1456CC0E]    Script Date: 04/19/2022 15:40:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__1456CC0E]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__param__1456CC0E] FOREIGN KEY([param_start_id_mimic_profile])
REFERENCES [dbo].[mimic_profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__1456CC0E]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand] CHECK CONSTRAINT [FK__nbcommand__param__1456CC0E]
GO
/****** Object:  ForeignKey [FK__nbcommand__param__4F228C21]    Script Date: 04/19/2022 15:40:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__4F228C21]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__param__4F228C21] FOREIGN KEY([param_start_id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__4F228C21]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand] CHECK CONSTRAINT [FK__nbcommand__param__4F228C21]
GO
/****** Object:  ForeignKey [FK__nbcommand__param__5016B05A]    Script Date: 04/19/2022 15:40:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__5016B05A]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__param__5016B05A] FOREIGN KEY([param_login_id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__5016B05A]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand] CHECK CONSTRAINT [FK__nbcommand__param__5016B05A]
GO
/****** Object:  ForeignKey [FK__nbcommand__param__54073CCF]    Script Date: 04/19/2022 15:40:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__54073CCF]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__param__54073CCF] FOREIGN KEY([param_start_id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__54073CCF]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand] CHECK CONSTRAINT [FK__nbcommand__param__54073CCF]
GO
/****** Object:  ForeignKey [FK__nbcommand__param__54DB6577]    Script Date: 04/19/2022 15:40:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__54DB6577]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand]  WITH CHECK ADD  CONSTRAINT [FK__nbcommand__param__54DB6577] FOREIGN KEY([param_traffic_id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__nbcommand__param__54DB6577]') AND parent_object_id = OBJECT_ID(N'[dbo].[nbcommand]'))
ALTER TABLE [dbo].[nbcommand] CHECK CONSTRAINT [FK__nbcommand__param__54DB6577]
GO
/****** Object:  ForeignKey [FK__buffer_in__id_do__60063D78]    Script Date: 04/19/2022 15:40:43 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_in__id_do__60063D78]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]'))
ALTER TABLE [dbo].[buffer_incrawl_lnsearchvariation_result]  WITH CHECK ADD  CONSTRAINT [FK__buffer_in__id_do__60063D78] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_in__id_do__60063D78]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]'))
ALTER TABLE [dbo].[buffer_incrawl_lnsearchvariation_result] CHECK CONSTRAINT [FK__buffer_in__id_do__60063D78]
GO
/****** Object:  ForeignKey [FK__buffer_in__id_ln__1FD8A9E3]    Script Date: 04/19/2022 15:40:43 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_in__id_ln__1FD8A9E3]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]'))
ALTER TABLE [dbo].[buffer_incrawl_lnsearchvariation_result]  WITH CHECK ADD  CONSTRAINT [FK__buffer_in__id_ln__1FD8A9E3] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_in__id_ln__1FD8A9E3]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]'))
ALTER TABLE [dbo].[buffer_incrawl_lnsearchvariation_result] CHECK CONSTRAINT [FK__buffer_in__id_ln__1FD8A9E3]
GO
/****** Object:  ForeignKey [FK__buffer_in__id_ln__2E06B425]    Script Date: 04/19/2022 15:40:43 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_in__id_ln__2E06B425]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]'))
ALTER TABLE [dbo].[buffer_incrawl_lnsearchvariation_result]  WITH NOCHECK ADD  CONSTRAINT [FK__buffer_in__id_ln__2E06B425] FOREIGN KEY([id_lnsearchvariationblock])
REFERENCES [dbo].[lnsearchvariationblock] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__buffer_in__id_ln__2E06B425]') AND parent_object_id = OBJECT_ID(N'[dbo].[buffer_incrawl_lnsearchvariation_result]'))
ALTER TABLE [dbo].[buffer_incrawl_lnsearchvariation_result] CHECK CONSTRAINT [FK__buffer_in__id_ln__2E06B425]
GO
/****** Object:  ForeignKey [FK__peer__id_divisio__118A8A8C]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__peer__id_divisio__118A8A8C]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__peer__id_divisio__118A8A8C] FOREIGN KEY([id_division])
REFERENCES [dbo].[division] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__peer__id_divisio__118A8A8C]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__peer__id_divisio__118A8A8C]
GO
/****** Object:  ForeignKey [FK__worker__id_clien__4F57964B]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_clien__4F57964B]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_clien__4F57964B] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_clien__4F57964B]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_clien__4F57964B]
GO
/****** Object:  ForeignKey [FK__worker__id_clien__72A0D288]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_clien__72A0D288]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_clien__72A0D288] FOREIGN KEY([id_client_owner])
REFERENCES [dbo].[client] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_clien__72A0D288]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_clien__72A0D288]
GO
/****** Object:  ForeignKey [FK__worker__id_host__56F8B813]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_host__56F8B813]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_host__56F8B813] FOREIGN KEY([id_host])
REFERENCES [dbo].[host] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_host__56F8B813]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_host__56F8B813]
GO
/****** Object:  ForeignKey [FK__worker__id_lnuse__51FEF8CC]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_lnuse__51FEF8CC]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_lnuse__51FEF8CC] FOREIGN KEY([id_lnuser_for_remote])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_lnuse__51FEF8CC]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_lnuse__51FEF8CC]
GO
/****** Object:  ForeignKey [FK__worker__id_lnuse__7C2A3CC2]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_lnuse__7C2A3CC2]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_lnuse__7C2A3CC2] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_lnuse__7C2A3CC2]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_lnuse__7C2A3CC2]
GO
/****** Object:  ForeignKey [FK__worker__id_proxy__53E7413E]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_proxy__53E7413E]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_proxy__53E7413E] FOREIGN KEY([id_proxy_for_remote_scraping])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_proxy__53E7413E]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_proxy__53E7413E]
GO
/****** Object:  ForeignKey [FK__worker__id_proxy__7D1E60FB]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_proxy__7D1E60FB]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_proxy__7D1E60FB] FOREIGN KEY([id_proxy])
REFERENCES [dbo].[proxy] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_proxy__7D1E60FB]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_proxy__7D1E60FB]
GO
/****** Object:  ForeignKey [FK__worker__id_worke__6AFFB0C0]    Script Date: 04/19/2022 15:41:02 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_worke__6AFFB0C0]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker]  WITH CHECK ADD  CONSTRAINT [FK__worker__id_worke__6AFFB0C0] FOREIGN KEY([id_workerjob])
REFERENCES [dbo].[workerjob] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__worker__id_worke__6AFFB0C0]') AND parent_object_id = OBJECT_ID(N'[dbo].[worker]'))
ALTER TABLE [dbo].[worker] CHECK CONSTRAINT [FK__worker__id_worke__6AFFB0C0]
GO
/****** Object:  ForeignKey [FK__user_divi__id_di__1FD6A9CA]    Script Date: 04/19/2022 15:41:05 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_divi__id_di__1FD6A9CA]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_division]'))
ALTER TABLE [dbo].[user_division]  WITH CHECK ADD  CONSTRAINT [FK__user_divi__id_di__1FD6A9CA] FOREIGN KEY([id_division])
REFERENCES [dbo].[division] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_divi__id_di__1FD6A9CA]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_division]'))
ALTER TABLE [dbo].[user_division] CHECK CONSTRAINT [FK__user_divi__id_di__1FD6A9CA]
GO
/****** Object:  ForeignKey [FK__user_divi__id_us__1EE28591]    Script Date: 04/19/2022 15:41:05 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_divi__id_us__1EE28591]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_division]'))
ALTER TABLE [dbo].[user_division]  WITH CHECK ADD  CONSTRAINT [FK__user_divi__id_us__1EE28591] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_divi__id_us__1EE28591]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_division]'))
ALTER TABLE [dbo].[user_division] CHECK CONSTRAINT [FK__user_divi__id_us__1EE28591]
GO
/****** Object:  ForeignKey [FK__embounce__id_div__7C8F6DA6]    Script Date: 04/19/2022 15:41:13 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embounce__id_div__7C8F6DA6]') AND parent_object_id = OBJECT_ID(N'[dbo].[embounce]'))
ALTER TABLE [dbo].[embounce]  WITH NOCHECK ADD  CONSTRAINT [FK__embounce__id_div__7C8F6DA6] FOREIGN KEY([id_division])
REFERENCES [dbo].[division] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embounce__id_div__7C8F6DA6]') AND parent_object_id = OBJECT_ID(N'[dbo].[embounce]'))
ALTER TABLE [dbo].[embounce] CHECK CONSTRAINT [FK__embounce__id_div__7C8F6DA6]
GO
/****** Object:  ForeignKey [FK__embounce__id_emd__7D8391DF]    Script Date: 04/19/2022 15:41:13 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embounce__id_emd__7D8391DF]') AND parent_object_id = OBJECT_ID(N'[dbo].[embounce]'))
ALTER TABLE [dbo].[embounce]  WITH NOCHECK ADD  CONSTRAINT [FK__embounce__id_emd__7D8391DF] FOREIGN KEY([id_emdelivery])
REFERENCES [dbo].[emdelivery] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embounce__id_emd__7D8391DF]') AND parent_object_id = OBJECT_ID(N'[dbo].[embounce]'))
ALTER TABLE [dbo].[embounce] CHECK CONSTRAINT [FK__embounce__id_emd__7D8391DF]
GO
/****** Object:  ForeignKey [FK__embounce__id_ems__155B1B70]    Script Date: 04/19/2022 15:41:13 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embounce__id_ems__155B1B70]') AND parent_object_id = OBJECT_ID(N'[dbo].[embounce]'))
ALTER TABLE [dbo].[embounce]  WITH NOCHECK ADD  CONSTRAINT [FK__embounce__id_ems__155B1B70] FOREIGN KEY([id_emsubscriber])
REFERENCES [dbo].[emsubscriber] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__embounce__id_ems__155B1B70]') AND parent_object_id = OBJECT_ID(N'[dbo].[embounce]'))
ALTER TABLE [dbo].[embounce] CHECK CONSTRAINT [FK__embounce__id_ems__155B1B70]
GO
/****** Object:  ForeignKey [FK__search_ln__id_ln__04744373]    Script Date: 04/19/2022 15:41:56 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__04744373]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnyearsincurrentposition]'))
ALTER TABLE [dbo].[search_lnyearsincurrentposition]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_ln__04744373] FOREIGN KEY([id_lnyearsincurrentposition])
REFERENCES [dbo].[lnyearsincurrentposition] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__04744373]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnyearsincurrentposition]'))
ALTER TABLE [dbo].[search_lnyearsincurrentposition] CHECK CONSTRAINT [FK__search_ln__id_ln__04744373]
GO
/****** Object:  ForeignKey [FK__search_ln__id_se__03801F3A]    Script Date: 04/19/2022 15:41:56 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__03801F3A]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnyearsincurrentposition]'))
ALTER TABLE [dbo].[search_lnyearsincurrentposition]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_se__03801F3A] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__03801F3A]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnyearsincurrentposition]'))
ALTER TABLE [dbo].[search_lnyearsincurrentposition] CHECK CONSTRAINT [FK__search_ln__id_se__03801F3A]
GO
/****** Object:  ForeignKey [FK__lngroupdi__id_ln__1E8F7FEF]    Script Date: 04/19/2022 15:42:10 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroupdi__id_ln__1E8F7FEF]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroupdirectoryentry]'))
ALTER TABLE [dbo].[lngroupdirectoryentry]  WITH CHECK ADD  CONSTRAINT [FK__lngroupdi__id_ln__1E8F7FEF] FOREIGN KEY([id_lngroupdirectoryentry_parent])
REFERENCES [dbo].[lngroupdirectoryentry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lngroupdi__id_ln__1E8F7FEF]') AND parent_object_id = OBJECT_ID(N'[dbo].[lngroupdirectoryentry]'))
ALTER TABLE [dbo].[lngroupdirectoryentry] CHECK CONSTRAINT [FK__lngroupdi__id_ln__1E8F7FEF]
GO
/****** Object:  ForeignKey [FK__stat_posi__id_li__333AF3DD]    Script Date: 04/19/2022 15:42:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_posi__id_li__333AF3DD]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_position_liprofile]'))
ALTER TABLE [dbo].[stat_position_liprofile]  WITH CHECK ADD  CONSTRAINT [FK__stat_posi__id_li__333AF3DD] FOREIGN KEY([id_liprofile])
REFERENCES [dbo].[profile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_posi__id_li__333AF3DD]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_position_liprofile]'))
ALTER TABLE [dbo].[stat_position_liprofile] CHECK CONSTRAINT [FK__stat_posi__id_li__333AF3DD]
GO
/****** Object:  ForeignKey [FK__stat_posi__id_ln__3246CFA4]    Script Date: 04/19/2022 15:42:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_posi__id_ln__3246CFA4]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_position_liprofile]'))
ALTER TABLE [dbo].[stat_position_liprofile]  WITH CHECK ADD  CONSTRAINT [FK__stat_posi__id_ln__3246CFA4] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__stat_posi__id_ln__3246CFA4]') AND parent_object_id = OBJECT_ID(N'[dbo].[stat_position_liprofile]'))
ALTER TABLE [dbo].[stat_position_liprofile] CHECK CONSTRAINT [FK__stat_posi__id_ln__3246CFA4]
GO
/****** Object:  ForeignKey [FK__search_ln__id_ln__69C04D37]    Script Date: 04/19/2022 15:42:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__69C04D37]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnindustry]'))
ALTER TABLE [dbo].[search_lnindustry]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_ln__69C04D37] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__69C04D37]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnindustry]'))
ALTER TABLE [dbo].[search_lnindustry] CHECK CONSTRAINT [FK__search_ln__id_ln__69C04D37]
GO
/****** Object:  ForeignKey [FK__search_ln__id_se__68CC28FE]    Script Date: 04/19/2022 15:42:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__68CC28FE]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnindustry]'))
ALTER TABLE [dbo].[search_lnindustry]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_se__68CC28FE] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__68CC28FE]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnindustry]'))
ALTER TABLE [dbo].[search_lnindustry] CHECK CONSTRAINT [FK__search_ln__id_se__68CC28FE]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_ln__40676DA0]    Script Date: 04/19/2022 15:42:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__40676DA0]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplatejob]'))
ALTER TABLE [dbo].[lnusertemplatejob]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_ln__40676DA0] FOREIGN KEY([id_lnusertemplate])
REFERENCES [dbo].[lnusertemplate] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__40676DA0]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplatejob]'))
ALTER TABLE [dbo].[lnusertemplatejob] CHECK CONSTRAINT [FK__lnusertem__id_ln__40676DA0]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_ln__424FB612]    Script Date: 04/19/2022 15:42:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__424FB612]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplatejob]'))
ALTER TABLE [dbo].[lnusertemplatejob]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_ln__424FB612] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_ln__424FB612]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplatejob]'))
ALTER TABLE [dbo].[lnusertemplatejob] CHECK CONSTRAINT [FK__lnusertem__id_ln__424FB612]
GO
/****** Object:  ForeignKey [FK__lnusertem__id_us__415B91D9]    Script Date: 04/19/2022 15:42:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_us__415B91D9]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplatejob]'))
ALTER TABLE [dbo].[lnusertemplatejob]  WITH CHECK ADD  CONSTRAINT [FK__lnusertem__id_us__415B91D9] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnusertem__id_us__415B91D9]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnusertemplatejob]'))
ALTER TABLE [dbo].[lnusertemplatejob] CHECK CONSTRAINT [FK__lnusertem__id_us__415B91D9]
GO
/****** Object:  ForeignKey [FK__lnuserjob__id_ln__4CCD4485]    Script Date: 04/19/2022 15:42:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserjob__id_ln__4CCD4485]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserjob]'))
ALTER TABLE [dbo].[lnuserjob]  WITH CHECK ADD  CONSTRAINT [FK__lnuserjob__id_ln__4CCD4485] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserjob__id_ln__4CCD4485]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserjob]'))
ALTER TABLE [dbo].[lnuserjob] CHECK CONSTRAINT [FK__lnuserjob__id_ln__4CCD4485]
GO
/****** Object:  ForeignKey [FK__lnuserjob__id_ln__4EB58CF7]    Script Date: 04/19/2022 15:42:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserjob__id_ln__4EB58CF7]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserjob]'))
ALTER TABLE [dbo].[lnuserjob]  WITH CHECK ADD  CONSTRAINT [FK__lnuserjob__id_ln__4EB58CF7] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserjob__id_ln__4EB58CF7]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserjob]'))
ALTER TABLE [dbo].[lnuserjob] CHECK CONSTRAINT [FK__lnuserjob__id_ln__4EB58CF7]
GO
/****** Object:  ForeignKey [FK__lnuserjob__id_us__4DC168BE]    Script Date: 04/19/2022 15:42:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserjob__id_us__4DC168BE]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserjob]'))
ALTER TABLE [dbo].[lnuserjob]  WITH CHECK ADD  CONSTRAINT [FK__lnuserjob__id_us__4DC168BE] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnuserjob__id_us__4DC168BE]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnuserjob]'))
ALTER TABLE [dbo].[lnuserjob] CHECK CONSTRAINT [FK__lnuserjob__id_us__4DC168BE]
GO
/****** Object:  ForeignKey [FK__lnindustr__id_do__39AB8A66]    Script Date: 04/19/2022 15:42:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnindustr__id_do__39AB8A66]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnindustryconversion]'))
ALTER TABLE [dbo].[lnindustryconversion]  WITH CHECK ADD  CONSTRAINT [FK__lnindustr__id_do__39AB8A66] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnindustr__id_do__39AB8A66]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnindustryconversion]'))
ALTER TABLE [dbo].[lnindustryconversion] CHECK CONSTRAINT [FK__lnindustr__id_do__39AB8A66]
GO
/****** Object:  ForeignKey [FK__lnindustr__id_ln__3A9FAE9F]    Script Date: 04/19/2022 15:42:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnindustr__id_ln__3A9FAE9F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnindustryconversion]'))
ALTER TABLE [dbo].[lnindustryconversion]  WITH CHECK ADD  CONSTRAINT [FK__lnindustr__id_ln__3A9FAE9F] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnindustr__id_ln__3A9FAE9F]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnindustryconversion]'))
ALTER TABLE [dbo].[lnindustryconversion] CHECK CONSTRAINT [FK__lnindustr__id_ln__3A9FAE9F]
GO
/****** Object:  ForeignKey [FK__lnindustr__revis__3C87F711]    Script Date: 04/19/2022 15:42:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnindustr__revis__3C87F711]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnindustryconversion]'))
ALTER TABLE [dbo].[lnindustryconversion]  WITH CHECK ADD  CONSTRAINT [FK__lnindustr__revis__3C87F711] FOREIGN KEY([revision_id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnindustr__revis__3C87F711]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnindustryconversion]'))
ALTER TABLE [dbo].[lnindustryconversion] CHECK CONSTRAINT [FK__lnindustr__revis__3C87F711]
GO
/****** Object:  ForeignKey [FK__user_role__id_ro__4D1564AE]    Script Date: 04/19/2022 15:45:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_role__id_ro__4D1564AE]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_role]'))
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FK__user_role__id_ro__4D1564AE] FOREIGN KEY([id_role])
REFERENCES [dbo].[role] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_role__id_ro__4D1564AE]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_role]'))
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FK__user_role__id_ro__4D1564AE]
GO
/****** Object:  ForeignKey [FK__user_role__id_us__4C214075]    Script Date: 04/19/2022 15:45:46 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_role__id_us__4C214075]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_role]'))
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FK__user_role__id_us__4C214075] FOREIGN KEY([id_user])
REFERENCES [dbo].[user] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__user_role__id_us__4C214075]') AND parent_object_id = OBJECT_ID(N'[dbo].[user_role]'))
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FK__user_role__id_us__4C214075]
GO
/****** Object:  ForeignKey [FK__sitemap__id_doma__4B0B2092]    Script Date: 04/19/2022 15:46:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sitemap__id_doma__4B0B2092]') AND parent_object_id = OBJECT_ID(N'[dbo].[sitemap]'))
ALTER TABLE [dbo].[sitemap]  WITH CHECK ADD  CONSTRAINT [FK__sitemap__id_doma__4B0B2092] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__sitemap__id_doma__4B0B2092]') AND parent_object_id = OBJECT_ID(N'[dbo].[sitemap]'))
ALTER TABLE [dbo].[sitemap] CHECK CONSTRAINT [FK__sitemap__id_doma__4B0B2092]
GO
/****** Object:  ForeignKey [FK__invoice__id_buff__75F57E97]    Script Date: 04/19/2022 15:46:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__invoice__id_buff__75F57E97]') AND parent_object_id = OBJECT_ID(N'[dbo].[invoice]'))
ALTER TABLE [dbo].[invoice]  WITH CHECK ADD  CONSTRAINT [FK__invoice__id_buff__75F57E97] FOREIGN KEY([id_buffer_paypal_notification])
REFERENCES [dbo].[buffer_paypal_notification] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__invoice__id_buff__75F57E97]') AND parent_object_id = OBJECT_ID(N'[dbo].[invoice]'))
ALTER TABLE [dbo].[invoice] CHECK CONSTRAINT [FK__invoice__id_buff__75F57E97]
GO
/****** Object:  ForeignKey [FK__invoice__id_prev__59A01A94]    Script Date: 04/19/2022 15:46:39 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__invoice__id_prev__59A01A94]') AND parent_object_id = OBJECT_ID(N'[dbo].[invoice]'))
ALTER TABLE [dbo].[invoice]  WITH CHECK ADD  CONSTRAINT [FK__invoice__id_prev__59A01A94] FOREIGN KEY([id_previous_invoice])
REFERENCES [dbo].[invoice] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__invoice__id_prev__59A01A94]') AND parent_object_id = OBJECT_ID(N'[dbo].[invoice]'))
ALTER TABLE [dbo].[invoice] CHECK CONSTRAINT [FK__invoice__id_prev__59A01A94]
GO
/****** Object:  ForeignKey [FK__peopledir__id_do__50C3F9E8]    Script Date: 04/19/2022 15:46:49 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__peopledir__id_do__50C3F9E8]') AND parent_object_id = OBJECT_ID(N'[dbo].[peopledirectory]'))
ALTER TABLE [dbo].[peopledirectory]  WITH CHECK ADD  CONSTRAINT [FK__peopledir__id_do__50C3F9E8] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__peopledir__id_do__50C3F9E8]') AND parent_object_id = OBJECT_ID(N'[dbo].[peopledirectory]'))
ALTER TABLE [dbo].[peopledirectory] CHECK CONSTRAINT [FK__peopledir__id_do__50C3F9E8]
GO
/****** Object:  ForeignKey [FK__lnprofile__id_pe__2E5BD364]    Script Date: 04/19/2022 15:47:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnprofile__id_pe__2E5BD364]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnprofile]'))
ALTER TABLE [dbo].[lnprofile]  WITH CHECK ADD  CONSTRAINT [FK__lnprofile__id_pe__2E5BD364] FOREIGN KEY([id_person])
REFERENCES [dbo].[person] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnprofile__id_pe__2E5BD364]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnprofile]'))
ALTER TABLE [dbo].[lnprofile] CHECK CONSTRAINT [FK__lnprofile__id_pe__2E5BD364]
GO
/****** Object:  ForeignKey [FK__lnsearchr__deliv__13BCEBC1]    Script Date: 04/19/2022 15:48:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchr__deliv__13BCEBC1]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult]  WITH CHECK ADD  CONSTRAINT [FK__lnsearchr__deliv__13BCEBC1] FOREIGN KEY([delivery_id_campaign])
REFERENCES [dbo].[campaign] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchr__deliv__13BCEBC1]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult] CHECK CONSTRAINT [FK__lnsearchr__deliv__13BCEBC1]
GO
/****** Object:  ForeignKey [FK__lnsearchr__id_li__7C055DC1]    Script Date: 04/19/2022 15:48:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchr__id_li__7C055DC1]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult]  WITH NOCHECK ADD  CONSTRAINT [FK__lnsearchr__id_li__7C055DC1] FOREIGN KEY([id_lisearchresult])
REFERENCES [dbo].[result] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchr__id_li__7C055DC1]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult] CHECK CONSTRAINT [FK__lnsearchr__id_li__7C055DC1]
GO
/****** Object:  ForeignKey [FK_lnresult_lnprofile]    Script Date: 04/19/2022 15:48:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnresult_lnprofile]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult]  WITH NOCHECK ADD  CONSTRAINT [FK_lnresult_lnprofile] FOREIGN KEY([id_lnprofile])
REFERENCES [dbo].[lnprofile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnresult_lnprofile]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult] CHECK CONSTRAINT [FK_lnresult_lnprofile]
GO
/****** Object:  ForeignKey [FK_lnresult_lnsearch]    Script Date: 04/19/2022 15:48:06 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnresult_lnsearch]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult]  WITH NOCHECK ADD  CONSTRAINT [FK_lnresult_lnsearch] FOREIGN KEY([id_lnsearch])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnresult_lnsearch]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchresult]'))
ALTER TABLE [dbo].[lnsearchresult] CHECK CONSTRAINT [FK_lnresult_lnsearch]
GO
/****** Object:  ForeignKey [FK_lnprofilejob_lncompany]    Script Date: 04/19/2022 15:48:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnprofilejob_lncompany]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnprofilejob]'))
ALTER TABLE [dbo].[lnprofilejob]  WITH NOCHECK ADD  CONSTRAINT [FK_lnprofilejob_lncompany] FOREIGN KEY([id_lncompany])
REFERENCES [dbo].[company] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnprofilejob_lncompany]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnprofilejob]'))
ALTER TABLE [dbo].[lnprofilejob] CHECK CONSTRAINT [FK_lnprofilejob_lncompany]
GO
/****** Object:  ForeignKey [FK_lnprofilejob_lnprofile]    Script Date: 04/19/2022 15:48:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnprofilejob_lnprofile]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnprofilejob]'))
ALTER TABLE [dbo].[lnprofilejob]  WITH NOCHECK ADD  CONSTRAINT [FK_lnprofilejob_lnprofile] FOREIGN KEY([id_lnprofile])
REFERENCES [dbo].[lnprofile] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_lnprofilejob_lnprofile]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnprofilejob]'))
ALTER TABLE [dbo].[lnprofilejob] CHECK CONSTRAINT [FK_lnprofilejob_lnprofile]
GO
/****** Object:  ForeignKey [FK__search_ln__id_ln__706D4AC6]    Script Date: 04/19/2022 15:48:44 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__706D4AC6]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnlocation]'))
ALTER TABLE [dbo].[search_lnlocation]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_ln__706D4AC6] FOREIGN KEY([id_lnlocation])
REFERENCES [dbo].[lnlocation] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_ln__706D4AC6]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnlocation]'))
ALTER TABLE [dbo].[search_lnlocation] CHECK CONSTRAINT [FK__search_ln__id_ln__706D4AC6]
GO
/****** Object:  ForeignKey [FK__search_ln__id_se__6F79268D]    Script Date: 04/19/2022 15:48:44 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__6F79268D]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnlocation]'))
ALTER TABLE [dbo].[search_lnlocation]  WITH CHECK ADD  CONSTRAINT [FK__search_ln__id_se__6F79268D] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__search_ln__id_se__6F79268D]') AND parent_object_id = OBJECT_ID(N'[dbo].[search_lnlocation]'))
ALTER TABLE [dbo].[search_lnlocation] CHECK CONSTRAINT [FK__search_ln__id_se__6F79268D]
GO
/****** Object:  ForeignKey [FK__lnsearchv__id_ln__238925B2]    Script Date: 04/19/2022 15:49:07 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__238925B2]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock]  WITH NOCHECK ADD  CONSTRAINT [FK__lnsearchv__id_ln__238925B2] FOREIGN KEY([id_search])
REFERENCES [dbo].[search] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__238925B2]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock] CHECK CONSTRAINT [FK__lnsearchv__id_ln__238925B2]
GO
/****** Object:  ForeignKey [FK__lnsearchv__id_ln__247D49EB]    Script Date: 04/19/2022 15:49:07 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__247D49EB]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock]  WITH NOCHECK ADD  CONSTRAINT [FK__lnsearchv__id_ln__247D49EB] FOREIGN KEY([id_lnlocation])
REFERENCES [dbo].[lnlocation] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__247D49EB]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock] CHECK CONSTRAINT [FK__lnsearchv__id_ln__247D49EB]
GO
/****** Object:  ForeignKey [FK__lnsearchv__id_ln__25716E24]    Script Date: 04/19/2022 15:49:07 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__25716E24]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock]  WITH NOCHECK ADD  CONSTRAINT [FK__lnsearchv__id_ln__25716E24] FOREIGN KEY([id_lnindustry])
REFERENCES [dbo].[lnindustry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__25716E24]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock] CHECK CONSTRAINT [FK__lnsearchv__id_ln__25716E24]
GO
/****** Object:  ForeignKey [FK__lnsearchv__id_ln__2EFAD85E]    Script Date: 04/19/2022 15:49:07 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__2EFAD85E]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock]  WITH NOCHECK ADD  CONSTRAINT [FK__lnsearchv__id_ln__2EFAD85E] FOREIGN KEY([id_lnuser])
REFERENCES [dbo].[lnuser] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_ln__2EFAD85E]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock]'))
ALTER TABLE [dbo].[lnsearchvariationblock] CHECK CONSTRAINT [FK__lnsearchv__id_ln__2EFAD85E]
GO
/****** Object:  ForeignKey [FK__lnlocatio__id_ln__53D770D6]    Script Date: 04/19/2022 15:49:21 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnlocatio__id_ln__53D770D6]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnlocation]'))
ALTER TABLE [dbo].[lnlocation]  WITH CHECK ADD  CONSTRAINT [FK__lnlocatio__id_ln__53D770D6] FOREIGN KEY([id_lncountry])
REFERENCES [dbo].[lncountry] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnlocatio__id_ln__53D770D6]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnlocation]'))
ALTER TABLE [dbo].[lnlocation] CHECK CONSTRAINT [FK__lnlocatio__id_ln__53D770D6]
GO
/****** Object:  ForeignKey [FK__lnsearchv__id_fi__2B337C4C]    Script Date: 04/19/2022 15:49:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_fi__2B337C4C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock_firstname]'))
ALTER TABLE [dbo].[lnsearchvariationblock_firstname]  WITH NOCHECK ADD  CONSTRAINT [FK__lnsearchv__id_fi__2B337C4C] FOREIGN KEY([id_firstname])
REFERENCES [dbo].[firstname] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__lnsearchv__id_fi__2B337C4C]') AND parent_object_id = OBJECT_ID(N'[dbo].[lnsearchvariationblock_firstname]'))
ALTER TABLE [dbo].[lnsearchvariationblock_firstname] CHECK CONSTRAINT [FK__lnsearchv__id_fi__2B337C4C]
GO
/****** Object:  ForeignKey [FK__companysi__id_do__1B270346]    Script Date: 04/19/2022 15:49:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__companysi__id_do__1B270346]') AND parent_object_id = OBJECT_ID(N'[dbo].[companysize]'))
ALTER TABLE [dbo].[companysize]  WITH CHECK ADD  CONSTRAINT [FK__companysi__id_do__1B270346] FOREIGN KEY([id_domain])
REFERENCES [dbo].[domain] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__companysi__id_do__1B270346]') AND parent_object_id = OBJECT_ID(N'[dbo].[companysize]'))
ALTER TABLE [dbo].[companysize] CHECK CONSTRAINT [FK__companysi__id_do__1B270346]
GO
/****** Object:  ForeignKey [FK__em_buffer__id_di__1466F737]    Script Date: 04/19/2022 15:49:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_di__1466F737]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_open]'))
ALTER TABLE [dbo].[em_buffer_open]  WITH CHECK ADD  CONSTRAINT [FK__em_buffer__id_di__1466F737] FOREIGN KEY([id_division])
REFERENCES [dbo].[division] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_di__1466F737]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_open]'))
ALTER TABLE [dbo].[em_buffer_open] CHECK CONSTRAINT [FK__em_buffer__id_di__1466F737]
GO
/****** Object:  ForeignKey [FK__em_buffer__id_di__20CCCE1C]    Script Date: 04/19/2022 15:49:44 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_di__20CCCE1C]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_click]'))
ALTER TABLE [dbo].[em_buffer_click]  WITH CHECK ADD  CONSTRAINT [FK__em_buffer__id_di__20CCCE1C] FOREIGN KEY([id_division])
REFERENCES [dbo].[division] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_di__20CCCE1C]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_click]'))
ALTER TABLE [dbo].[em_buffer_click] CHECK CONSTRAINT [FK__em_buffer__id_di__20CCCE1C]
GO
/****** Object:  ForeignKey [FK__em_buffer__id_em__59E54FE7]    Script Date: 04/19/2022 15:49:44 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_em__59E54FE7]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_click]'))
ALTER TABLE [dbo].[em_buffer_click]  WITH CHECK ADD  CONSTRAINT [FK__em_buffer__id_em__59E54FE7] FOREIGN KEY([id_em_buffer_link])
REFERENCES [dbo].[em_buffer_link] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_em__59E54FE7]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_click]'))
ALTER TABLE [dbo].[em_buffer_click] CHECK CONSTRAINT [FK__em_buffer__id_em__59E54FE7]
GO
/****** Object:  ForeignKey [FK__em_buffer__id_di__77CAB889]    Script Date: 04/19/2022 15:49:54 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_di__77CAB889]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_bounce]'))
ALTER TABLE [dbo].[em_buffer_bounce]  WITH CHECK ADD  CONSTRAINT [FK__em_buffer__id_di__77CAB889] FOREIGN KEY([id_division])
REFERENCES [dbo].[division] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__em_buffer__id_di__77CAB889]') AND parent_object_id = OBJECT_ID(N'[dbo].[em_buffer_bounce]'))
ALTER TABLE [dbo].[em_buffer_bounce] CHECK CONSTRAINT [FK__em_buffer__id_di__77CAB889]
GO
/****** Object:  ForeignKey [FK__fl_export__id_ex__2CED6FAE]    Script Date: 04/19/2022 15:50:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_ex__2CED6FAE]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export_lead]'))
ALTER TABLE [dbo].[fl_export_lead]  WITH CHECK ADD  CONSTRAINT [FK__fl_export__id_ex__2CED6FAE] FOREIGN KEY([id_export])
REFERENCES [dbo].[fl_export] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_ex__2CED6FAE]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export_lead]'))
ALTER TABLE [dbo].[fl_export_lead] CHECK CONSTRAINT [FK__fl_export__id_ex__2CED6FAE]
GO
/****** Object:  ForeignKey [FK__fl_export__id_le__2DE193E7]    Script Date: 04/19/2022 15:50:01 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_le__2DE193E7]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export_lead]'))
ALTER TABLE [dbo].[fl_export_lead]  WITH CHECK ADD  CONSTRAINT [FK__fl_export__id_le__2DE193E7] FOREIGN KEY([id_lead])
REFERENCES [dbo].[fl_lead] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_export__id_le__2DE193E7]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_export_lead]'))
ALTER TABLE [dbo].[fl_export_lead] CHECK CONSTRAINT [FK__fl_export__id_le__2DE193E7]
GO
/****** Object:  ForeignKey [FK__fl_lead__id_comp__2640721F]    Script Date: 04/19/2022 15:50:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_lead__id_comp__2640721F]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_lead]'))
ALTER TABLE [dbo].[fl_lead]  WITH CHECK ADD  CONSTRAINT [FK__fl_lead__id_comp__2640721F] FOREIGN KEY([id_company])
REFERENCES [dbo].[fl_company] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_lead__id_comp__2640721F]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_lead]'))
ALTER TABLE [dbo].[fl_lead] CHECK CONSTRAINT [FK__fl_lead__id_comp__2640721F]
GO
/****** Object:  ForeignKey [FK__fl_lead__id_indu__2828BA91]    Script Date: 04/19/2022 15:50:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_lead__id_indu__2828BA91]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_lead]'))
ALTER TABLE [dbo].[fl_lead]  WITH CHECK ADD  CONSTRAINT [FK__fl_lead__id_indu__2828BA91] FOREIGN KEY([id_industry])
REFERENCES [dbo].[fl_industry] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_lead__id_indu__2828BA91]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_lead]'))
ALTER TABLE [dbo].[fl_lead] CHECK CONSTRAINT [FK__fl_lead__id_indu__2828BA91]
GO
/****** Object:  ForeignKey [FK__fl_lead__id_loca__27349658]    Script Date: 04/19/2022 15:50:08 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_lead__id_loca__27349658]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_lead]'))
ALTER TABLE [dbo].[fl_lead]  WITH CHECK ADD  CONSTRAINT [FK__fl_lead__id_loca__27349658] FOREIGN KEY([id_location])
REFERENCES [dbo].[fl_location] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_lead__id_loca__27349658]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_lead]'))
ALTER TABLE [dbo].[fl_lead] CHECK CONSTRAINT [FK__fl_lead__id_loca__27349658]
GO
/****** Object:  ForeignKey [FK__invoice_i__id_in__703CA541]    Script Date: 04/19/2022 15:50:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__invoice_i__id_in__703CA541]') AND parent_object_id = OBJECT_ID(N'[dbo].[invoice_item]'))
ALTER TABLE [dbo].[invoice_item]  WITH NOCHECK ADD  CONSTRAINT [FK__invoice_i__id_in__703CA541] FOREIGN KEY([id_invoice])
REFERENCES [dbo].[invoice] ([id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__invoice_i__id_in__703CA541]') AND parent_object_id = OBJECT_ID(N'[dbo].[invoice_item]'))
ALTER TABLE [dbo].[invoice_item] CHECK CONSTRAINT [FK__invoice_i__id_in__703CA541]
GO
/****** Object:  ForeignKey [FK__fl_data__id_lead__32A64904]    Script Date: 04/19/2022 15:50:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_data__id_lead__32A64904]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_data]'))
ALTER TABLE [dbo].[fl_data]  WITH CHECK ADD  CONSTRAINT [FK__fl_data__id_lead__32A64904] FOREIGN KEY([id_lead])
REFERENCES [dbo].[fl_lead] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__fl_data__id_lead__32A64904]') AND parent_object_id = OBJECT_ID(N'[dbo].[fl_data]'))
ALTER TABLE [dbo].[fl_data] CHECK CONSTRAINT [FK__fl_data__id_lead__32A64904]
GO