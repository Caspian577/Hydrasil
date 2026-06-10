-- ===================================================================
--   HYDRASIL - Database Base Schema 
--   Author: Carlos Arturo Alfonso Garavito
-- ===================================================================


-- ===================================================================
-- Database Interaction
-- ===================================================================
CREATE DATABASE hydrasil;
USE hydrasil;

ALTER DATABASE hydrasil
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

-- ====================================================================
-- Table: patients
-- ====================================================================
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_names VARCHAR(800),
    last_names VARCHAR(800),
    age INT,
    gender ENUM('M', 'F')
);

ALTER TABLE patients 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
ADD identification VARCHAR(50) NOT NULL UNIQUE,
ADD registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE patients
ADD family_history TEXT;

-- ====================================================================
-- Table: results 
-- (Base measurements or diagnostics)
-- ====================================================================
CREATE TABLE IF NOT EXISTS results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    test_type VARCHAR(100),
    test_date DATE,
    observations TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE ON UPDATE CASCADE 
);

ALTER TABLE results 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Historical alterations matching original schema changes
ALTER TABLE results
DROP COLUMN value,
DROP COLUMN unit;

ALTER TABLE results
ADD test_status ENUM('pending', 'completed', 'analyzed') DEFAULT 'pending';

-- ====================================================================
-- Table: lipid_profile
-- ====================================================================
CREATE TABLE lipid_profile (
    lipid_id INT AUTO_INCREMENT PRIMARY KEY,
    result_id INT NOT NULL,
    total_cholesterol DECIMAL(6,2),
    hdl DECIMAL(6,2),
    ldl DECIMAL(6,2),
    triglycerides DECIMAL(6,2),
    FOREIGN KEY (result_id) REFERENCES results(result_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE lipid_profile
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- ====================================================================
-- Table: blood_pressure
-- ====================================================================
CREATE TABLE blood_pressure (
    pressure_id INT AUTO_INCREMENT PRIMARY KEY,
    result_id INT NOT NULL,
    systolic INT,
    diastolic INT,
    pulse INT,
    FOREIGN KEY (result_id) REFERENCES results(result_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE blood_pressure
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- ====================================================================
-- Table: tumor_markers
-- ====================================================================
CREATE TABLE tumor_markers (
    marker_id INT AUTO_INCREMENT PRIMARY KEY,
    result_id INT NOT NULL,
    psa DECIMAL(6,2),
    ca125 DECIMAL(6,2),
    cea DECIMAL(6,2),
    afp DECIMAL(6,2),
    FOREIGN KEY (result_id) REFERENCES results(result_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE tumor_markers
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- ====================================================================
-- Table: renal_profile
-- ====================================================================
CREATE TABLE renal_profile (
    renal_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    creatinine DECIMAL(5,2),
    urea DECIMAL(5,2),
    uric_acid DECIMAL(5,2),
    glomerular_filtration_rate DECIMAL(5,2),
    urine_protein DECIMAL(5,2),
    observations VARCHAR(255),
    test_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE renal_profile
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- ====================================================================
-- Table: genetic_analysis
-- ====================================================================
CREATE TABLE genetic_analysis (
    genetic_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    studied_gene VARCHAR(50),
    detected_mutation VARCHAR(100),
    mutation_type VARCHAR(50),
    associated_risk VARCHAR(100),
    cancer_probability DECIMAL(5,2),
    observations VARCHAR(255),
    test_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ====================================================================
-- Table: probabilities
-- (Data calculated via Python, associated with specific exam results)
-- ====================================================================
CREATE TABLE IF NOT EXISTS probabilities (
    probability_id INT AUTO_INCREMENT PRIMARY KEY,
    result_id INT,
    model_used VARCHAR(100),
    probability FLOAT CHECK (probability BETWEEN 0 AND 1),
    classification VARCHAR(50),
    calculation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (result_id) REFERENCES results(result_id)
    ON DELETE CASCADE ON UPDATE CASCADE 
);

ALTER TABLE probabilities 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

ALTER TABLE probabilities 
ADD algorithm_version VARCHAR(20),
ADD f1_metric FLOAT,
ADD accuracy_metric FLOAT;

-- ====================================================================
-- Table: users (System Access Control)
-- ====================================================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(250),
    role ENUM('admin', 'doctor', 'analyst') DEFAULT 'analyst',
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE users
ADD email VARCHAR(100),
ADD last_access TIMESTAMP NULL;

-- ===================================================================
-- Reset AUTO_INCREMENT (Placeholder for future optimization)
-- ===================================================================
