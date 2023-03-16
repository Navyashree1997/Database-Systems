show databases;
create database security;
use security;
create table USER_ACCOUNT(
    IdNo CHAR(9) NOT NULL ,
    Name VARCHAR(25) NOT NULL ,
    Bdate VARCHAR(25) ,
    Address VARCHAR(50) ,
    Sex CHAR(2) ,
    Phone VARCHAR(12),
    Role_Id CHAR(9),
    PRIMARY KEY (IdNo)
);
CREATE TABLE PRIVILEGES(
    Privilege_Id CHAR(9) NOT NULL ,
    Privileges_Type VARCHAR(20) NOT NULL ,
    UNIQUE (Privileges_Type),
    PRIMARY KEY (Privilege_Id)
);
CREATE TABLE ACCOUNT_PRIVILEGES(
    Account_Id CHAR(9) ,
    Account_Functionality_name VARCHAR(100) NOT NULL ,
    Account_Functionality_desc VARCHAR(100) NOT NULL ,
    Role_id CHAR(9),
    Privilege_Id CHAR(9) NOT NULL ,
    UNIQUE (Account_Functionality_name),
    PRIMARY KEY (Privilege_Id,Account_Id),
    FOREIGN KEY (Privilege_Id) REFERENCES PRIVILEGES (Privilege_Id)
);

CREATE TABLE RELATION_PRIVILEGES(
    Relation_Id CHAR(9),
    Relation_Functionality_name VARCHAR(100) NOT NULL ,
    Relation_Functionality_desc VARCHAR(100) NOT NULL ,
    Role_id CHAR(9),
    Privilege_Id CHAR(9) NOT NULL ,
    UNIQUE (Relation_Functionality_name),
    PRIMARY KEY (Privilege_Id,Relation_Id),
    FOREIGN KEY (Privilege_Id) REFERENCES PRIVILEGES (Privilege_Id)
);
CREATE TABLE USER_ROLE(
    Role_id CHAR(9) NOT NULL ,
    Role_name VARCHAR(25) NOT NULL ,
    Description VARCHAR(100) NOT NULL ,
    PRIMARY KEY (Role_id),
    UNIQUE (Role_name)
);
ALTER TABLE USER_ACCOUNT ADD FOREIGN KEY (Role_id) REFERENCES USER_ROLE (Role_id);
ALTER TABLE ACCOUNT_PRIVILEGES ADD FOREIGN KEY (Role_id) REFERENCES USER_ROLE (Role_id);
ALTER TABLE RELATION_PRIVILEGES ADD FOREIGN KEY (Role_id) REFERENCES USER_ROLE (Role_id);
CREATE TABLE Tables1(
    Table_id CHAR(9) NOT NULL ,
    Table_name VARCHAR(25) NOT NULL ,
    Description VARCHAR(100) NOT NULL ,
    IdNo CHAR(9) ,
    UNIQUE (Table_name),
    PRIMARY KEY (Table_id),
    FOREIGN KEY (IdNo) REFERENCES USER_ACCOUNT (IdNo)
);

CREATE TABLE HAS_ON(
    Table_id CHAR(9)  ,
    Role_id CHAR(9) ,
    Relation_Id CHAR(9) ,
    Privilege_Id CHAR(9),
    Description VARCHAR(100) NOT NULL ,
    PRIMARY KEY (Table_id,Role_id,Relation_Id),
    FOREIGN KEY (Table_id) REFERENCES Tables1 (Table_id),
    FOREIGN KEY (Role_id) REFERENCES USER_ROLE (Role_id),
    FOREIGN KEY (Privilege_Id,Relation_Id) REFERENCES RELATION_PRIVILEGES (Privilege_Id,Relation_Id)
);
INSERT INTO USER_ROLE values ("1","db_owner","Owner of schema will perform operations");
INSERT INTO USER_ROLE values ("2","db_admin","Admin provides privileges to add users");
INSERT INTO USER_ROLE values ("3","db_ddl","Will perform basic operations on schema");
INSERT INTO USER_ROLE values ("4","db_analyst","Will read from a particular schema");
INSERT INTO USER_ROLE values ("5","db_banker","Will perform read, write and append for schema");
INSERT INTO USER_ROLE values ("6","db_user","performs task on previlage that is provided by db_admin");
INSERT INTO USER_ACCOUNT values ("1001", "J.Smith","1/2/1997", "700 centennial apt, apt 101", "M", "817-352-6382", "1");
INSERT INTO USER_ACCOUNT values ("1002", "A.Smith","1/3/1997", "700 centennial apt, apt 102", "M", "817-352-6382", "2");
INSERT INTO USER_ACCOUNT values ("1003", "B.Josh","1/12/1997", "700 centennial apt, apt 103", "M", "817-352-6382", "2");
INSERT INTO USER_ACCOUNT values ("1004", "C.Smith","11/13/1997", "700 centennial apt, apt 104", "F", "817-352-6382", "3");
INSERT INTO USER_ACCOUNT values ("1005", "D.Josh","01/12/1997", "709w centennial apt, apt 105", "M", "817-352-6382", "3");
INSERT INTO USER_ACCOUNT values ("1006", "E.Smith","06/16/1997", "709w centennial apt, apt 106", "M", "817-352-6382", "3");
INSERT INTO USER_ACCOUNT values ("1007", "F.Josh","01/1/1998", "709w centennial apt, apt 107", "F", "817-352-6382", "4");
INSERT INTO USER_ACCOUNT values ("1008", "I.Smith","02/1/1999", "709w centennial apt, apt 108", "F", "817-352-6382", "4");
INSERT INTO USER_ACCOUNT values ("1009", "H.Josh","1/1/2000", "709w centennial apt, apt 109", "M", "817-352-6382", "4");
INSERT INTO USER_ACCOUNT values ("1010", "K.Smith","1/21/2001", "709w centennial apt, apt 110", "F", "817-352-6382", "5");
INSERT INTO USER_ACCOUNT values ("1011", "L.Josh","4/1/1997", "709w centennial apt, apt 111", "M", "817-352-6382", "5");
INSERT INTO USER_ACCOUNT values ("1012", "M.Smith","6/08/1996", "709w centennial apt, apt 112", "M", "817-352-6382", "5");
INSERT INTO USER_ACCOUNT values ("1013", "N.Josh","1/03/1995", "709w centennial apt, apt 113", "F", "817-352-6382", "6");
INSERT INTO USER_ACCOUNT values ("1014", "O.Smith","1/02/1999", "709w centennial apt, apt 114", "M", "817-352-6382", "6");
INSERT INTO USER_ACCOUNT values ("1015", "P.Josh","1/25/2020", "709w centennial apt, apt 115", "F", "817-352-6382", "6");
drop table USER_ACCOUNT;
drop table USER_role;
drop database security;

select * from user_role;
INSERT INTO PRIVILEGES values ("P01", "Account_Privilege");
INSERT INTO PRIVILEGES values ("P02", "Relational_Privilege");
INSERT INTO ACCOUNT_PRIVILEGES values ("A101", "Create", "Can Create A schema", "1", "P01");
INSERT INTO ACCOUNT_PRIVILEGES values ("A102", "Drop", "Can Drop A schem", "1", "P01");
INSERT INTO ACCOUNT_PRIVILEGES values ("A103", "Insert", "Can Insert into A schema", "1", "P01");
INSERT INTO ACCOUNT_PRIVILEGES values ("A104", "Select", "Can Select A schem", "1", "P01");
INSERT INTO ACCOUNT_PRIVILEGES values ("A105", "Update", "Can Update A schem", "1", "P01");
drop table account_privileges;
select * from account_privileges;
INSERT INTO RELATION_PRIVILEGES values ("R101", "Read", "Can Read from  A schema","4", "P02");
INSERT INTO RELATION_PRIVILEGES values ("R103", "Write", "Can write into  A schema","5", "P02");
INSERT INTO RELATION_PRIVILEGES values ("R104", "Append", "Can append into  A schema","5", "P02");
drop table relation_privileges;
INSERT INTO Tables1 VALUES ("T01", "TAB1", "Table of a given user with id 1001", "1001");
INSERT INTO Tables1 VALUES ("T02", "TAB2", "Table of a given user with id 1002", "1002");
INSERT INTO Tables1 VALUES ("T03", "TAB3", "Table of a given user with id 1003", "1003");
INSERT INTO Tables1 VALUES ("T04", "TAB4", "Table of a given user with id 1004", "1004");
INSERT INTO Tables1 VALUES ("T05", "TAB5", "Table of a given user with id 1005", "1005");
INSERT INTO Tables1 VALUES ("T06", "TAB6", "Table of a given user with id 1006", "1006");
INSERT INTO Tables1 VALUES ("T07", "TAB7", "Table of a given user with id 1007", "1007");
INSERT INTO Tables1 VALUES ("T08", "TAB8", "Table of a given user with id 1008", "1008");
INSERT INTO Tables1 VALUES ("T09", "TAB9", "Table of a given user with id 1009", "1009");
INSERT INTO Tables1 VALUES ("T10", "TAB10", "Table of a given user with id 1010", "1010");
INSERT INTO Tables1 VALUES ("T11", "TAB11", "Table of a given user with id 1011", "1011");
INSERT INTO Tables1 VALUES ("T12", "TAB12", "Table of a given user with id 1012", "1012");
INSERT INTO Tables1 VALUES ("T13", "TAB13", "Table of a given user with id 1013", "1013");
INSERT INTO Tables1 VALUES ("T14", "TAB14", "Table of a given user with id 1014", "1014");
INSERT INTO Tables1 VALUES ("T15", "TAB15", "Table of a given user with id 1015", "1015");
drop table Tables1;
select * from Tables1;
INSERT INTO HAS_ON values ("T07","4","R101", "P02", "Role 04 has relational previlage on table T07");
INSERT INTO HAS_ON values ("T08","4","R103", "P02", "Role 04 has relational previlage on table T08");
INSERT INTO HAS_ON values ("T09","4","R104", "P02", "Role 04 has relational previlage on table T09");
drop table HAS_On;
select * from has_on;

