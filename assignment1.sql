CREATE DATABASE hospital_team_66;

\connect hospital_team_66

DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;

CREATE TYPE Loc AS (
    Building_number INTEGER,
    Room_number INTEGER
);

CREATE TABLE DEPARTMENT (
    ID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location Loc NOT NULL
);

CREATE TABLE DOCTOR (
    ID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Full_name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Hire_date DATE NOT NULL,
    Licence_number VARCHAR(100) NOT NULL UNIQUE,
    Department_ID INTEGER NOT NULL,
    FOREIGN KEY (Department_ID)
        REFERENCES DEPARTMENT(ID)
        ON DELETE RESTRICT
);

CREATE TABLE PATIENT (
    ID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Full_name VARCHAR(100) NOT NULL,
    National_ID VARCHAR(100) NOT NULL UNIQUE,
    Gender VARCHAR(10) NOT NULL,
    Date_of_birth DATE NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Address TEXT NOT NULL
);

CREATE TABLE "PROCEDURE" (
    ID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,3) NOT NULL CHECK (Price >= 0)
);

CREATE TABLE APPOINTMENT (
    ID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Patient_ID INTEGER NOT NULL,
    Doctor_ID INTEGER NOT NULL,
    FOREIGN KEY (Patient_ID)
        REFERENCES PATIENT(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Doctor_ID)
        REFERENCES DOCTOR(ID)
        ON DELETE RESTRICT
);

CREATE TABLE APPOINTMENT_PROCEDURE (
    Appointment_ID INTEGER NOT NULL,
    Procedure_ID INTEGER NOT NULL,
    PRIMARY KEY (Appointment_ID, Procedure_ID),
    FOREIGN KEY (Appointment_ID) 
        REFERENCES APPOINTMENT(ID) 
        ON DELETE CASCADE,
    FOREIGN KEY (Procedure_ID) 
        REFERENCES "PROCEDURE"(ID) 
        ON DELETE CASCADE
);

CREATE TABLE DIAGNOSIS (
    ID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    Appointment_ID INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (Appointment_ID)
        REFERENCES APPOINTMENT(ID)
        ON DELETE CASCADE
);


INSERT INTO DEPARTMENT (Name, Location) VALUES
('Cardiology', ('1', '101')),
('Neurology', ('1', '201')),
('Pediatrics', ('2', '110')),
('Orthopedics', ('2', '210')),
('Dermatology', ('3', '105')),
('Ophthalmology', ('3', '205')),
('Gynecology', ('4', '115')),
('Psychiatry', ('4', '215')),
('Oncology', ('5', '120')),
('Emergency Medicine', ('5', '001'));

INSERT INTO DOCTOR (Full_name, Specialization, Phone, Email, Hire_date, Licence_number, Department_ID) VALUES
('John Smith', 'Cardiologist', '+1(212)555-0101', 'john.smith@hospital.com', '2018-05-15', 'LIC123456', 1),
('Anna Johnson', 'Neurologist', '+1(212)555-0102', 'anna.johnson@hospital.com', '2019-03-20', 'LIC234567', 1),
('Robert Williams', 'Pediatrician', '+1(212)555-0103', 'robert.williams@hospital.com', '2020-01-10', 'LIC345678', 2),
('Maria Brown', 'Orthopedist', '+1(212)555-0104', 'maria.brown@hospital.com', '2017-11-05', 'LIC456789', 2),
('James Davis', 'Dermatologist', '+1(212)555-0105', 'james.davis@hospital.com', '2021-07-12', 'LIC567890', 3),
('Sarah Miller', 'Ophthalmologist', '+1(212)555-0106', 'sarah.miller@hospital.com', '2016-09-25', 'LIC678901', 3),
('Michael Wilson', 'Gynecologist', '+1(212)555-0107', 'michael.wilson@hospital.com', '2019-12-01', 'LIC789012', 4),
('Jennifer Moore', 'Psychiatrist', '+1(212)555-0108', 'jennifer.moore@hospital.com', '2022-02-18', 'LIC890123', 4),
('David Taylor', 'Oncologist', '+1(212)555-0109', 'david.taylor@hospital.com', '2015-06-30', 'LIC901234', 5),
('Lisa Anderson', 'Emergency Physician', '+1(212)555-0110', 'lisa.anderson@hospital.com', '2020-08-14', 'LIC012345', 5);

INSERT INTO PATIENT (Full_name, National_ID, Gender, Date_of_birth, Phone, Email, Address) VALUES
('Michael Johnson', 'ID123456', 'M', '1985-04-12', '+1(917)555-1111', 'michael.j@email.com', '123 Main St, Apt 45, New York, NY 10001'),
('Emily Davis', 'ID234567', 'F', '1990-08-25', '+1(917)555-2222', 'emily.d@email.com', '456 Oak Ave, Apt 12, New York, NY 10002'),
('Robert Wilson', 'ID345678', 'M', '1978-11-03', '+1(917)555-3333', 'robert.w@email.com', '789 Pine St, Apt 78, New York, NY 10003'),
('Jennifer Lee', 'ID456789', 'F', '1965-02-18', '+1(917)555-4444', 'jennifer.l@email.com', '321 Elm St, Apt 34, New York, NY 10004'),
('Daniel Brown', 'ID567890', 'M', '1995-07-09', '+1(917)555-5555', 'daniel.b@email.com', '654 Maple Ave, Apt 56, New York, NY 10005'),
('Jessica Martinez', 'ID678901', 'F', '1982-12-30', '+1(917)555-6666', 'jessica.m@email.com', '987 Cedar St, Apt 91, New York, NY 10006'),
('Thomas Garcia', 'ID789012', 'M', '1972-05-14', '+1(917)555-7777', 'thomas.g@email.com', '147 Birch St, Apt 15, New York, NY 10007'),
('Sarah Thompson', 'ID890123', 'F', '1988-09-22', '+1(917)555-8888', 'sarah.t@email.com', '258 Spruce Ave, Apt 42, New York, NY 10008'),
('Christopher White', 'ID901234', 'M', '1992-03-07', '+1(917)555-9999', 'chris.w@email.com', '369 Willow St, Apt 67, New York, NY 10009'),
('Amanda Clark', 'ID012345', 'F', '1975-10-19', '+1(917)555-0000', 'amanda.c@email.com', '741 Chestnut St, Apt 23, New York, NY 10010');

INSERT INTO "PROCEDURE" (Name, Price) VALUES
('Complete Blood Count', 150.00),
('Electrocardiogram (ECG)', 350.00),
('Echocardiogram', 750.00),
('Brain MRI', 1500.00),
('Chest X-Ray', 450.00),
('Specialist Consultation', 300.00),
('Physical Therapy Session', 200.00),
('Massage Therapy Session', 400.00),
('Vaccination', 250.00),
('Surgical Procedure', 5000.00);

INSERT INTO APPOINTMENT (Date, Time, Status, Patient_ID, Doctor_ID) VALUES
('2023-11-10', '09:30:00', 'Completed', 1, 1),
('2023-11-10', '10:15:00', 'Completed', 1, 1),
('2023-11-10', '11:00:00', 'Completed', 2, 2),
('2023-11-11', '14:30:00', 'Completed', 3, 3),
('2023-11-12', '09:00:00', 'Completed', 4, 4),
('2023-11-15', '10:30:00', 'Cancelled', 5, 5),
('2023-11-16', '15:45:00', 'Completed', 6, 6),
('2023-11-17', '12:15:00', 'No-show', 7, 7),
('2023-11-18', '16:00:00', 'Scheduled', 8, 8),
('2023-11-20', '08:30:00', 'Scheduled', 9, 9),
('2023-11-21', '13:00:00', 'Scheduled', 10, 10);

INSERT INTO APPOINTMENT_PROCEDURE (Appointment_ID, Procedure_ID) VALUES
(1, 9), 
(1, 1), 
(2, 2),  
(3, 3), 
(4, 4), 
(5, 5),
(6, 6),  
(7, 7),
(8, 8),
(9, 5),
(9, 6);

INSERT INTO DIAGNOSIS (Title, Description, Appointment_ID) VALUES
('Hypertension', 'High blood pressure, medication adjustment required', 1),
('Sinus Tachycardia', 'Elevated heart rate, further tests needed', 2),
('Migraine', 'Chronic headaches, preventive treatment prescribed', 3),
('Osteochondrosis', 'Back pain, physical therapy recommended', 4),
('Atopic Dermatitis', 'Skin rash, topical treatment prescribed', 5),
('Conjunctivitis', 'Eye inflammation, antibiotic drops prescribed', 6),
('Pregnancy 12 weeks', 'Registered for prenatal care, test results normal', 7),
('Depressive Disorder', 'Anxiety and depression, therapy sessions scheduled', 8),
('Benign Tumor', 'Requires monitoring, follow-up in 3 months', 9),
('Healthy', 'Regular check-up, no abnormalities found', 10),
('Upper Respiratory Infection', 'Cold symptoms, rest recommended', 11);
