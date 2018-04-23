SET NOCOUNT ON
GO

USE master
GO
if exists (select * from sysdatabases where name='CarsXtraScheduling')
	drop database CarsXtraScheduling
go

DECLARE @device_directory NVARCHAR(520)
SELECT @device_directory = SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', LOWER(filename)) - 1)
FROM master.dbo.sysaltfiles WHERE dbid = 1 AND fileid = 1

EXECUTE (N'CREATE DATABASE CarsXtraScheduling
  ON PRIMARY (NAME = N''CarsXtraScheduling'', FILENAME = N''' + @device_directory + N'CarsXtraScheduling.mdf'')
  LOG ON (NAME = N''CarsXtraScheduling_log'',  FILENAME = N''' + @device_directory + N'CarsXtraScheduling.ldf'')')
go

--exec sp_dboption 'CarsXtraScheduling','trunc. log on chkpt.','true'
--exec sp_dboption 'CarsXtraScheduling','select into/bulkcopy','true'
--GO


USE [CarsXtraScheduling]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cars](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Trademark] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[HP] [smallint] NULL DEFAULT ((0)),
	[Liter] [float] NULL DEFAULT ((0)),
	[Cyl] [smallint] NULL DEFAULT ((0)),
	[TransmissSpeedCount] [smallint] NULL DEFAULT ((0)),
	[TransmissAutomatic] [nvarchar](3) NULL,
	[MPG_City] [smallint] NULL DEFAULT ((0)),
	[MPG_Highway] [smallint] NULL DEFAULT ((0)),
	[Category] [nvarchar](7) NULL,
	[Description] [ntext] NULL,
	[Hyperlink] [nvarchar](50) NULL,
	[Picture] [image] NULL,
	[Price] [money] NULL DEFAULT ((0)),
	[RtfContent] [ntext] NULL,
 CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarScheduling](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CarId] [nvarchar](max) NULL,
	[UserId] [int] NULL,
	[Status] [int] NULL,
	[Subject] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[Label] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Location] [nvarchar](50) NULL,
	[AllDay] [bit] NOT NULL,
	[EventType] [int] NULL,
	[RecurrenceInfo] [ntext] NULL,
	[ReminderInfo] [ntext] NULL,
	[Price] [money] NULL,
	[ContactInfo] [ntext] NULL,
 CONSTRAINT [PK_CarScheduling] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/***********************************************************************************************************
Cars table data
***********************************************************************************************************/
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Mercedes-Benz','SL500 Roadster',302,4.966000000000000e+000,8,5,'Yes',16,23,'SPORTS','http://www.mercedes.com',83800.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Mercedes-Benz','CLK55 AMG Cabriolet',342,5.439000000000000e+000,8,5,'Yes',17,24,'SPORTS','http://www.mercedes.com',79645.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Mercedes-Benz','C230 Kompressor Sport Coupe',189,1.796000000000000e+000,4,5,'Yes',21,28,'SPORTS','http://www.mercedes.com',25600.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('BMW','530i',225,3.000000000000000e+000,6,5,'No',21,30,'SALOON','http://www.bmw.com',39450.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Rolls-Royce','Corniche',325,6.750000000000000e+000,8,4,'Yes',11,16,'SALOON','http://www.rollsroyce.com',370485.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Jaguar','S-Type 3.0',235,3.000000000000000e+000,6,5,'No',18,25,'SALOON','http://www.jaguar.com',44320.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Cadillac','Seville',275,4.600000000000000e+000,8,4,'Yes',18,27,'SALOON','http://www.cadillac.com',49600.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Cadillac','DeVille',275,4.600000000000000e+000,8,4,'Yes',18,27,'SALOON','http://www.cadillac.com',47780.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Lexus','LS430',290,4.300000000000000e+000,8,5,'Yes',18,25,'SALOON','http://www.lexus.com',54900.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Lexus','GS 430',300,4.300000000000000e+000,8,5,'Yes',18,23,'SALOON','http://www.lexus.com',41242.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Ford','Ranger FX-4',135,2.300000000000000e+000,4,5,'Yes',21,25,'TRUCK','http://www.ford.com',12565.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Dodge','Ram 1500',215,3.700000000000000e+000,6,4,'Yes',15,19,'TRUCK','http://www.dodge.com',17315.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('GMC','Siera Quadrasteer',200,4.300000000000000e+000,6,4,'Yes',15,20,'TRUCK','http://www.gmc.com',17748.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Nissan','Crew Cab SE',143,2.400000000000000e+000,4,4,'Yes',20,23,'TRUCK','http://www.NissanDriven.com',12800.0000)
INSERT INTO [Cars] ([Trademark],[Model],[HP],[Liter],[Cyl],[TransmissSpeedCount],[TransmissAutomatic],[MPG_City],[MPG_Highway],[Category],[Hyperlink],[Price])VALUES('Toyota','Tacoma S-Runner',190,3.400000000000000e+000,6,5,'No',18,22,'TRUCK','http://www.toyota.com',20000.0000)

/***********************************************************************************************************
CarScheduling table data
***********************************************************************************************************/

INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,3,'Mr.Brown','Rent this car',2,'Jul 12 2008 11:00:00:000AM','Jul 12 2008  2:30:00:000PM','city',0,0,NULL,NULL,8.0000,'cellular: +530145961202')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,2,'Repair','Scheduled repair of this car',4,'Jul 14 2008  8:00:00:000AM','Jul 15 2008  4:30:00:000PM','Service Center',0,0,NULL,NULL,90.0000,'Contact: Paula Wilson Address: OR Elgin City Center Plaza 516 Main St.')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,3,'Mr.White','Rent this car',3,'Jul 13 2008 10:00:00:000AM','Jul 13 2008  5:00:00:000PM','city',0,0,NULL,NULL,7.5000,'phone: (401) 349-4620')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="2" />  </ResourceIds>',NULL,1,'Wash','Wash this car in the garage',1,'Jul  5 2008  4:30:00:000PM','Jul  5 2008  6:00:00:000PM','Garage',0,1,'<RecurrenceInfo Start="07/05/2008 16:30:00" End="08/01/2008 00:00:00" WeekDays="62" Id="975889a8-ea37-4625-a1ec-0fb2806199e2" OccurrenceCount="20" Range="2" Type="1" />',NULL,7.5000,'7466 - Gas / Car Wash')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES(NULL,NULL,3,'Tune up','Check up after maintenance',5,'Jul 15 2008  7:30:00:000PM','Jul 15 2008 10:30:00:000PM','Service',0,0,NULL,NULL,45.0000,'Len Radde, 10564 W Woodward Ave, Wauwatosa WI 53444  Email: s_vanish1@servicec.com')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,3,'Mr.Green','Rent this car for the all day',3,'Jul 11 2008 12:00:00:000AM','Jul 12 2008 12:00:00:000AM','city',1,0,NULL,NULL,6.0000,'Phone: (414) 964-5861 (w); (414) 647-1231 (cell); (414) 965-5950 (fax)')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES(NULL,NULL,-1,'Wash','Wash this car in the garage',-1,'Jul 11 2008  7:00:00:000AM','Jul 11 2008  9:00:00:000AM','Garage',0,1,'<RecurrenceInfo Start="07/11/2008 07:00:00" End="12/03/2027 07:00:00" WeekDays="32" Id="51c81018-53fa-4d10-925f-2ed7f8408c75" Month="12" OccurrenceCount="20" Range="1" Type="3" />',NULL,10.0000,'Test')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="3" />  </ResourceIds>',NULL,4,'Mrs.Black','Rent this car',3,'Jul 11 2008 10:00:00:000AM','Jul 11 2008 11:30:00:000AM','out-of-town',0,0,NULL,NULL,7.0000,'Phone: (262) 946-9474; w (222) 723-2678 x22, cell (253) 713-0563, fax (361) 733-2870')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="3" />  </ResourceIds>',NULL,4,'Mrs.Black','Rent this car',3,'Jul 12 2008  1:00:00:000PM','Jul 12 2008  2:30:00:000PM','out-of-town',0,0,NULL,NULL,7.0000,'Phone: (262) 946-9474; w (222) 723-2678 x22, cell (253) 713-0563, fax (361) 733-2870')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="3" />  </ResourceIds>',NULL,4,'Mrs.Black','Rent this car',3,'Jul 13 2008  3:30:00:000PM','Jul 14 2008  2:00:00:000PM','out-of-town',0,0,NULL,NULL,7.0000,'Phone: (262) 946-9474; w (222) 723-2678 x22, cell (253) 713-0563, fax (361) 733-2870')
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,1,'Wash','Wash this car in the garage',1,'Jul  7 2008  4:30:00:000PM','Jul  7 2008  6:00:00:000PM','Garage',0,3,'<RecurrenceInfo Id="975889a8-ea37-4625-a1ec-0fb2806199e2" />',NULL,0.0000,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,1,'Wash','Wash this car in the garage',1,'Jul 14 2008  6:30:00:000PM','Jul 14 2008  8:00:00:000PM','Garage',0,3,'<RecurrenceInfo Id="975889a8-ea37-4625-a1ec-0fb2806199e2" Index="5" />',NULL,0.0000,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,1,'Wash','Wash this car in the garage',1,'Jul 23 2008  3:00:00:000PM','Jul 23 2008  4:30:00:000PM','Garage',0,3,'<RecurrenceInfo Id="975889a8-ea37-4625-a1ec-0fb2806199e2" Index="12" />',NULL,0.0000,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,1,'Wash','Wash this car in the garage',1,'Jul 25 2008  4:30:00:000PM','Jul 25 2008  5:00:00:000PM','Garage',0,3,'<RecurrenceInfo Id="975889a8-ea37-4625-a1ec-0fb2806199e2" Index="14" />',NULL,0.0000,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,2,'London - Brussels','Travel from London to Brussels by Eurostar, leaving London St Pancras at 13:00 (12:57 Fridays & Sundays), arriving Brussels Midi 16:03',6,'Jul 23 2008  1:00:00:000PM','Jul 23 2008  4:06:00:000PM','Eurostar',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,2,'Brussels - Cologne','Travel from Brussels to Cologne by high-speed Thalys train, leaving Brussels Midi at 17:25, arriving in Cologne Hauptbahnhof at 19:45.',6,'Jul 23 2008  5:25:00:000PM','Jul 23 2008  7:45:00:000PM','Thalys',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,2,'Cologne - Vienna','Travel from Cologne to Vienna on the excellent City Night Line hotel train ''Donau Kurier'', leaving Cologne Hauptbahnhof at 20:06 and arriving in Vienna Westbahnhof at 08:35.',6,'Jul 23 2008  8:06:00:000PM','Jul 24 2008  8:35:00:000AM','Donau Kurier',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,2,'Vienna - Budapest','Travel from Vienna to Budapest on the air-conditioned InterCity train ''Avala'', leaving Vienna Westbahnhof at 09:52 and arriving in Budapest Keleti station at 12:53.',6,'Jul 24 2008  9:52:00:000AM','Jul 24 2008 12:53:00:000PM','Avala',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,2,'Budapest - Bucharest','Travel from Budapest to Bucharest overnight on the EuroNight sleeper train ''Ister'', leaving Budapest Keleti station at 17:45 and arriving at Bucharest (Nord station) at 08:43 next morning.',6,'Jul 24 2008  5:45:00:000PM','Jul 25 2008  8:43:00:000AM','Ister',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="1" />  </ResourceIds>',NULL,2,'Bucharest - Istanbul','Travel from Bucharest to Istanbul on the ''Bosphor'', leaving Bucharest (Nord) daily at 12:15 and arriving at Istanbul (Sirkeci station) at 08:00 next day.',6,'Jul 25 2008 12:15:00:000PM','Jul 26 2008  8:00:00:000AM','Bosphor',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="2" />  </ResourceIds>',NULL,2,'Istanbul - Aleppo','The famous ''Toros Express'', named after the Taurus mountains through which it passes, runs 3 times a week from Istanbul (Haydarpasa station on the Asian side) to Gaziantep in southern Turkey.  Once a week on Sundays, it conveys a direct sleeping-car from Istanbul to Aleppo in Syria.',6,'Jul 27 2008  8:55:00:000AM','Jul 28 2008  2:17:00:000PM','Toros Express',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="3" />  </ResourceIds>',NULL,2,'Aleppo - Damascus','Aleppo       depart  10:05    Hama         arr/dep 11:30   Homs         arr/dep 12:30   Damascus  arrive   13:30 Damascus Kadem station   ',6,'Jul 29 2008 10:05:00:000AM','Jul 29 2008  1:30:00:000PM','Train No.12',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="4" />  </ResourceIds>',NULL,2,'Damascus - Amman','Days of running: Mondays & Thursdays  Damascus  (Kadem station)  depart  08:00   Deraa  (change trains)  depart 13:15  Mafraq  arrive 15:00    Amman  arrive 17:00   ',6,'Jul 31 2008  8:00:00:000AM','Jul 31 2008  5:00:00:000PM','Hejaz railway',0,0,NULL,NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="3" />  </ResourceIds>',NULL,2,'Check oil','Regular Maintenance #1',7,'Jul 21 2008 12:00:00:000AM','Jul 22 2008 12:00:00:000AM','Parking',0,1,'<RecurrenceInfo Start="07/21/2008 00:00:00" End="09/22/2008 00:00:00" WeekDays="8" Id="1304e53a-a1db-4159-8de8-8ee62c7c7424" OccurrenceCount="10" Periodicity="2" Type="1" />',NULL,NULL,NULL)
INSERT INTO [CarScheduling] ([CarId],[UserId],[Status],[Subject],[Description],[Label],[StartTime],[EndTime],[Location],[AllDay],[EventType],[RecurrenceInfo],[ReminderInfo],[Price],[ContactInfo])VALUES('<ResourceIds>  <ResourceId Type="System.Int32" Value="3" />  </ResourceIds>',NULL,2,'Regular Maintenance',NULL,3,'Jul 16 2008 12:00:00:000AM','Jul 17 2008 12:00:00:000AM','Service',0,1,'<RecurrenceInfo Start="07/16/2008 00:00:00" End="09/01/2008 00:00:00" WeekDays="34" Id="6e4518d0-a570-4208-aa4e-4a385f2eea6e" OccurrenceCount="7" Range="2" Type="1" />',NULL,NULL,NULL)