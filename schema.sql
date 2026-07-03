-- ============================================================
--   SUKARI — Diabetes Management App
--   Database Schema
--   M'hamed Bougara University — PFE 2024-2025
-- ============================================================

CREATE DATABASE IF NOT EXISTS sukari_db;
USE sukari_db;

-- ============================================================
-- 1. ACCOUNTS (base table for all users)
-- ============================================================
CREATE TABLE accounts (
    account_id      INT AUTO_INCREMENT PRIMARY KEY,
    email           VARCHAR(255) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL,          -- hashed
    username        VARCHAR(255),
    role            ENUM('Patient', 'Doctor', 'Admin') NOT NULL,
    status          ENUM('Active', 'Inactive', 'Pending') DEFAULT 'Pending',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 2. PATIENTS
-- ============================================================
CREATE TABLE patients (
    account_id      INT PRIMARY KEY,
    full_name       VARCHAR(255) NOT NULL,
    date_birth      DATE,
    weight          FLOAT,
    height          FLOAT,
    diabetes_type   ENUM('Type 1', 'Type 2', 'Gestational', 'Prediabetes', 'Other'),
    glucose_goal_min FLOAT DEFAULT 70,
    glucose_goal_max FLOAT DEFAULT 140,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 3. DOCTORS
-- ============================================================
CREATE TABLE doctors (
    account_id          INT PRIMARY KEY,
    full_name           VARCHAR(255) NOT NULL,
    phone_number        VARCHAR(20),
    specialty           ENUM('Nutritionist', 'Cardiologist', 'Gynecologist', 'Other'),
    bio                 TEXT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 4. LOCATION
-- ============================================================
CREATE TABLE location (
    id_location     INT AUTO_INCREMENT PRIMARY KEY,
    address         VARCHAR(255),
    latitude        DECIMAL(10, 8),
    longitude       DECIMAL(11, 8)
);

-- ============================================================
-- 5. HOSPITALS
-- ============================================================
CREATE TABLE hospitals (
    id_hospital     INT AUTO_INCREMENT PRIMARY KEY,
    name_hospital   VARCHAR(255) NOT NULL,
    postal_code     VARCHAR(20),
    email           VARCHAR(255),
    id_location     INT,
    FOREIGN KEY (id_location) REFERENCES location(id_location)
);

-- ============================================================
-- 6. BLOOD GLUCOSE RECORDS
-- ============================================================
CREATE TABLE blood_glucose_records (
    id_record       INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,
    level           FLOAT NOT NULL,               -- mg/dL
    record_type     ENUM('Fasting', 'Before Meal', 'After Meal', 'Before Bed', 'Other'),
    date_time       DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 7. MEALS
-- ============================================================
CREATE TABLE meals (
    id_meal         INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,
    name            VARCHAR(255) NOT NULL,
    meal_type       ENUM('Breakfast', 'Lunch', 'Dinner', 'Snack', 'Other'),
    calories        FLOAT,
    carbs           FLOAT,
    protein         FLOAT,
    fat             FLOAT,
    fiber           FLOAT,
    meal_time       DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 8. MEDICATIONS
-- ============================================================
CREATE TABLE medications (
    id_medical      INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,
    medical_name    VARCHAR(255) NOT NULL,
    medical_area    VARCHAR(255),
    medical_description TEXT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 9. PRESCRIPTIONS
-- ============================================================
CREATE TABLE prescriptions (
    id_prescription INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,
    code            VARCHAR(255),
    description     TEXT,
    date_time       DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 10. PRESCRIPTIONS MEDICAL (doctor prescribes medication)
-- ============================================================
CREATE TABLE prescriptions_medical (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    id_prescription INT NOT NULL,
    name            VARCHAR(255) NOT NULL,
    type_med        ENUM('Oral', 'Insulin', 'Injectable', 'Other'),
    frequency       VARCHAR(255),
    date_start      DATE,
    date_end        DATE,
    FOREIGN KEY (id_prescription) REFERENCES prescriptions(id_prescription) ON DELETE CASCADE
);

-- ============================================================
-- 11. PHYSICAL ACTIVITY
-- ============================================================
CREATE TABLE physical_activity (
    id_activity     INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,
    activity_type   VARCHAR(255),
    period          INT,                          -- in minutes
    burned_calories FLOAT,
    date_time_activity DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 12. APPOINTMENTS
-- ============================================================
CREATE TABLE appointments (
    id_appointment      INT AUTO_INCREMENT PRIMARY KEY,
    id_patient          INT NOT NULL,
    id_doctor           INT NOT NULL,
    appointment_time    DATETIME NOT NULL,
    appointment_type    ENUM('In person', 'Video call', 'Phone call') DEFAULT 'In person',
    appointment_status  ENUM('Pending', 'Confirmed', 'Cancelled', 'Completed') DEFAULT 'Pending',
    notes               TEXT,
    FOREIGN KEY (id_patient) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (id_doctor)  REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 13. MESSAGES (patient ↔ doctor secure chat)
-- ============================================================
CREATE TABLE messages (
    id_message      INT AUTO_INCREMENT PRIMARY KEY,
    sender_id       INT NOT NULL,
    receiver_id     INT NOT NULL,
    message_text    TEXT NOT NULL,
    message_type    ENUM('Text', 'Image', 'File') DEFAULT 'Text',
    is_read         BOOLEAN DEFAULT FALSE,
    date_time       DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id)   REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 14. CONTACTS (emergency + patient-doctor link)
-- ============================================================
CREATE TABLE contacts (
    id_contact          INT AUTO_INCREMENT PRIMARY KEY,
    account_id          INT NOT NULL,
    contact_name        VARCHAR(255),
    contact_status      ENUM('Pending', 'Active', 'Blocked') DEFAULT 'Active',
    is_emergency_contact BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 15. NOTIFICATIONS
-- ============================================================
CREATE TABLE notifications (
    id_notification     INT AUTO_INCREMENT PRIMARY KEY,
    account_id          INT NOT NULL,
    type_notification   ENUM('Appointment', 'Alert', 'Challenge', 'General', 'Medical', 'Reminder'),
    message             TEXT,
    is_read             BOOLEAN DEFAULT FALSE,
    timestamp           DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 16. CHALLENGES
-- ============================================================
CREATE TABLE challenges (
    id_challenge    INT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(255) NOT NULL,
    description     TEXT,
    start_date      DATE,
    end_date        DATE
);

-- ============================================================
-- 17. PATIENT CHALLENGES (participation)
-- ============================================================
CREATE TABLE patient_challenges (
    account_id      INT NOT NULL,
    id_challenge    INT NOT NULL,
    progress        INT DEFAULT 0,              -- percentage 0-100
    joined_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (account_id, id_challenge),
    FOREIGN KEY (account_id)    REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (id_challenge)  REFERENCES challenges(id_challenge) ON DELETE CASCADE
);

-- ============================================================
-- 18. ARTICLES (doctor educational posts)
-- ============================================================
CREATE TABLE articles (
    id_article      INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,                -- doctor who wrote it
    title           VARCHAR(255) NOT NULL,
    content         TEXT,
    publish_date    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 19. PREGNANCY TRACKING (gestational diabetes)
-- ============================================================
CREATE TABLE pregnancy_tracking (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,
    week            INT,
    weight          FLOAT,
    glucose_level   FLOAT,
    notes           TEXT,
    logged_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ============================================================
-- 20. REMINDERS
-- ============================================================
CREATE TABLE reminders (
    id_reminder     INT AUTO_INCREMENT PRIMARY KEY,
    account_id      INT NOT NULL,
    reminder_type   ENUM('Medication', 'Glucose Check', 'Meal', 'Exercise', 'Appointment', 'Other'),
    scheduled_time  TIME NOT NULL,
    frequency       ENUM('Daily', 'Weekly', 'Custom'),
    is_active       BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);
