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
--Add Purge RecycleBin; and Commit; statements as seen in cretabs.sql 
-- Alignment check
--
--
--
--
--
--
-------------------------------------------------------------------------------


DROP TABLE campaign CASCADE constraints;
DROP TABLE lead CASCADE constraints;
DROP TABLE client CASCADE constraints;
DROP TABLE membership CASCADE constraints;
DROP TABLE sales CASCADE constraints;
DROP TABLE trial_appointment CASCADE constraints;



Purge RecycleBin; -- adding so that the recycle bin is cleared

--------------> 1
--Creating a table campaign and establishing a primary key and ensuring that end date is greater than start date.

CREATE TABLE campaign ( campaign_id VARCHAR2(10),
                        start_date  DATE,
                        end_date    DATE,
                        cost        NUMBER(5),
                        ad          VARCHAR2(7),
                        platform    VARCHAR2(15),
CONSTRAINT campaign_pk PRIMARY KEY (campaign_id),
CONSTRAINT campaign_end_date_chk CHECK (end_date > start_date));
INSERT INTO campaign VALUES('Camp12', TO_DATE('1-Jan-25','DD-Mon-YYYY'),     TO_DATE('19-Jan-25',   'DD-Mon-YYYY'), 2200, 'AD102', 'Instagram');
INSERT INTO campaign VALUES('Camp13', TO_DATE('19-Jan-25','DD-Mon-YYYY'),    TO_DATE('30-Jan-25',   'DD-Mon-YYYY'), 1800, 'AD103', 'Instagram');
INSERT INTO campaign VALUES('Camp14', TO_DATE('5-Feb-25', 'DD-Mon-YYYY'),    TO_DATE('16-Feb-25',   'DD-Mon-YYYY'), 2500, 'AD104', 'Facebook');
INSERT INTO campaign VALUES('Camp15', TO_DATE('16-Feb-2025','dd-Mon-YYYY'),  TO_DATE('28-Feb-2025', 'DD-Mon-YYYY'), 1300, 'AD105', 'Privyr');
INSERT INTO campaign VALUES('Camp16', TO_DATE('1-Mar-2025', 'DD-Mon-YYYY'),  TO_DATE('10-Mar-2025', 'DD-Mon-YYYY'), 2100, 'AD106', 'Privyr');
INSERT INTO campaign VALUES('Camp17', TO_DATE('15-Mar-2025', 'DD-Mon-YYYY'), TO_DATE('18-Mar-2025', 'DD-Mon-YYYY'), 1950, 'AD107', 'Facebook');
INSERT INTO campaign VALUES('Camp18', TO_DATE('14-Mar-2025','DD-Mon-YYYY'),  TO_DATE('20-Mar-2025', 'DD-Mon-YYYY'), 2400, 'AD102', 'Instagram');
INSERT INTO campaign VALUES('Camp19', TO_DATE('2-Apr-2025', 'DD-Mon-YYYY'),  TO_DATE('10-Apr-2025', 'DD-Mon-YYYY'), 1600, 'AD109', 'Privyr');
INSERT INTO campaign VALUES('Camp20', TO_DATE('11-Apr-2025','DD-Mon-YYYY'),  TO_DATE('18-Apr-2025', 'DD-Mon-YYYY'), 2750, 'AD110', 'Facebook');
INSERT INTO campaign VALUES('Camp21', TO_DATE('19-Apr-2025','DD-Mon-YYYY'),  TO_DATE('25-Apr-2025', 'DD-Mon-YYYY'), 1200, 'AD111', 'Instagram');
INSERT INTO campaign VALUES('Camp22', TO_DATE('26-Apr-2025','DD-Mon-YYYY'),  TO_DATE('30-Apr-2025', 'DD-Mon-YYYY'), 2050, 'AD102', 'Privyr');
INSERT INTO campaign VALUES('Camp23', TO_DATE('1-May-2025', 'DD-Mon-YYYY'),  TO_DATE('9-May-2025',  'DD-Mon-YYYY'), 1700, 'AD113', 'Facebook');
INSERT INTO campaign VALUES('Camp24', TO_DATE('10-May-2025','DD-Mon-YYYY'),  TO_DATE('18-May-2025', 'DD-Mon-YYYY'), 2300, 'AD114', 'Instagram');
INSERT INTO campaign VALUES('Camp25', TO_DATE('19-May-2025','DD-Mon-YYYY'),  TO_DATE('28-May-2025', 'DD-Mon-YYYY'), 1900, 'AD115', 'Facebook');
INSERT INTO campaign VALUES('Camp26', TO_DATE('29-May-2025','DD-Mon-YYYY'),  TO_DATE('5-Jun-2025',  'DD-Mon-YYYY'), 2600, 'AD116', 'Privyr');
INSERT INTO campaign VALUES('Camp27', TO_DATE('6-Jun-2025','DD-Mon-YYYY'),   TO_DATE('14-Jun-2025', 'DD-Mon-YYYY'), 1450, 'AD117', 'Instagram');
INSERT INTO campaign VALUES('Camp28', TO_DATE('15-Jun-2025','DD-Mon-YYYY'),  TO_DATE('22-Jun-2025', 'DD-Mon-YYYY'), 2100, 'AD104', 'Facebook');
INSERT INTO campaign VALUES('Camp29', TO_DATE('23-Jun-2025','DD-Mon-YYYY'),  TO_DATE('30-Jun-2025', 'DD-Mon-YYYY'), 1850, 'AD119', 'Instagram');
INSERT INTO campaign VALUES('Camp30', TO_DATE('1-Jul-2025','DD-Mon-YYYY'),   TO_DATE('8-Jul-2025',  'DD-Mon-YYYY'), 2400, 'AD120', 'Instagram');
INSERT INTO campaign VALUES('Camp31', TO_DATE('9-Jul-2025','DD-Mon-YYYY'),   TO_DATE('17-Jul-2025', 'DD-Mon-YYYY'), 5000, 'AD105', 'Privyr');

--SELECT * FROM campaign;
--Desc campaign	


--------------------> 2
-- 2 Creating SALES TABLE and setting primary key 

CREATE TABLE sales ( rep_id VARCHAR2(12),
                     name VARCHAR2(15),
                     email VARCHAR2(30),
                     phone VARCHAR2(10),
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
CREATE TABLE lead (lead_id         VARCHAR2 (8),
                   name            VARCHAR2(15),
                   phone           VARCHAR2(10),
                   followup_status VARCHAR2(15),
                   campaign_id     VARCHAR2(10),
                   rep_id          VARCHAR2(12),
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
CREATE TABLE client ( client_id         VARCHAR2(8),
                      gender            VARCHAR2(10),
                      dob               DATE,
                      profession        VARCHAR2(20),
                      lead_id           VARCHAR2(8),
                      blood_grp         VARCHAR2(3),
CONSTRAINT client_pk PRIMARY KEY (client_id),
CONSTRAINT client_leadid_fk FOREIGN KEY (lead_id) REFERENCES lead (lead_id));

INSERT INTO  client VALUES ('CL-18474', 'male',   TO_DATE( '21-Jul-2003', 'DD-Mon-YYYY'),  'Student',    'Le1234', 'b+');
INSERT INTO  client VALUES('CL-18475',  'male',   TO_DATE('3-Feb-1988', 'DD-Mon-YYYY'),    'Analyst',    'Le1238', 'o-');
INSERT INTO  client VALUES ('CL-18476', 'female', TO_DATE('14-Apr-1989', 'DD-Mon-YYYY'),   'Teacher',    'Le1235', 'b-');
INSERT INTO  client VALUES ('CL-18477', 'male',   TO_DATE('10-Jan-2002', 'DD-Mon-YYYY'),   'IT Manager', 'Le1247', 'ab+');
INSERT INTO  client VALUES ('CL-18478', 'female', TO_DATE('29-May-1992', 'DD-Mon-YYYY'),   'Professor',  'Le1241', 'a+');
INSERT INTO  client VALUES ('CL-18479', 'female', TO_DATE('7-Apr-1997','DD-Mon-YYYY'),     'Student',	 'Le1243', 'b-');
INSERT INTO  client VALUES ('CL-18480', 'female', TO_DATE ('18-Nov-2004','DD-Mon-YYYY'),   'Student',    'Le1244', 'b+');
INSERT INTO  client VALUES ('CL-18481', 'male',   TO_DATE('25-Oct-1990', 'DD-Mon-YYYY'),   'Analyst',    'Le1252', 'a+');
INSERT INTO  client VALUES ('CL-18482', 'female', TO_DATE('5-Jan-1987', 'DD-Mon-YYYY'),    'Retired',    'Le1249', 'a-');
INSERT INTO  client VALUES ('CL-18483', 'female', TO_DATE('30-Dec-1989','DD-Mon-YYYY'),    'Professor',  'Le1255', 'ab-');
INSERT INTO  client VALUES ('CL-18484', 'female', TO_DATE('12-Mar-1985','DD-Mon-YYYY'),    'IT Manager', 'Le1264', 'a+');
INSERT INTO  client VALUES ('CL-18485',	'male',	  TO_DATE('4-Mar-1994', 'DD-Mon-YYYY'),    'Analyst',    'Le1258', 'o+');
INSERT INTO  client VALUES ('CL-18486',	'male',	  TO_DATE('16-Jul-1995','DD-Mon-YYYY'),    'Teacher',    'Le1261', 'o+');
INSERT INTO  client VALUES ('CL-18487',	'male',	  TO_DATE('21-Nov-1988','DD-Mon-YYYY'),    'Manager',	 'Le1266', 'b+');
INSERT INTO  client VALUES ('CL-18488',	'male',	  TO_DATE('27-Jul-1986','DD-Mon-YYYY'),    'Professor',  'Le1237', 'o+');
INSERT INTO  client VALUES ('CL-18489',	'female', TO_DATE('6-May-2001','DD-Mon-YYYY'),     'Analyst',    'Le1242', 'ab-');
INSERT INTO  client VALUES ('CL-18490',	'female', TO_DATE('17-Feb-1991', 'DD-Mon-YYYY'),   'IT Manager', 'Le1248', 'o+');
INSERT INTO  client VALUES ('CL-18491',	'female', TO_DATE('22-Sep-1993', 'DD-Mon-YYYY'),   'Teacher',    'Le1251', 'a+');
INSERT INTO  client VALUES ('CL-18492', 'male',   TO_DATE('9-Jun-1990', 'DD-Mon-YYYY'),    'Student',    'Le1240', 'b-');
INSERT INTO  client VALUES ('CL-18493',	'male',	  TO_DATE('24-Oct-1999','DD-Mon-YYYY'),    'Professor',  'Le1245', 'b+');


-- final tables corrected
-- membership table 
----------------------------5
----MEMBERSHIP TABLE by setting primary keys and foriegn keys (checked)
CREATE TABLE membership (member_id                VARCHAR2(15),
                                mem_type          VARCHAR2(15),
                                emergency_contact VARCHAR2(10),
                                em_con_name       VARCHAR2(15),
                                startdate         DATE,
                                enddate           DATE,
                                status            VARCHAR2(15),
                                client_id         VARCHAR2(8), 
CONSTRAINT membership_pk PRIMARY KEY (member_id), --corrected
CONSTRAINT membership_clientid_FK FOREIGN KEY (client_id) REFERENCES client (client_id)); -- corrected 

INSERT INTO membership VALUES ('Mem-1743648',  'Monthly',    '9012345678',    'Amit',       TO_DATE('11-Jan-2025','DD-Mon-YYYY'), TO_DATE('11-Feb-2025','DD-Mon-YYYY'), 'Active',       'CL-18474');
INSERT INTO membership VALUES ('Mem-1743649',  'Annual',     '9023456789',    'Rajan',      TO_DATE('16-Jan-2025','DD-Mon-YYYY'), TO_DATE('16-Jan-2026','DD-Mon-YYYY'), 'Active',       'CL-18475');
INSERT INTO membership VALUES ('Mem-1743650',  'Quarterly',  '9034567890',    'Ganesh',     TO_DATE('16-Jan-2025','DD-Mon-YYYY'), TO_DATE('16-Apr-2025','DD-Mon-YYYY'), 'Active',       'CL-18476');
INSERT INTO membership VALUES ('Mem-1743651',  'Annual',     '9045678901',    'Stephen',    TO_DATE('24-Jan-2025','DD-Mon-YYYY'), TO_DATE('24-Jan-2026','DD-Mon-YYYY'), 'Active',       'CL-18477');
INSERT INTO membership VALUES ('Mem-1743652',  'Half-Yearly','9056789012',	  'Mirudula',   TO_DATE('15-Feb-2025','DD-Mon-YYYY'), TO_DATE('15-Aug-2025' ,'DD-Mon-YYYY'),'Discontinuing','CL-18478');
INSERT INTO membership VALUES ('Mem-1743653',  'Monthly', 	 '9067890123',	  'Jackson',    TO_DATE('21-Jan-2025','DD-Mon-YYYY'), TO_DATE('21-Feb-2025','DD-Mon-YYYY'), 'Active',       'CL-18479');
INSERT INTO membership VALUES ('Mem-1743654',  'Monthly', 	 '9078901234',	  'Jagadhish',  TO_DATE('11-Feb-2025','DD-Mon-YYYY'), TO_DATE('11-Mar-2025','DD-Mon-YYYY'), 'Active',       'CL-18480');
INSERT INTO membership VALUES ('Mem-1743655',  'Monthly', 	 '9089012345',	  'Murali',     TO_DATE('20-Feb-2025','DD-Mon-YYYY'), TO_DATE('20-Mar-2025','DD-Mon-YYYY'), 'Active',       'CL-18481');
INSERT INTO membership VALUES ('Mem-1743656',  'Annual',     '9090123456',    'Mohanapriya',TO_DATE('28-Feb-2025','DD-Mon-YYYY'), TO_DATE('28-Feb-2026','DD-Mon-YYYY'), 'Inactive',     'CL-18482');
INSERT INTO membership VALUES ('Mem-1743657',  'Annual', 	 '9101234567',	  'Pritam',     TO_DATE('9-Mar-2025','DD-Mon-YYYY'),  TO_DATE('9-Mar-2026','DD-Mon-YYYY'),  'Active',       'CL-18483');
INSERT INTO membership VALUES ('Mem-1743658',  'Annual', 	 '9112345678',	  'Anajali',    TO_DATE('14-Mar-2025','DD-Mon-YYYY'), TO_DATE('14-Mar-2026','DD-Mon-YYYY'), 'Inactive',     'CL-18484');
INSERT INTO membership VALUES ('Mem-1743659',  'Half-Yearly','9123456789',	  'Muhammed',   TO_DATE('20-Mar-2025','DD-Mon-YYYY'), TO_DATE('20-Sep-2025','DD-Mon-YYYY'), 'Active',       'CL-18485');
INSERT INTO membership VALUES ('Mem-1743660',  'Quarterly',  '9134567890',	  'Krish',      TO_DATE('23-Mar-2025','DD-Mon-YYYY'), TO_DATE('23-Jun-2025','DD-Mon-YYYY'), 'Discontinuing','CL-18486');
INSERT INTO membership VALUES ('Mem-1743661',  'Monthly',    '9145678901',	  'Selva', 	    TO_DATE('23-Mar-2025','DD-Mon-YYYY'), TO_DATE('23-Apr-2025','DD-Mon-YYYY'), 'Active',       'CL-18487');
INSERT INTO membership VALUES ('Mem-1743662',  'Annual', 	 '9156789012',	  'Raghu',	    TO_DATE('27-Mar-2025','DD-Mon-YYYY'), TO_DATE('27-Mar-2026','DD-Mon-YYYY'), 'Inactive',     'CL-18488');
INSERT INTO membership VALUES ('Mem-1743663',  'Quarterly',	 '9167890123',	  'Arandhana',  TO_DATE('12-Apr-2025','DD-Mon-YYYY'), TO_DATE('12-Jul-2025','DD-Mon-YYYY'), 'Active',       'CL-18489');
INSERT INTO membership VALUES ('Mem-1743664',  'Quarterly',	 '9178901234',	  'Ankita',	    TO_DATE('19-Apr-2025','DD-Mon-YYYY'), TO_DATE('19-Jul-2025','DD-Mon-YYYY'), 'Active',       'CL-18490');
INSERT INTO membership VALUES ('Mem-1743665',  'Annual', 	 '9189012345',	  'Revi',	    TO_DATE('20-Apr-2025','DD-Mon-YYYY'), TO_DATE('20-Apr-2026','DD-Mon-YYYY'), 'Inactive',	    'CL-18491');
INSERT INTO membership VALUES ('Mem-1743666',  'Annual', 	 '9212345678',	  'Pradeep',	TO_DATE('15-May-2025','DD-Mon-YYYY'), TO_DATE('15-May-2026','DD-Mon-YYYY'), 'Active',	    'CL-18492');
INSERT INTO membership VALUES ('Mem-1743667',  'Monthly', 	 '9223456789',	  'Krup',	    TO_DATE('25-Apr-2025','DD-Mon-YYYY'), TO_DATE('25-May-2025','DD-Mon-YYYY'), 'Discontinuing','CL-18493');







--add tables 

---------------------------------6 corrected 
--trial appointment table 
-- orginal table had column name date which is not possible here 

CREATE TABLE trial_appointment (app_id     VARCHAR2(10),
                                trial_date DATE,
                                outcome    VARCHAR2(15),
                                feedback   VARCHAR2(30),
                                lead_id    VARCHAR2(8),
CONSTRAINT appid_PK PRIMARY KEY (app_id),
CONSTRAINT app_leadid_FK FOREIGN KEY (lead_id) REFERENCES lead (lead_id));

INSERT INTO trial_appointment VALUES ('App-747643',  TO_DATE('8-Jan-2025','DD-Mon-YYYY'),	'Attended', 'Qualified Instructors', 'Le1234');
INSERT INTO trial_appointment VALUES ('App-747644',  TO_DATE('9-Jan-2025','DD-Mon-YYYY'),   'Attended', 'Good atmosphere',       'Le1235');
INSERT INTO trial_appointment VALUES ('App-747645',  TO_DATE('14-Jan-2025','DD-Mon-YYYY'),  'No Show',  'None',                  'Le1236');
INSERT INTO trial_appointment VALUES ('App-747646',  TO_DATE('17-Jan-2025','DD-Mon-YYYY'),  'No Show',  'No response',           'Le1239');
INSERT INTO trial_appointment VALUES ('App-747647',  TO_DATE('15-Jan-2025','DD-Mon-YYYY'),  'Attended', 'Top equipment',         'Le1237');
INSERT INTO trial_appointment VALUES ('App-747648',  TO_DATE('10-Feb-2025','DD-Mon-YYYY'),  'Attended', 'Good atmosphere',       'Le1238');
INSERT INTO trial_appointment VALUES ('App-747649',  TO_DATE('10-Feb-2025','DD-Mon-YYYY'),  'Attended', 'Qualified Instructors', 'Le1240');
INSERT INTO trial_appointment VALUES ('App-747650',  TO_DATE('10-Feb-2025','DD-Mon-YYYY'),  'Attended', 'Good atmosphere',       'Le1241');
INSERT INTO trial_appointment VALUES ('App-747651',  TO_DATE('22-Feb-2025','DD-Mon-YYYY'),	'Attended', 'Top equipment',	     'Le1242');
INSERT INTO trial_appointment VALUES ('App-747652',  TO_DATE('6-Mar-2025','DD-Mon-YYYY'),	'Attended', 'Qualified Instructors', 'Le1243');
INSERT INTO trial_appointment VALUES ('App-747653',  TO_DATE('6-Mar-2025', 'DD-Mon-YYYY'),	'Attended', 'Top equipment',	     'Le1244');
INSERT INTO trial_appointment VALUES ('App-747654',  TO_DATE('16-Mar-2025','DD-Mon-YYYY'),	'No show' , 'None',	                 'Le1246');
INSERT INTO trial_appointment VALUES ('App-747655',  TO_DATE('18-Mar-2025','DD-Mon-YYYY'),	'Attended' ,'Top equipment',	     'Le1245');
INSERT INTO trial_appointment VALUES ('App-747656',  TO_DATE('18-Mar-2025','DD-Mon-YYYY'),	'Attended',	'Top equipment',	     'Le1247');
INSERT INTO trial_appointment VALUES ('App-747657',  TO_DATE('18-Mar-2025','DD-Mon-YYYY'),	'Attended',	'Qualified Instructors', 'Le1248');
INSERT INTO trial_appointment VALUES ('App-747658',  TO_DATE('8-Apr-2025','DD-Mon-YYYY'),	'Attended',	'Good atmosphere',	     'Le1249');
INSERT INTO trial_appointment VALUES ('App-747659',  TO_DATE('13-Apr-2025','DD-Mon-YYYY'),	'No show',	'No response',	         'Le1250');
INSERT INTO trial_appointment VALUES ('App-747660',  TO_DATE('19-Apr-2025','DD-Mon-YYYY'),	'Attended',	'Joined',	             'Le1251');
INSERT INTO trial_appointment VALUES ('App-747661',  TO_DATE('22-Apr-2025','DD-Mon-YYYY'),	'No show',	'No response',	         'Le1253');
INSERT INTO trial_appointment VALUES ('App-747662',  TO_DATE('5-May-2025','DD-Mon-YYYY'),	'Attended',	'Joined',	             'Le1252');
INSERT INTO trial_appointment VALUES ('App-747663',  TO_DATE('18-May-2025','DD-Mon-YYYY'),	'Attended',	'Joined',	             'Le1255');
INSERT INTO trial_appointment VALUES ('App-747664',  TO_DATE('23-May-2025','DD-Mon-YYYY'),	'Attended',	'No response' ,	         'Le1254');
INSERT INTO trial_appointment VALUES ('App-747665',  TO_DATE('18-Jun-2025','DD-Mon-YYYY'),	'No show',	'No response',           'Le1257');
INSERT INTO trial_appointment VALUES ('App-747666',  TO_DATE('20-Jun-2025','DD-Mon-YYYY'),	'Attended',	'Joined',	             'Le1258');
INSERT INTO trial_appointment VALUES ('App-747667',  TO_DATE('1-Jun-2025','DD-Mon-YYYY'),	'Attended',	'Good atmosphere', 	     'Le1261');
INSERT INTO trial_appointment VALUES ('App-747668',  TO_DATE('7-Jun-2025','DD-Mon-YYYY'),	'Attended',	'Qualified Instructors', 'Le1256');
INSERT INTO trial_appointment VALUES ('App-747669',  TO_DATE('9-Jun-2025','DD-Mon-YYYY'),	'No show',	'Not Interested',        'Le1263');
INSERT INTO trial_appointment VALUES ('App-747670',  TO_DATE('8-Jun-2025','DD-Mon-YYYY'),	'No show',	'None',	                 'Le1262');
INSERT INTO trial_appointment VALUES ('App-747671',  TO_DATE('10-Jun-2025','DD-Mon-YYYY'),	'Attended',	'Converted',	         'Le1264');
INSERT INTO trial_appointment VALUES ('App-747672',  TO_DATE('5-Jul-2025','DD-Mon-YYYY'),	'Attended',	'Not Interested',        'Le1259');
INSERT INTO trial_appointment VALUES ('App-747673',  TO_DATE('10-Jul-2025', 'DD-Mon-YYYY'),	'Attended',	'Good atmosphere',	     'Le1266');
INSERT INTO trial_appointment VALUES ('App-747674',  TO_DATE('12-Jul-2025', 'DD-Mon-YYYY'),	'No show',	'Interested',	         'Le1265');
INSERT INTO trial_appointment VALUES ('App-747675',  TO_DATE('13-Jul-2025', 'DD-Mon-YYYY'),	'No show',	'Not Interested',        'Le1260');

Commit;


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
WHERE DOB >= TO_DATE('01-Jan-1990','DD-Mon-YYYY')


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
       





