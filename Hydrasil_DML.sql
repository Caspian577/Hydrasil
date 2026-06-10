-- ======================================================================================================================
-- ======================================================================================================================
-- PATIENTS DATA INSERTION
-- ======================================================================================================================
INSERT INTO patients (first_names, last_names, age, gender, identification, family_history)
VALUES
('Laura', 'Martínez Rojas', 34, 'F', 'CC1002345678', 'Mother with a history of breast cancer, hypertensive father'),
('Carlos', 'Gómez Rivera', 45, 'M', 'CC1003456789', 'Father deceased from colon cancer'),
('Daniela', 'Torres Acuña', 29, 'F', 'CC1004567890', 'Grandmother with type II diabetes'),
('Julián', 'Pérez Suárez', 52, 'M', 'CC1005678901', 'Uncle with liver cancer, history of smoking'),
('Camila', 'Hernández Mora', 38, 'F', 'CC1006789012', 'Sister with chronic kidney disease');

-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM patients;

-- ======================================================================================================================
-- EXAM RESULTS INSERTION
-- ======================================================================================================================
INSERT INTO results (patient_id, test_type, test_date, observations, test_status)
VALUES
(1, 'Lipid Profile', '2025-09-10', 'Fasting patient, no complications', 'completed'),
(2, 'Blood Pressure', '2025-09-11', 'Measurement taken at rest', 'completed'),
(3, 'Tumor Markers', '2025-09-12', 'Routine annual follow-up', 'analyzed'),
(4, 'Renal Profile', '2025-09-13', 'Possible sign of compromised renal function', 'analyzed'),
(5, 'Genetic Analysis', '2025-09-14', 'Review due to family history', 'pending');

-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM results;

-- ======================================================================================================================
-- LIPID PROFILE DATA INSERTION
-- ======================================================================================================================
INSERT INTO lipid_profile (result_id, total_cholesterol, hdl, ldl, triglycerides)
VALUES
(1, 190.5, 60.2, 110.4, 140.8),
(2, 205.3, 48.9, 130.6, 180.2),
(3, 160.0, 70.5, 85.2, 90.1),
(4, 230.8, 45.3, 150.2, 220.0),
(5, 180.7, 58.2, 100.0, 130.9);

-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM lipid_profile;

-- ======================================================================================================================
-- BLOOD PRESSURE DATA INSERTION
-- ======================================================================================================================
INSERT INTO blood_pressure (result_id, systolic, diastolic, pulse)
VALUES
(1, 120, 78, 72),
(2, 145, 92, 80),
(3, 110, 70, 68),
(4, 130, 85, 76),
(5, 118, 76, 70);

-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM blood_pressure;

-- ======================================================================================================================
-- TUMOR MARKERS DATA INSERTION
-- ======================================================================================================================
INSERT INTO tumor_markers (result_id, psa, ca125, cea, afp)
VALUES
(1, 1.2, 10.5, 2.1, 4.3),
(2, 3.0, 35.0, 4.2, 3.9),
(3, 1.8, 12.2, 3.0, 5.0),
(4, 2.5, 8.0, 2.5, 3.3),
(5, 1.0, 9.8, 2.0, 2.7);

-- ---------------------------------------------------------------------------------------------------------------------
SELECT * FROM tumor_markers;

-- ======================================================================================================================
-- GENETIC ANALYSIS DATA INSERTION
-- ======================================================================================================================
INSERT INTO genetic_analysis 
(patient_id, studied_gene, detected_mutation, mutation_type, associated_risk, cancer_probability, observations, test_date)
VALUES
(1, 'BRCA1', 'c.68_69delAG', 'deletion', 'Breast/Ovarian cancer', 12.5, 'No paternal history', '2025-09-10'),
(2, 'TP53', 'p.R175H', 'substitution', 'Colon cancer', 28.7, 'Known pathogenic mutation', '2025-09-12'),
(3, 'APC', 'c.3927_3931delAAAGA', 'deletion', 'Familial adenomatous polyposis', 46.2, 'Requires annual follow-up', '2025-09-15'),
(4, 'BRCA2', 'c.5946delT', 'deletion', 'Prostate cancer', 10.1, 'No additional mutations', '2025-09-18'),
(5, 'MLH1', 'p.G67R', 'substitution', 'Hereditary colorectal cancer', 33.9, 'Check-up every 6 months', '2025-09-22');

-- ---------------------------------------------------------------------------------------------------------------------
SELECT * FROM genetic_analysis;

-- ======================================================================================================================
-- RENAL PROFILE DATA INSERTION
-- ======================================================================================================================
INSERT INTO renal_profile 
(patient_id, creatinine, urea, uric_acid, glomerular_filtration_rate, urine_protein, observations, test_date)
VALUES
(1, 0.9, 30.5, 5.2, 95.4, 0.1, 'Results within normal parameters', '2025-09-10'),
(2, 1.3, 45.8, 7.1, 70.2, 0.3, 'Slight elevation of urea, possible dehydration', '2025-09-12'),
(3, 2.1, 60.4, 8.5, 45.8, 0.6, 'Moderate decrease in renal function', '2025-09-15'),
(4, 0.7, 28.9, 4.8, 102.3, 0.0, 'Optimal renal function', '2025-09-18'),
(5, 1.8, 52.6, 9.0, 50.0, 0.5, 'Significant elevation, possible early kidney damage', '2025-09-22');

-- ---------------------------------------------------------------------------------------------------------------------
SELECT * FROM renal_profile;

-- ======================================================================================================================
-- PREDICTIVE MODEL PROBABILITIES INSERTION
-- ======================================================================================================================
INSERT INTO probabilities
(result_id, model_used, algorithm_version, probability, classification, f1_metric, accuracy_metric)
VALUES
-- 🔹 Patient 1: Low overall risk
(1, 'LogisticRegression', 'v1.0', 0.18, 'Low Risk', 0.85, 0.90),
(1, 'RandomForest', 'v1.0', 0.22, 'Low Risk', 0.88, 0.92),

-- 🔹 Patient 2: Medium risk due to cholesterol and PSA
(2, 'LogisticRegression', 'v1.0', 0.56, 'Medium Risk', 0.82, 0.87),
(2, 'SVM', 'v1.0', 0.61, 'Medium Risk', 0.80, 0.85),

-- 🔹 Patient 3: High risk (detected genetic mutation)
(3, 'RandomForest', 'v1.0', 0.83, 'High Risk', 0.89, 0.91),
(3, 'GradientBoosting', 'v1.1', 0.87, 'High Risk', 0.90, 0.93),

-- 🔹 Patient 4: Medium-low risk (slightly altered renal profile)
(4, 'LogisticRegression', 'v1.0', 0.42, 'Medium-Low Risk', 0.84, 0.88),
(4, 'NaiveBayes', 'v1.0', 0.38, 'Low Risk', 0.81, 0.86),

-- 🔹 Patient 5: Very high risk (family history + tumor markers)
(5, 'RandomForest', 'v1.1', 0.91, 'High Risk', 0.92, 0.95),
(5, 'XGBoost', 'v1.0', 0.94, 'Critical Risk', 0.94, 0.97);

-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM probabilities;

-- ======================================================================================================================
-- SYSTEM USERS DATA INSERTION
-- ======================================================================================================================
INSERT INTO users (username, password, role, email)
VALUES
('admin_hydrasil', 'admin1234', 'admin', 'admin@hydrasil.com'),
('dr_martinez', 'doctor_password1', 'doctor', 'drmartinez@hydrasil.com'),
('dr_abendano', 'doctor_password2', 'doctor', 'drabendano@hydrasil.com'),
('ana_analyst', 'analyst_password1', 'analyst', 'anaanalyst@hydrasil.com'),
('paco_analyst', 'analyst_password2', 'analyst', 'pacoanalyst@hydrasil.com');

-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM users;

-- ======================================================================================================================
--  STORED PROCEDURES CALLS (EXAMPLES)
-- ======================================================================================================================
-- PATIENTS:
-- --------------------------------------------------------------------------------------------------------------------
-- REGISTER PATIENT
CALL register_patient('Laura', 'Suarez', 33, 'F', 'CC987654', 'Mother with breast cancer');
-- SEARCH PATIENT
CALL search_patient;
-- DELETE PATIENT
CALL delete_patient;

-- =======================================================================================================================
-- RESULTS AND EXAMS
-- -----------------------------------------------------------------------------------------------------------------------
-- REGISTER RESULTS
CALL register_result;
-- REGISTER COMPLETE EXAM
CALL register_complete_exam;


-- =======================================================================================================================
--  ANALYTICAL QUERIES
-- =======================================================================================================================

-- Patients with total cholesterol greater than 200 mg/dL
SELECT p.first_names, lp.total_cholesterol
FROM patients p
JOIN results r ON p.patient_id = r.patient_id
JOIN lipid_profile lp ON r.result_id = lp.result_id
WHERE lp.total_cholesterol > 200;

-- Patients with systolic blood pressure under 90 (hypotension)
SELECT p.first_names, bp.systolic, bp.diastolic
FROM patients p
JOIN results r ON p.patient_id = r.patient_id
JOIN blood_pressure bp ON r.result_id = bp.result_id
WHERE bp.systolic < 90;

-- Average cholesterol per patient
SELECT p.first_names, AVG(lp.total_cholesterol) AS average_cholesterol
FROM patients p
JOIN results r ON p.patient_id = r.patient_id
JOIN lipid_profile lp ON r.result_id = lp.result_id
GROUP BY p.patient_id;

-- Maximum calculated disease/cancer probability value
SELECT MAX(probability) AS highest_probability
FROM probabilities;

-- Exams performed during the current month
SELECT test_type, test_date
FROM results
WHERE MONTH(test_date) = MONTH(CURDATE())
AND YEAR(test_date) = YEAR(CURDATE());

-- Patients registered in the year 2025
SELECT first_names, registration_date
FROM patients
WHERE YEAR(registration_date) = 2025;

-- Comprehensive Medical History Join Query
SELECT 
    p.first_names,
    r.test_type,
    lp.total_cholesterol,
    bp.systolic,
    rp.creatinine,
    ga.studied_gene,
    pb.probability,
    pb.classification
FROM patients p
LEFT JOIN results r ON p.patient_id = r.patient_id
LEFT JOIN lipid_profile lp ON r.result_id = lp.result_id
LEFT JOIN blood_pressure bp ON r.result_id = bp.result_id
LEFT JOIN renal_profile rp ON p.patient_id = rp.patient_id
LEFT JOIN genetic_analysis ga ON p.patient_id = ga.patient_id
LEFT JOIN probabilities pb ON r.result_id = pb.result_id;
