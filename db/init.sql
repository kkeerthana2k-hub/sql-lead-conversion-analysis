-- PostgreSQL-compatible version of crew_database.sql
-- Converted from Oracle SQL: VARCHAR2->VARCHAR, NUMBER->INTEGER, TO_DATE->ISO dates, Purge RecycleBin removed
-- Original file: crew_database.sql

/*

Tables:   

Campaign: campaign_id, start_date, end_date, cost, ad, platform
PK :campaign_id 
Sales: rep_id, name, phone, email
PK : rep_id
Lead: lead_id, name, phone, followup_status, campaign_id, rep_id 
PK: lead_id FK: campaign_id, rep_id
Trial_appointment: (App_ID, Date, Outcome, Feedback, Lead ID)  
FK: Lead ID, PK: App_ID
Client: (client_ID, Profession, Gender, Date of Birth, Blood Grp, lead_id) 
FK:lead_id PK : client_id 
Membership: member_id, Mem_Type, Emergency contact number, Emergency contact  Name, Start date, end date, status, client_id
FK: Client ID PK: member_id
    
    */
--Corrected code check
--No ALTER statement check
--Should contain 20 rows of data
--Should follow the integrity rules
--Check which way it is easier to write the project script 
--Add  and COMMIT; statements as seen in cretabs.sql 
-- Alignment check
--
--
--
--
--
--
-------------------------------------------------------------------------------


DROP TABLE IF EXISTS campaign CASCADE;
DROP TABLE IF EXISTS lead CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS membership CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS trial_appointment CASCADE;



 -- adding so that the recycle bin is cleared

--------------> 1
--Creating a table campaign and establishing a primary key and ensuring that end date is greater than start date.

CREATE TABLE campaign ( campaign_id VARCHAR(10),
                        start_date  DATE,
                        end_date    DATE,
                        cost        INTEGER,
                        ad          VARCHAR(7),
                        platform    VARCHAR(15),
CONSTRAINT campaign_pk PRIMARY KEY (campaign_id),
CONSTRAINT campaign_end_date_chk CHECK (end_date > start_date));
INSERT INTO campaign VALUES('Camp12', '2025-01-01'::DATE,     '2025-01-19'::DATE, 2200, 'AD102', 'Instagram');
INSERT INTO campaign VALUES('Camp13', '2025-01-19'::DATE,    '2025-01-30'::DATE, 1800, 'AD103', 'Instagram');
INSERT INTO campaign VALUES('Camp14', '2025-02-05'::DATE,    '2025-02-16'::DATE, 2500, 'AD104', 'Facebook');
INSERT INTO campaign VALUES('Camp15', '2025-02-16'::DATE,  '2025-02-28'::DATE, 1300, 'AD105', 'Privyr');
INSERT INTO campaign VALUES('Camp16', '2025-03-01'::DATE,  '2025-03-10'::DATE, 2100, 'AD106', 'Privyr');
INSERT INTO campaign VALUES('Camp17', '2025-03-15'::DATE, '2025-03-18'::DATE, 1950, 'AD107', 'Facebook');
INSERT INTO campaign VALUES('Camp18', '2025-03-14'::DATE,  '2025-03-20'::DATE, 2400, 'AD102', 'Instagram');
INSERT INTO campaign VALUES('Camp19', '2025-04-02'::DATE,  '2025-04-10'::DATE, 1600, 'AD109', 'Privyr');
INSERT INTO campaign VALUES('Camp20', '2025-04-11'::DATE,  '2025-04-18'::DATE, 2750, 'AD110', 'Facebook');
INSERT INTO campaign VALUES('Camp21', '2025-04-19'::DATE,  '2025-04-25'::DATE, 1200, 'AD111', 'Instagram');
INSERT INTO campaign VALUES('Camp22', '2025-04-26'::DATE,  '2025-04-30'::DATE, 2050, 'AD102', 'Privyr');
INSERT INTO campaign VALUES('Camp23', '2025-05-01'::DATE,  '2025-05-09'::DATE, 1700, 'AD113', 'Facebook');
INSERT INTO campaign VALUES('Camp24', '2025-05-10'::DATE,  '2025-05-18'::DATE, 2300, 'AD114', 'Instagram');
INSERT INTO campaign VALUES('Camp25', '2025-05-19'::DATE,  '2025-05-28'::DATE, 1900, 'AD115', 'Facebook');
INSERT INTO campaign VALUES('Camp26', '2025-05-29'::DATE,  '2025-06-05'::DATE, 2600, 'AD116', 'Privyr');
INSERT INTO campaign VALUES('Camp27', '2025-06-06'::DATE,   '2025-06-14'::DATE, 1450, 'AD117', 'Instagram');
INSERT INTO campaign VALUES('Camp28', '2025-06-15'::DATE,  '2025-06-22'::DATE, 2100, 'AD104', 'Facebook');
INSERT INTO campaign VALUES('Camp29', '2025-06-23'::DATE,  '2025-06-30'::DATE, 1850, 'AD119', 'Instagram');
INSERT INTO campaign VALUES('Camp30', '2025-07-01'::DATE,   '2025-07-08'::DATE, 2400, 'AD120', 'Instagram');
INSERT INTO campaign VALUES('Camp31', '2025-07-09'::DATE,   '2025-07-17'::DATE, 5000, 'AD105', 'Privyr');

--SELECT * FROM campaign;
--Desc campaign	


--------------------> 2
-- 2 Creating SALES TABLE and setting primary key 

CREATE TABLE sales ( rep_id VARCHAR(12),
                     name VARCHAR(15),
                     email VARCHAR(30),
                     phone VARCHAR(10),
CONSTRAINT sales_repid_pk PRIMARY KEY (rep_id));

INSERT INTO sales VALUES ('Rep1324', 'Alan',     'alanrahul@thecrew.com',     '9174628350');
INSERT INTO sales VALUES ('Rep1325', 'Aadhavan', 'aadhavanmuthu@thecrew.com', '9348752160');
INSERT INTO sales VALUES ('Rep1326', 'Kathijha', 'kathijharam@thecrew.com',   '9216475830');
INSERT INTO sales VALUES ('Rep1327', 'Monisha',  'monishalama@thecrew.com',   '9092837461');
INSERT INTO sales VALUES ('Rep1328', 'Selvi',    'selviraghavan@thecrew.com', '9381627450');
INSERT INTO sales VALUES ('Rep1329', 'Monhana',  'monhanaraj@thecrew.com',    '9265748130');
--SELECT * FROM SALES



-------------------------- 3 
--Lead Table 
-- Table change made as it should be either follow-up 
-- check if this is okay
CREATE TABLE lead (lead_id         VARCHAR(8),
                   name            VARCHAR(15),
                   phone           VARCHAR(10),
                   followup_status VARCHAR(15),
                   campaign_id     VARCHAR(10),
                   rep_id          VARCHAR(12),
CONSTRAINT lead_pk PRIMARY KEY (lead_id),
CONSTRAINT lead_campaign_fk FOREIGN KEY (campaign_id) REFERENCES campaign(campaign_id),
CONSTRAINT lead_repid_fk FOREIGN KEY (rep_id) REFERENCES sales(rep_id));

INSERT INTO  lead VALUES    ('Le1234',  'Ananda',    '9384726150', 'In progress',   'Camp12',   'Rep1324');
INSERT INTO  lead VALUES    ('Le1235',	'Geetha',	 '9173648291',	'In progress',	'Camp12',	'Rep1325');
INSERT INTO  lead VALUES 	('Le1236',	'Latha'	,    '9265837401',	'Inactive',	    'Camp13',   'Rep1326');
INSERT INTO  lead VALUES 	('Le1237',	'Raja',	     '9051746283',	'In progress',	'Camp13',	'Rep1324');
INSERT INTO  lead VALUES 	('Le1238',	'Patricia',	 '9182635470',	'In progress',	'Camp14',	'Rep1325');
INSERT INTO  lead VALUES 	('Le1239',	'Deborah',	 '9346751820',	'Inactive',	    'Camp13',	'Rep1326');
INSERT INTO  lead VALUES 	('Le1240',	'Bogan',	 '9273648159',	'In progress',	'Camp14',	'Rep1327');
INSERT INTO  lead VALUES 	('Le1241',	'Trisha',	 '9164827350',	'In progress',	'Camp14',	'Rep1328');
INSERT INTO  lead VALUES 	('Le1242',	'Taniya',	 '9037562841',	'In progress',	'Camp16',	'Rep1329');
INSERT INTO  lead VALUES 	('Le1243',	'Zainab',	 '9391827465',	'In progress',	'Camp16',	'Rep1324');
INSERT INTO  lead VALUES 	('Le1244',	'Zara',	     '9283647150',	'In progress',	'Camp16',	'Rep1325');
INSERT INTO  lead VALUES 	('Le1245',	'Anish',	 '9152736489',	'In progress',	'Camp17',	'Rep1326');
INSERT INTO  lead VALUES 	('Le1246',	'Dinesh',	 '9046827351',	'Inactive',	    'Camp17',	'Rep1327');
INSERT INTO  lead VALUES 	('Le1247',	'Martin',	 '9374651829',	'In progress',	'Camp18',	'Rep1324');
INSERT INTO  lead VALUES 	('Le1248',	'Camelia',	 '9218364750',	'In progress',	'Camp17',	'Rep1325');
INSERT INTO  lead VALUES 	('Le1249',	'Tamarai',	 '9102736485',	'In progress',	'Camp19',	'Rep1326');
INSERT INTO  lead VALUES 	('Le1250',	'John',	     '9327465180',	'Inactive',	    'Camp20',	'Rep1328');
INSERT INTO  lead VALUES 	('Le1251',	'Madhumitha','9193847265',	'In progress',	'Camp20',	'Rep1329');
INSERT INTO  lead VALUES 	('Le1252',	'Varghese',	 '9061728345',	'In progress',	'Camp23',	'Rep1324');
INSERT INTO  lead VALUES 	('Le1253',	'Nima',	     '9253647182',	'Inactive',	    'Camp21',	'Rep1325');
INSERT INTO  lead VALUES 	('Le1254',	'Aadhavan',	 '9146382750',	'Inactive',	    'Camp25',	'Rep1324');
INSERT INTO  lead VALUES 	('Le1255',	'Thanuja',	 '9284751639',	'In progress',	'Camp21',	'Rep1329');
INSERT INTO  lead VALUES 	('Le1256',	'Andrea',	 '9362817450',	'Inactive',	    'Camp27',	'Rep1329');
INSERT INTO  lead VALUES 	('Le1257',	'Joseph' ,	 '9053746182',	'Inactive',	    'Camp28',	'Rep1328');
INSERT INTO  lead VALUES 	('Le1258',	'Anthony' ,	 '9174628350',	'In progress',	'Camp29',	'Rep1324');
INSERT INTO  lead VALUES 	('Le1259',	'Marissa',	 '9348752160',	'Inactive',	    'Camp30',	'Rep1325');
INSERT INTO  lead VALUES 	('Le1260',	'Ilamaran',	 '9193574628',	'Inactive',	    'Camp31',	'Rep1327');
INSERT INTO  lead VALUES 	('Le1261',	'Amudhan',	 '9247361853',	'In progress',	'Camp26',	'Rep1326');
INSERT INTO  lead VALUES 	('Le1262',	'Illaya' ,	 '9126853746',	'Inactive',	    'Camp27',	'Rep1328');
INSERT INTO  lead VALUES 	('Le1263',	'Ellakiya',	 '9061827458',	'Inactive',	    'Camp27',	'Rep1329');
INSERT INTO  lead VALUES 	('Le1264',	'Malavika',	 '9317648257',	'In progress',	'Camp25',	'Rep1327');
INSERT INTO  lead VALUES 	('Le1265',	'Samuel',	 '9182457369',	'Inactive',	    'Camp31',	'Rep1325');
INSERT INTO  lead VALUES 	('Le1266',	'Devan',     '9045736815',	'In progress',	'Camp30',	'Rep1324');	


--SELECT * FROM lead;
--DESC lead;
--TO_DATE( ,DD-Mon-YYYYY)
--


-------------------------4
---client table with set up primary and foreign keys 
CREATE TABLE client ( client_id         VARCHAR(8),
                      gender            VARCHAR(10),
                      dob               DATE,
                      profession        VARCHAR(20),
                      lead_id           VARCHAR(8),
                      blood_grp         VARCHAR(3),
CONSTRAINT client_pk PRIMARY KEY (client_id),
CONSTRAINT client_leadid_fk FOREIGN KEY (lead_id) REFERENCES lead (lead_id));

INSERT INTO  client VALUES ('CL-18474', 'male',   '2003-07-21'::DATE,  'Student',    'Le1234', 'b+');
INSERT INTO  client VALUES('CL-18475',  'male',   '1988-02-03'::DATE,    'Analyst',    'Le1238', 'o-');
INSERT INTO  client VALUES ('CL-18476', 'female', '1989-04-14'::DATE,   'Teacher',    'Le1235', 'b-');
INSERT INTO  client VALUES ('CL-18477', 'male',   '2002-01-10'::DATE,   'IT Manager', 'Le1247', 'ab+');
INSERT INTO  client VALUES ('CL-18478', 'female', '1992-05-29'::DATE,   'Professor',  'Le1241', 'a+');
INSERT INTO  client VALUES ('CL-18479', 'female', '1997-04-07'::DATE,     'Student',	 'Le1243', 'b-');
INSERT INTO  client VALUES ('CL-18480', 'female', '2004-11-18'::DATE,   'Student',    'Le1244', 'b+');
INSERT INTO  client VALUES ('CL-18481', 'male',   '1990-10-25'::DATE,   'Analyst',    'Le1252', 'a+');
INSERT INTO  client VALUES ('CL-18482', 'female', '1987-01-05'::DATE,    'Retired',    'Le1249', 'a-');
INSERT INTO  client VALUES ('CL-18483', 'female', '1989-12-30'::DATE,    'Professor',  'Le1255', 'ab-');
INSERT INTO  client VALUES ('CL-18484', 'female', '1985-03-12'::DATE,    'IT Manager', 'Le1264', 'a+');
INSERT INTO  client VALUES ('CL-18485',	'male',	  '1994-03-04'::DATE,    'Analyst',    'Le1258', 'o+');
INSERT INTO  client VALUES ('CL-18486',	'male',	  '1995-07-16'::DATE,    'Teacher',    'Le1261', 'o+');
INSERT INTO  client VALUES ('CL-18487',	'male',	  '1988-11-21'::DATE,    'Manager',	 'Le1266', 'b+');
INSERT INTO  client VALUES ('CL-18488',	'male',	  '1986-07-27'::DATE,    'Professor',  'Le1237', 'o+');
INSERT INTO  client VALUES ('CL-18489',	'female', '2001-05-06'::DATE,     'Analyst',    'Le1242', 'ab-');
INSERT INTO  client VALUES ('CL-18490',	'female', '1991-02-17'::DATE,   'IT Manager', 'Le1248', 'o+');
INSERT INTO  client VALUES ('CL-18491',	'female', '1993-09-22'::DATE,   'Teacher',    'Le1251', 'a+');
INSERT INTO  client VALUES ('CL-18492', 'male',   '1990-06-09'::DATE,    'Student',    'Le1240', 'b-');
INSERT INTO  client VALUES ('CL-18493',	'male',	  '1999-10-24'::DATE,    'Professor',  'Le1245', 'b+');


-- final tables corrected
-- membership table 
----------------------------5
----MEMBERSHIP TABLE by setting primary keys and foriegn keys (checked)
CREATE TABLE membership (member_id                VARCHAR(15),
                                mem_type          VARCHAR(15),
                                emergency_contact VARCHAR(10),
                                em_con_name       VARCHAR(15),
                                startdate         DATE,
                                enddate           DATE,
                                status            VARCHAR(15),
                                client_id         VARCHAR(8), 
CONSTRAINT membership_pk PRIMARY KEY (member_id), --corrected
CONSTRAINT membership_clientid_FK FOREIGN KEY (client_id) REFERENCES client (client_id)); -- corrected 

INSERT INTO membership VALUES ('Mem-1743648',  'Monthly',    '9012345678',    'Amit',       '2025-01-11'::DATE, '2025-02-11'::DATE, 'Active',       'CL-18474');
INSERT INTO membership VALUES ('Mem-1743649',  'Annual',     '9023456789',    'Rajan',      '2025-01-16'::DATE, '2026-01-16'::DATE, 'Active',       'CL-18475');
INSERT INTO membership VALUES ('Mem-1743650',  'Quarterly',  '9034567890',    'Ganesh',     '2025-01-16'::DATE, '2025-04-16'::DATE, 'Active',       'CL-18476');
INSERT INTO membership VALUES ('Mem-1743651',  'Annual',     '9045678901',    'Stephen',    '2025-01-24'::DATE, '2026-01-24'::DATE, 'Active',       'CL-18477');
INSERT INTO membership VALUES ('Mem-1743652',  'Half-Yearly','9056789012',	  'Mirudula',   '2025-02-15'::DATE, '2025-08-15'::DATE,'Discontinuing','CL-18478');
INSERT INTO membership VALUES ('Mem-1743653',  'Monthly', 	 '9067890123',	  'Jackson',    '2025-01-21'::DATE, '2025-02-21'::DATE, 'Active',       'CL-18479');
INSERT INTO membership VALUES ('Mem-1743654',  'Monthly', 	 '9078901234',	  'Jagadhish',  '2025-02-11'::DATE, '2025-03-11'::DATE, 'Active',       'CL-18480');
INSERT INTO membership VALUES ('Mem-1743655',  'Monthly', 	 '9089012345',	  'Murali',     '2025-02-20'::DATE, '2025-03-20'::DATE, 'Active',       'CL-18481');
INSERT INTO membership VALUES ('Mem-1743656',  'Annual',     '9090123456',    'Mohanapriya','2025-02-28'::DATE, '2026-02-28'::DATE, 'Inactive',     'CL-18482');
INSERT INTO membership VALUES ('Mem-1743657',  'Annual', 	 '9101234567',	  'Pritam',     '2025-03-09'::DATE,  '2026-03-09'::DATE,  'Active',       'CL-18483');
INSERT INTO membership VALUES ('Mem-1743658',  'Annual', 	 '9112345678',	  'Anajali',    '2025-03-14'::DATE, '2026-03-14'::DATE, 'Inactive',     'CL-18484');
INSERT INTO membership VALUES ('Mem-1743659',  'Half-Yearly','9123456789',	  'Muhammed',   '2025-03-20'::DATE, '2025-09-20'::DATE, 'Active',       'CL-18485');
INSERT INTO membership VALUES ('Mem-1743660',  'Quarterly',  '9134567890',	  'Krish',      '2025-03-23'::DATE, '2025-06-23'::DATE, 'Discontinuing','CL-18486');
INSERT INTO membership VALUES ('Mem-1743661',  'Monthly',    '9145678901',	  'Selva', 	    '2025-03-23'::DATE, '2025-04-23'::DATE, 'Active',       'CL-18487');
INSERT INTO membership VALUES ('Mem-1743662',  'Annual', 	 '9156789012',	  'Raghu',	    '2025-03-27'::DATE, '2026-03-27'::DATE, 'Inactive',     'CL-18488');
INSERT INTO membership VALUES ('Mem-1743663',  'Quarterly',	 '9167890123',	  'Arandhana',  '2025-04-12'::DATE, '2025-07-12'::DATE, 'Active',       'CL-18489');
INSERT INTO membership VALUES ('Mem-1743664',  'Quarterly',	 '9178901234',	  'Ankita',	    '2025-04-19'::DATE, '2025-07-19'::DATE, 'Active',       'CL-18490');
INSERT INTO membership VALUES ('Mem-1743665',  'Annual', 	 '9189012345',	  'Revi',	    '2025-04-20'::DATE, '2026-04-20'::DATE, 'Inactive',	    'CL-18491');
INSERT INTO membership VALUES ('Mem-1743666',  'Annual', 	 '9212345678',	  'Pradeep',	'2025-05-15'::DATE, '2026-05-15'::DATE, 'Active',	    'CL-18492');
INSERT INTO membership VALUES ('Mem-1743667',  'Monthly', 	 '9223456789',	  'Krup',	    '2025-04-25'::DATE, '2025-05-25'::DATE, 'Discontinuing','CL-18493');







--add tables 

---------------------------------6 corrected 
--trial appointment table 
-- orginal table had column name date which is not possible here 

CREATE TABLE trial_appointment (app_id     VARCHAR(10),
                                trial_date DATE,
                                outcome    VARCHAR(15),
                                feedback   VARCHAR(30),
                                lead_id    VARCHAR(8),
CONSTRAINT appid_PK PRIMARY KEY (app_id),
CONSTRAINT app_leadid_FK FOREIGN KEY (lead_id) REFERENCES lead (lead_id));

INSERT INTO trial_appointment VALUES ('App-747643',  '2025-01-08'::DATE,	'Attended', 'Qualified Instructors', 'Le1234');
INSERT INTO trial_appointment VALUES ('App-747644',  '2025-01-09'::DATE,   'Attended', 'Good atmosphere',       'Le1235');
INSERT INTO trial_appointment VALUES ('App-747645',  '2025-01-14'::DATE,  'No Show',  'None',                  'Le1236');
INSERT INTO trial_appointment VALUES ('App-747646',  '2025-01-17'::DATE,  'No Show',  'No response',           'Le1239');
INSERT INTO trial_appointment VALUES ('App-747647',  '2025-01-15'::DATE,  'Attended', 'Top equipment',         'Le1237');
INSERT INTO trial_appointment VALUES ('App-747648',  '2025-02-10'::DATE,  'Attended', 'Good atmosphere',       'Le1238');
INSERT INTO trial_appointment VALUES ('App-747649',  '2025-02-10'::DATE,  'Attended', 'Qualified Instructors', 'Le1240');
INSERT INTO trial_appointment VALUES ('App-747650',  '2025-02-10'::DATE,  'Attended', 'Good atmosphere',       'Le1241');
INSERT INTO trial_appointment VALUES ('App-747651',  '2025-02-22'::DATE,	'Attended', 'Top equipment',	     'Le1242');
INSERT INTO trial_appointment VALUES ('App-747652',  '2025-03-06'::DATE,	'Attended', 'Qualified Instructors', 'Le1243');
INSERT INTO trial_appointment VALUES ('App-747653',  '2025-03-06'::DATE,	'Attended', 'Top equipment',	     'Le1244');
INSERT INTO trial_appointment VALUES ('App-747654',  '2025-03-16'::DATE,	'No show' , 'None',	                 'Le1246');
INSERT INTO trial_appointment VALUES ('App-747655',  '2025-03-18'::DATE,	'Attended' ,'Top equipment',	     'Le1245');
INSERT INTO trial_appointment VALUES ('App-747656',  '2025-03-18'::DATE,	'Attended',	'Top equipment',	     'Le1247');
INSERT INTO trial_appointment VALUES ('App-747657',  '2025-03-18'::DATE,	'Attended',	'Qualified Instructors', 'Le1248');
INSERT INTO trial_appointment VALUES ('App-747658',  '2025-04-08'::DATE,	'Attended',	'Good atmosphere',	     'Le1249');
INSERT INTO trial_appointment VALUES ('App-747659',  '2025-04-13'::DATE,	'No show',	'No response',	         'Le1250');
INSERT INTO trial_appointment VALUES ('App-747660',  '2025-04-19'::DATE,	'Attended',	'Joined',	             'Le1251');
INSERT INTO trial_appointment VALUES ('App-747661',  '2025-04-22'::DATE,	'No show',	'No response',	         'Le1253');
INSERT INTO trial_appointment VALUES ('App-747662',  '2025-05-05'::DATE,	'Attended',	'Joined',	             'Le1252');
INSERT INTO trial_appointment VALUES ('App-747663',  '2025-05-18'::DATE,	'Attended',	'Joined',	             'Le1255');
INSERT INTO trial_appointment VALUES ('App-747664',  '2025-05-23'::DATE,	'Attended',	'No response' ,	         'Le1254');
INSERT INTO trial_appointment VALUES ('App-747665',  '2025-06-18'::DATE,	'No show',	'No response',           'Le1257');
INSERT INTO trial_appointment VALUES ('App-747666',  '2025-06-20'::DATE,	'Attended',	'Joined',	             'Le1258');
INSERT INTO trial_appointment VALUES ('App-747667',  '2025-06-01'::DATE,	'Attended',	'Good atmosphere', 	     'Le1261');
INSERT INTO trial_appointment VALUES ('App-747668',  '2025-06-07'::DATE,	'Attended',	'Qualified Instructors', 'Le1256');
INSERT INTO trial_appointment VALUES ('App-747669',  '2025-06-09'::DATE,	'No show',	'Not Interested',        'Le1263');
INSERT INTO trial_appointment VALUES ('App-747670',  '2025-06-08'::DATE,	'No show',	'None',	                 'Le1262');
INSERT INTO trial_appointment VALUES ('App-747671',  '2025-06-10'::DATE,	'Attended',	'Converted',	         'Le1264');
INSERT INTO trial_appointment VALUES ('App-747672',  '2025-07-05'::DATE,	'Attended',	'Not Interested',        'Le1259');
INSERT INTO trial_appointment VALUES ('App-747673',  '2025-07-10'::DATE,	'Attended',	'Good atmosphere',	     'Le1266');
INSERT INTO trial_appointment VALUES ('App-747674',  '2025-07-12'::DATE,	'No show',	'Interested',	         'Le1265');
INSERT INTO trial_appointment VALUES ('App-747675',  '2025-07-13'::DATE,	'No show',	'Not Interested',        'Le1260');

COMMIT;


--SELECT * FROM campaign;
--------------------------------------------------------QUERIES------------------------------------------------------
/*
--QUERY 01:
--Find the list of leads who are female and works as analyst additionally find out their membership details if they are a members
SELECT lead.name, client.profession, membership.member_id, client.blood_grp, UPPER(client. gender)
FROM lead
INNER JOIN client
        ON lead.lead_id = client.lead_id
INNER JOIN membership 
        On client.client_id = membership.client_id
WHERE gender = 'female' AND profession = 'Analyst' OR  gender = 'female' AND lower(profession) LIKE '%it manager%' ;


--QUERY02 
--Find out Campaigns that had no leads and their platforms and was a wasted marketing effort 
SELECT c.campaign_id, c.platform, c.cost,  l.lead_id
FROM lead l
RIGHT OUTER JOIN campaign c ON l.campaign_id = c.campaign_id
WHERE l.lead_id IS NULL


--Query03: -- Find out the number of leads who had booked an appointment to try the service and ended up as a client 

SELECT  lead_id
FROM    trial_appointment


INTERSECT

SELECT  lead_id
FROM    client


--QUERY04: Find all clients who are born before 1990 (supports in distinguishing different age groups or isolate an age group to support batches or to help with meal plan)
SELECT *
FROM client 

MINUS

SELECT *
FROM client 
WHERE DOB >= '1990-01-01'::DATE


--Query05:Collect campaigns where the cost was more than 2000 and lead output was lower than 2
--Helps Business to identify spending on campaigns that are less effective
--Collect campaigns where the cost was more than 1200 and lead output was lower

SELECT count(lead_id) AS Total_leads, lead.campaign_id, cost, platform
FROM lead
INNER JOIN campaign
        ON lead.campaign_id = campaign.campaign_id
WHERE cost > 1200 
GROUP BY lead.campaign_id, cost, platform
HAVING count(lead_id) <2
ORDER BY count(lead_id)


--Query06: Find the trends in various  platform and show the number of leads that has been generated on each platform
SELECT count(lead_ID) AS Total_Leads, platform
FROM lead 
INNER JOIN campaign
        ON lead.campaign_id = campaign.campaign_id
GROUP BY platform
HAVING count(lead_ID) > 3
ORDER BY count(platform) DESC;


--Query07: (Sub query)
--Helps in analyzing sales reps who have been assigned more than 5 leads or analyse performance 

SELECT *
FROM lead
WHERE  UPPER(followup_status) = 'IN PROGRESS' AND rep_id IN (
                                                            SELECT rep_id
                                                            FROM lead
                                                            GROUP BY rep_id
                                                            HAVING COUNT(lead_id) > 5) */
       





