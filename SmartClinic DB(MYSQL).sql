create database smartclinic;
use smartclinic;


CREATE TABLE DOCTORS (
    DoctorID     INT AUTO_INCREMENT PRIMARY KEY,
    FullName     VARCHAR(100) NOT NULL,
    Phone        VARCHAR(20),
    Email        VARCHAR(100) UNIQUE,
    Password     VARCHAR(255) NOT NULL,
    Speciality   VARCHAR(100),
    HourlyPay    DECIMAL(10,2),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);
 
 INSERT INTO DOCTORS (FullName, Phone, Email, Password, Speciality, HourlyPay, Salary, HireDate) VALUES
('Dr. Sarah Ahmed',    '01012345678', 'sarah.ahmed@hospital.com',   'hashed_pw_1', 'Cardiology',    150.00, 25000.00, '2019-03-14'),
('Dr. Omar Khaled',    '01098765432', 'omar.khaled@hospital.com',  'hashed_pw_2', 'Pediatrics',    120.00, 20000.00, '2020-07-01'),
('Dr. Mona Farid',     '01122334455', 'mona.farid@hospital.com',   'hashed_pw_3', 'Dermatology',   130.00, 22000.00, '2021-01-20'),
('Dr. Karim Youssef',  '01234567890', 'karim.youssef@hospital.com','hashed_pw_4', 'Orthopedics',   140.00, 24000.00, '2018-11-05');




CREATE TABLE ROOMS (
    RoomID            INT PRIMARY KEY,
    RoomNumber        VARCHAR(20) NOT NULL,
    FloorNumber       INT,
    AvailabilityStatus VARCHAR(20) DEFAULT 'Available'
);
 
 INSERT INTO ROOMS (RoomID, RoomNumber, FloorNumber, AvailabilityStatus) VALUES
(1, '101', 1, 'Occupied'),
(2, '102', 1, 'Available'),
(3, '201', 2, 'Occupied'),
(4, '202', 2, 'Available');



CREATE TABLE PATIENTS (
    PatientID       INT AUTO_INCREMENT PRIMARY KEY,
    FullName        VARCHAR(100) NOT NULL,
    Phone           VARCHAR(20),
    Gender          VARCHAR(10),
    DateOfBirth     DATE,
    BloodType       VARCHAR(5),
    AppointmentType VARCHAR(50),
    Email           VARCHAR(100) UNIQUE,
    Password        VARCHAR(255) NOT NULL,
    RoomID          INT,
    
    CONSTRAINT fk_patients_room FOREIGN KEY (RoomID) REFERENCES ROOMS(RoomID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
 
 INSERT INTO PATIENTS (FullName, Phone, Gender, DateOfBirth, BloodType, AppointmentType, Email, Password, RoomID) VALUES
('Ahmed Hassan',  '01011122233', 'Male',   '1990-05-12', 'O+',  'Consultation', 'ahmed.hassan@mail.com',  'hashed_pw_5', 1),
('Laila Mostafa', '01099988877', 'Female', '1985-09-23', 'A-',  'Follow-up',    'laila.mostafa@mail.com', 'hashed_pw_6', 2),
('Youssef Adel',  '01155566677', 'Male',   '2000-02-08', 'B+',  'Emergency',    'youssef.adel@mail.com',  'hashed_pw_7', 3),
('Nour Ibrahim',  '01277788899', 'Female', '1995-12-30', 'AB+', 'Consultation', 'nour.ibrahim@mail.com',  'hashed_pw_8', NULL);




CREATE TABLE APPOINTMENTS (
    AppointmentID     INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentStatus VARCHAR(30),
    Diagnosis         VARCHAR(255),
    AppointmentDate    DATETIME,
    PatientID         INT,
    DoctorID          INT,
    
    CONSTRAINT fk_appointments_patient FOREIGN KEY (PatientID) REFERENCES PATIENTS(PatientID)
        ON DELETE CASCADE,
        
        
    CONSTRAINT fk_appointments_doctor FOREIGN KEY (DoctorID) REFERENCES DOCTORS(DoctorID)
        ON DELETE CASCADE
       
);
 
 INSERT INTO APPOINTMENTS (AppointmentStatus, Diagnosis, AppointmentDate, PatientID, DoctorID) VALUES
('Completed',  'Hypertension follow-up','2026-06-10 09:30:00', 1, 1),
('Completed',  'Routine child checkup','2026-06-12 11:00:00', 2, 2),
('Scheduled',  'Skin rash evaluation', '2026-07-05 14:00:00', 3, 3),
('Cancelled',  'Knee pain assessment', '2026-06-20 10:15:00', 4, 4),
('Completed',  'Knee pain assessment', '2026-06-20 10:15:00', 4, 4);
 



CREATE TABLE BILLS (
    BillID          INT AUTO_INCREMENT PRIMARY KEY,
    TotalAmount     DECIMAL(10,2) NOT NULL,
    PaidAmount      DECIMAL(10,2) DEFAULT 0,
    RemainingBalance DECIMAL(10,2),
    PaymentMethod   VARCHAR(50),
    PaymentStatus   VARCHAR(30),
    BillDate        DATE,
    PaymentDate     DATE,
    AppointmentID   INT,
    
    CONSTRAINT fk_bills_appointment FOREIGN KEY (AppointmentID) REFERENCES APPOINTMENTS(AppointmentID)
        ON DELETE SET NULL
        
);

 
 INSERT INTO BILLS (TotalAmount, PaidAmount, PaymentMethod, PaymentStatus, BillDate, PaymentDate, AppointmentID) VALUES
(500.00, 500.00,  'Credit Card', 'Paid',    '2026-06-10', '2026-06-10', 5),
(300.00, 150.00,  'Cash',        'Unpaid', '2026-06-12', '2026-06-12', 6),
(450.00, 0.00, 'Insurance',   'Unpaid',  '2026-07-05', NULL,7),
(300.00, 500.00,  'Cash', 'Paid', '2026-06-12', '2026-06-12', 9);




CREATE TABLE PRESCRIPTIONS (
    PrescriptionID     INT AUTO_INCREMENT PRIMARY KEY,
    MedicineName       VARCHAR(100) NOT NULL,
    Dosage_MgML        DECIMAL(10,2),
    Frequency_PerDay   INT,
    Duration_Weeks     INT,
    AppointmentID      INT,
    
    CONSTRAINT fk_prescriptions_appointment FOREIGN KEY (AppointmentID) REFERENCES APPOINTMENTS(AppointmentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

 INSERT INTO PRESCRIPTIONS (MedicineName, Dosage_MgML, Frequency_PerDay, Duration_Weeks, AppointmentID) VALUES
('Amlodipine',   5.00,  1, 4, 5),
('Paracetamol',  250.00, 3, 1, 6),
('Hydrocortisone Cream', 1.00, 2, 2, 7);




CREATE TABLE Patient_Doctor_Consultation (
    DoctorID  INT,
    PatientID INT,
    PRIMARY KEY (DoctorID, PatientID),
    
    CONSTRAINT fk_consultation_doctor FOREIGN KEY (DoctorID) REFERENCES DOCTORS(DoctorID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_consultation_patient FOREIGN KEY (PatientID) REFERENCES PATIENTS(PatientID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Patient_Doctor_Consultation (DoctorID, PatientID) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 4);



select * from appointments;
select * from doctors;
select * from bills;
select * from Patient_Doctor_Consultation;
select * from prescriptions;
select * from rooms;
select * from patients;



-- start of table changes *****************

-- start of deleting from table *****************

-- 1) deleting redundant row from appointments table
delete from appointments 
where AppointmentID = 8;

select * from appointments;


-- end of deleting from table *****************



-- 2) start table structure modifications  *****************

 -- 1) added a new column(Room_use) 
alter table patients 
add Room_use bool;

 -- adding a constraint 
ALTER TABLE PATIENTS
MODIFY COLUMN Room_use BOOL NOT NULL default 0;



-- 2) adding a new column(ChangeAmount) 
alter table Bills 
add ChangeAmount Decimal;
 
-- adding a constraint
ALTER TABLE Bills
MODIFY COLUMN ChangeAmount Decimal(20,2) Default 0;

-- changing where its located at 
ALTER TABLE Bills
CHANGE COLUMN ChangeAmount ChangeAmount Decimal(20,5) AFTER RemainingBalance;

-- end table structure modifications  *****************


-- end of table changes *****************








-- start of tirggers *****************


-- 1) sets Remaining Balance and ChangeAmount Automatically also updates payment status
DELIMITER //
CREATE TRIGGER Insert_Bills
before INSERT ON Bills
FOR EACH ROW
BEGIN
	if NEW.TotalAmount > NEW.PaidAmount then
		set NEW.RemainingBalance = NEW.TotalAmount - NEW.PaidAmount;
		set NEW.ChangeAmount = 0;
        set new.PaymentStatus = 'UnPaid';
   else
		set NEW.ChangeAmount = NEW.PaidAmount - NEW.TotalAmount;
		set NEW.RemainingBalance = 0;
        set new.PaymentStatus = 'Paid';
   End if;
END //
DELIMITER ;




-- 2) trigger that updates my remaining balance and my change after any updates on the Bills table also updates payment status
DELIMITER //
CREATE TRIGGER Update_Bills
before UPDATE ON Bills
FOR EACH ROW
BEGIN
	if old.TotalAmount > new.PaidAmount then
		set NEW.RemainingBalance = old.TotalAmount - new.PaidAmount;
		set NEW.ChangeAmount = 0;
        set new.PaymentStatus = 'UnPaid'; 
        
   else
		set NEW.ChangeAmount = new.PaidAmount - old.TotalAmount;
		set NEW.RemainingBalance = 0;
        set new.PaymentStatus = 'Paid'; 
   End if;
END //
DELIMITER ;





-- 3) calculate new doctors monthly salary 
DELIMITER //
CREATE TRIGGER Update_doctors_salary
before UPDATE ON doctors
FOR EACH ROW
BEGIN
   set NEW.Salary = NEW.HourlyPay * 10 * 20; -- note formula(Monthly Salary = Hourly Pay × Hours Per Day × Working Days) note2: (fixed days and workin hours)
END //
DELIMITER ;




-- 4) updating the Room_Availability when a new insert happens on the patients table
DELIMITER //
CREATE TRIGGER Room_Availability_Insert
AFTER INSERT ON PATIENTS
FOR EACH ROW
BEGIN
    IF NEW.Room_use = 1 THEN
        UPDATE ROOMS
        SET AvailabilityStatus = 'Occupied'
        WHERE RoomID = NEW.RoomID;
    END IF;
END //
DELIMITER ;




-- 5) updating the Room_Availability in rooms when a update happens on the patients table
DELIMITER //
CREATE TRIGGER Room_Availability_update
AFTER UPDATE ON PATIENTS
FOR EACH ROW
BEGIN
    IF OLD.Room_use = 1 AND NEW.Room_use = 0 THEN
        UPDATE ROOMS
        SET AvailabilityStatus = 'Available'
        WHERE RoomID = OLD.RoomID;
    ELSEIF OLD.Room_use = 0 AND NEW.Room_use = 1 THEN
        UPDATE ROOMS
        SET AvailabilityStatus = 'Occupied'
        WHERE RoomID = NEW.RoomID;
    END IF;
END //
DELIMITER ;



-- 6) set a RoomID when a update happens to Room_use in patients table change 
DELIMITER //

CREATE TRIGGER RoomID_Change
before UPDATE ON PATIENTS
FOR EACH ROW
BEGIN

IF OLD.Room_use = 1 AND NEW.Room_use = 0 THEN
SET NEW.RoomID = NULL;

ELSEIF OLD.Room_use = 0 AND NEW.Room_use = 1 THEN
SET NEW.RoomID = (SELECT RoomID FROM ROOMS
	WHERE AvailabilityStatus = 'Available'
	LIMIT 1);
    END IF;
END //

DELIMITER ;

-- end of triggers *****************





-- checking if my triggers work *****************

-- 1) checking if  Update_Bills works correctly 
select * from Bills;
update Bills 
set PaidAmount = 300.00
where BillID = 4;




-- 2) seeing if the Update_doctors_salary trigger works
select * from doctors;
update doctors 
set HourlyPay = 20
where DoctorID = 2;



-- 3) checking if my RoomID_Change works
select * from rooms;
select * from patients;

update patients
set Room_use = 0
where PatientID = 1;

update patients
set Room_use = 1
where PatientID = 3;



-- end of checking if my triggers work *****************

