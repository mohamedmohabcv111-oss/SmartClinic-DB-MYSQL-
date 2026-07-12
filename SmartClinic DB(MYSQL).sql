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
('Dr. Karim Youssef',  '01234567890', 'karim.youssef@hospital.com','hashed_pw_4', 'Orthopedics',   140.00, 24000.00, '2018-11-05'),
('Dr. Yasmine Ali',    '01011223344', 'yasmine.ali@hospital.com',  'hashed_pw_9', 'Neurology',    160.00, 32000.00, '2022-05-10'),
('Dr. Tarek Hassan',   '01555443322', 'tarek.hassan@hospital.com', 'hashed_pw_10', 'Ophthalmology', 135.00, 27000.00, '2021-09-15');




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
(4, '202', 2, 'Available'),
(5, '301', 3, 'Available'),
(6, '302', 3, 'Available');



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
('Nour Ibrahim',  '01277788899', 'Female', '1995-12-30', 'AB+', 'Consultation', 'nour.ibrahim@mail.com',  'hashed_pw_8', NULL),
('Zainab Selim',  '01055544433', 'Female', '1992-04-15', 'O-',  'Consultation', 'zainab.selim@mail.com',  'hashed_pw_11', NULL),
('Mostafa Amr',   '01211122233', 'Male',   '1988-11-20', 'A+',  'Follow-up',    'mostafa.amr@mail.com',   'hashed_pw_12', 4);




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
('Completed',  'Knee pain assessment', '2026-06-20 10:15:00', 4, 4),
('Scheduled',  'Neurological checkup', '2026-07-15 09:00:00', 5, 5),
('Completed',  'Eye checkup',          '2026-07-10 11:30:00', 6, 6),
('Scheduled',  'Cardiology checkup',   '2026-07-20 10:00:00', 1, 1),
('Scheduled',  'Routine general exam', '2026-07-22 12:00:00', 2, 2),
('Completed',  'Dental cleaning',      '2026-07-11 14:00:00', 3, 3),
('Scheduled',  'Dermatology checkup',  '2026-07-25 15:30:00', 4, 3);
 



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
(300.00, 500.00,  'Cash', 'Paid', '2026-06-12', '2026-06-12', 9),
(200.00, 200.00,  'Debit Card',  'Paid',   '2026-07-11', '2026-07-11', 10),
(400.00, 0.00,    'Cash',        'Unpaid', '2026-07-25', NULL,         11);




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
('Hydrocortisone Cream', 1.00, 2, 2, 7),
('Amoxicillin',  500.00, 3, 1, 10),
('Ibuprofen',    400.00, 2, 1, 11);




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
(1, 4),
(5, 5),
(6, 6);



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




-- start of views *****************

-- 1) Shows each doctor's upcoming appointments with patient names (hides raw IDs)
CREATE VIEW Doctor_Schedule_View AS
SELECT 
    d.FullName AS DoctorName,
    p.FullName AS PatientName,
    a.AppointmentDate,
    a.AppointmentStatus,
    a.Diagnosis
FROM APPOINTMENTS a
JOIN PATIENTS p ON a.PatientID = p.PatientID
JOIN DOCTORS d ON a.DoctorID = d.DoctorID
WHERE a.AppointmentDate >= NOW() OR a.AppointmentStatus = 'Scheduled';

-- 2) Shows each patient's total owed and paid across all their bills
CREATE VIEW Patient_Bill_Summary_View AS
SELECT 
    p.PatientID,
    p.FullName AS PatientName,
    SUM(b.TotalAmount) AS TotalBilled,
    SUM(b.PaidAmount) AS TotalPaid,
    SUM(b.RemainingBalance) AS TotalOwed
FROM PATIENTS p
JOIN APPOINTMENTS a ON p.PatientID = a.PatientID
JOIN BILLS b ON a.AppointmentID = b.AppointmentID
GROUP BY p.PatientID, p.FullName;

-- 3) Shows which patient occupies each room right now (if any)
CREATE VIEW Room_Occupancy_View AS
SELECT 
    r.RoomID,
    r.RoomNumber,
    r.FloorNumber,
    r.AvailabilityStatus,
    p.PatientID,
    p.FullName AS PatientName
FROM ROOMS r
LEFT JOIN PATIENTS p ON r.RoomID = p.RoomID;

-- 4) Shows doctors with their salary, sorted by Speciality
CREATE VIEW Doctor_Earnings_View AS
SELECT 
    FullName AS DoctorName,
    Speciality,
    Salary
FROM DOCTORS
ORDER BY Speciality, Salary DESC;

-- end of views *****************




-- checking if my views work *****************
select * from Doctor_Schedule_View;
select * from Patient_Bill_Summary_View;
select * from Room_Occupancy_View;
select * from Doctor_Earnings_View;
-- end of checking if my views work *****************



-- start of stored procedures *****************

-- 1) Inserts a new appointment
DELIMITER //
CREATE PROCEDURE AddNewAppointment(
    IN p_PatientID INT,
    IN p_DoctorID INT,
    IN p_Diagnosis VARCHAR(255)
)
BEGIN
    INSERT INTO APPOINTMENTS (AppointmentStatus, Diagnosis, AppointmentDate, PatientID, DoctorID)
    VALUES ('Scheduled', p_Diagnosis, NOW(), p_PatientID, p_DoctorID);
END //
DELIMITER ;

-- 2) Discharges a patient by setting Room_use = 0 (cascades to free the room)
DELIMITER //
CREATE PROCEDURE DischargePatient(
    IN p_PatientID INT
)
BEGIN
    UPDATE PATIENTS
    SET Room_use = 0
    WHERE PatientID = p_PatientID;
END //
DELIMITER ;

-- 3) Returns all appointments, prescriptions, and bills for one patient
DELIMITER //
CREATE PROCEDURE GetPatientHistory(
    IN p_PatientID INT
)
BEGIN
    -- Patient Info
    SELECT PatientID, FullName, Phone, Email, BloodType, RoomID, Room_use
    FROM PATIENTS
    WHERE PatientID = p_PatientID;

    -- Appointments Info
    SELECT AppointmentID, AppointmentStatus, Diagnosis, AppointmentDate, DoctorID
    FROM APPOINTMENTS
    WHERE PatientID = p_PatientID;

    -- Prescriptions Info
    SELECT pr.PrescriptionID, pr.MedicineName, pr.Dosage_MgML, pr.Frequency_PerDay, pr.Duration_Weeks, pr.AppointmentID
    FROM PRESCRIPTIONS pr
    JOIN APPOINTMENTS a ON pr.AppointmentID = a.AppointmentID
    WHERE a.PatientID = p_PatientID;

    -- Bills Info
    SELECT b.BillID, b.TotalAmount, b.PaidAmount, b.RemainingBalance, b.ChangeAmount, b.PaymentMethod, b.PaymentStatus, b.BillDate, b.PaymentDate, b.AppointmentID
    FROM BILLS b
    JOIN APPOINTMENTS a ON b.AppointmentID = a.AppointmentID
    WHERE a.PatientID = p_PatientID;
END //
DELIMITER ;

-- 4) Processes a payment on a bill, which triggers balance recalculation
DELIMITER //
CREATE PROCEDURE ProcessPayment(
    IN p_BillID INT,
    IN p_AmountPaid DECIMAL(10,2)
)
BEGIN
    UPDATE BILLS
    SET PaidAmount = PaidAmount + p_AmountPaid,
        PaymentDate = NOW()
    WHERE BillID = p_BillID;
END //
DELIMITER ;

-- 5) Assigns a doctor to a patient in the consultation table
DELIMITER //
CREATE PROCEDURE AssignDoctorToPatient(
    IN p_DoctorID INT,
    IN p_PatientID INT
)
BEGIN
    INSERT INTO Patient_Doctor_Consultation (DoctorID, PatientID)
    VALUES (p_DoctorID, p_PatientID);
END //
DELIMITER ;

-- end of stored procedures *******************




-- checking if my stored procedures work *****************

-- 1) Add new appointment
CALL AddNewAppointment(1, 2, 'Checkup for migraine');

-- 2) Discharge patient (automatically frees the room via trigger)
CALL DischargePatient(3);

-- 3) Process payment for a bill (automatically updates balance via trigger)
CALL ProcessPayment(2, 50.00);

-- 4) Assign doctor to patient
CALL AssignDoctorToPatient(3, 4);

-- 5) Get comprehensive patient history (returns multiple datasets)
CALL GetPatientHistory(1);

-- end of checking if my stored procedures work *****************




-- start of indexes *****************

-- 1) Index on APPOINTMENTS.PatientID (frequently joined/filtered by patient)
CREATE INDEX idx_appointments_patientID ON APPOINTMENTS(PatientID);

-- 2) Index on APPOINTMENTS.DoctorID (frequently joined/filtered by doctor)
CREATE INDEX idx_appointments_doctorID ON APPOINTMENTS(DoctorID);

-- 3) Index on BILLS.AppointmentID (frequently joined with APPOINTMENTS)
CREATE INDEX idx_bills_appointmentID ON BILLS(AppointmentID);

-- end of indexes *****************




-- checking if my indexes work *****************
SHOW INDEX FROM APPOINTMENTS;
SHOW INDEX FROM BILLS;
-- end of checking if my indexes work *****************




-- start of subqueries *****************


-- 1) Find patients who have at least one completed appointment
SELECT PatientID, FullName
FROM PATIENTS
WHERE PatientID IN (
    SELECT DISTINCT PatientID
    FROM APPOINTMENTS
    WHERE AppointmentStatus = 'Completed'
);


-- 2) Find doctors whose hourly pay is above the average hourly pay of all doctors
SELECT DoctorID, FullName, Speciality, HourlyPay
FROM DOCTORS
WHERE HourlyPay > (
    SELECT AVG(HourlyPay)
    FROM DOCTORS
);


-- 3) List all bills where the total amount exceeds the average total amount across all bills
SELECT BillID, TotalAmount, PaymentStatus, AppointmentID
FROM BILLS
WHERE TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM BILLS
);


-- 4) Get each patient's name along with the number of appointments they have scheduled
SELECT FullName,
    (SELECT COUNT(*) 
     FROM APPOINTMENTS a 
     WHERE a.PatientID = p.PatientID 
       AND a.AppointmentStatus = 'Scheduled') AS ScheduledAppointments
FROM PATIENTS p;


-- 5) Find patients who have never been assigned to any room (no room usage)
SELECT PatientID, FullName, Phone
FROM PATIENTS
WHERE PatientID NOT IN (
    SELECT DISTINCT PatientID
    FROM APPOINTMENTS
    WHERE PatientID IN (
        SELECT PatientID
        FROM PATIENTS
        WHERE RoomID IS NOT NULL
    )
);


-- 6) Get the doctor with the highest salary in the clinic
SELECT DoctorID, FullName, Speciality, Salary
FROM DOCTORS
WHERE Salary = (
    SELECT MAX(Salary)
    FROM DOCTORS
);


-- 7) List appointments that have an associated unpaid bill
SELECT AppointmentID, Diagnosis, AppointmentDate, AppointmentStatus
FROM APPOINTMENTS
WHERE AppointmentID IN (
    SELECT AppointmentID
    FROM BILLS
    WHERE PaymentStatus = 'UnPaid'
);


-- 8) Find patients who have been prescribed more than one medication across all their appointments
SELECT PatientID, FullName
FROM PATIENTS
WHERE PatientID IN (
    SELECT a.PatientID
    FROM APPOINTMENTS a
    JOIN PRESCRIPTIONS pr ON a.AppointmentID = pr.AppointmentID
    GROUP BY a.PatientID
    HAVING COUNT(pr.PrescriptionID) > 1
);


-- end of subqueries *****************




-- checking if my subqueries work *****************

-- 1) Patients with at least one completed appointment
SELECT PatientID, FullName
FROM PATIENTS
WHERE PatientID IN (
    SELECT DISTINCT PatientID FROM APPOINTMENTS WHERE AppointmentStatus = 'Completed'
);

-- 2) Doctors earning above average hourly pay
SELECT DoctorID, FullName, Speciality, HourlyPay
FROM DOCTORS
WHERE HourlyPay > (SELECT AVG(HourlyPay) FROM DOCTORS);

-- 3) Bills above average total amount
SELECT BillID, TotalAmount, PaymentStatus
FROM BILLS
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM BILLS);

-- 4) Scheduled appointment count per patient
SELECT FullName,
    (SELECT COUNT(*) FROM APPOINTMENTS a WHERE a.PatientID = p.PatientID AND a.AppointmentStatus = 'Scheduled') AS ScheduledAppointments
FROM PATIENTS p;

-- 5) Patients never assigned to a room
SELECT PatientID, FullName FROM PATIENTS
WHERE PatientID NOT IN (SELECT DISTINCT PatientID FROM APPOINTMENTS WHERE PatientID IN (SELECT PatientID FROM PATIENTS WHERE RoomID IS NOT NULL));

-- 6) Doctor with the highest salary
SELECT DoctorID, FullName, Speciality, Salary FROM DOCTORS WHERE Salary = (SELECT MAX(Salary) FROM DOCTORS);

-- 7) Appointments with unpaid bills
SELECT AppointmentID, Diagnosis, AppointmentDate FROM APPOINTMENTS
WHERE AppointmentID IN (SELECT AppointmentID FROM BILLS WHERE PaymentStatus = 'UnPaid');

-- 8) Patients with more than one prescription
SELECT PatientID, FullName FROM PATIENTS
WHERE PatientID IN (
    SELECT a.PatientID FROM APPOINTMENTS a
    JOIN PRESCRIPTIONS pr ON a.AppointmentID = pr.AppointmentID
    GROUP BY a.PatientID HAVING COUNT(pr.PrescriptionID) > 1
);

-- end of checking if my subqueries work *****************




