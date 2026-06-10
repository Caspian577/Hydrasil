-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO pacientes (nombres_pacientes, apellidos_pacientes, edad, sexo, identificacion, antecedentes_familiares)
VALUES
('Laura', 'Martínez Rojas', 34, 'F', 'CC1002345678', 'Madre con antecedentes de cáncer de mama, padre hipertenso'),
('Carlos', 'Gómez Rivera', 45, 'M', 'CC1003456789', 'Padre fallecido por cáncer de colon'),
('Daniela', 'Torres Acuña', 29, 'F', 'CC1004567890', 'Abuela con diabetes tipo II'),
('Julián', 'Pérez Suárez', 52, 'M', 'CC1005678901', 'Tío con cáncer de hígado, historial de tabaquismo'),
('Camila', 'Hernández Mora', 38, 'F', 'CC1006789012', 'Hermana con enfermedad renal crónica');
-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM pacientes;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO resultados (id_paciente, tipo_examen, fecha_examen, observaciones, estado_examen)
VALUES
(1, 'Perfil Lipídico', '2025-09-10', 'Paciente en ayunas, sin complicaciones', 'completado'),
(2, 'Presión Arterial', '2025-09-11', 'Toma realizada en reposo', 'completado'),
(3, 'Marcadores Tumorales', '2025-09-12', 'Seguimiento rutinario anual', 'analizado'),
(4, 'Perfil Renal', '2025-09-13', 'Posible indicio de función renal comprometida', 'analizado'),
(5, 'Análisis Genético', '2025-09-14', 'Revisión por antecedentes familiares', 'pendiente');
-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM resultados ;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO perfil_lipidico (id_resultado, colesterol_total, hdl, ldl, trigliceridos)
VALUES
(1, 190.5, 60.2, 110.4, 140.8),
(2, 205.3, 48.9, 130.6, 180.2),
(3, 160.0, 70.5, 85.2, 90.1),
(4, 230.8, 45.3, 150.2, 220.0),
(5, 180.7, 58.2, 100.0, 130.9);
-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM perfil_lipidico;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO presion_arterial (id_resultado, sistolica, diastolica, pulso)
VALUES
(1, 120, 78, 72),
(2, 145, 92, 80),
(3, 110, 70, 68),
(4, 130, 85, 76),
(5, 118, 76, 70);
-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM presion_arterial;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO marcadores_tumorales (id_resultado, psa, ca125, cea, afp)
VALUES
(1, 1.2, 10.5, 2.1, 4.3),
(2, 3.0, 35.0, 4.2, 3.9),
(3, 1.8, 12.2, 3.0, 5.0),
(4, 2.5, 8.0, 2.5, 3.3),
(5, 1.0, 9.8, 2.0, 2.7);
-- ---------------------------------------------------------------------------------------------------------------------
SELECT * FROM marcadores_tumorales;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO analisis_genetico 
(id_paciente, gen_estudiado, mutacion_detectada, tipo_mutacion, riesgo_asociado, probabilidad_cancer, observaciones, fecha_examen)
VALUES
(1, 'BRCA1', 'c.68_69delAG', 'deleción', 'Cáncer de mama/ovario', 12.5, 'Sin antecedentes paternos', '2025-09-10'),
(2, 'TP53', 'p.R175H', 'sustitución', 'Cáncer de colon', 28.7, 'Mutación patogénica conocida', '2025-09-12'),
(3, 'APC', 'c.3927_3931delAAAGA', 'deleción', 'Poliposis adenomatosa familiar', 46.2, 'Requiere seguimiento anual', '2025-09-15'),
(4, 'BRCA2', 'c.5946delT', 'deleción', 'Cáncer de próstata', 10.1, 'Sin mutaciones adicionales', '2025-09-18'),
(5, 'MLH1', 'p.G67R', 'sustitución', 'Cáncer colorrectal hereditario', 33.9, 'Control cada 6 meses', '2025-09-22');
-- ---------------------------------------------------------------------------------------------------------------------
SELECT * FROM analisis_genetico;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO perfil_renal 
(id_paciente, creatinina, urea, acido_urico, tasa_filtracion_glomerular, proteinas_en_orina, observaciones, fecha_examen)
VALUES
(1, 0.9, 30.5, 5.2, 95.4, 0.1, 'Resultados dentro de parámetros normales', '2025-09-10'),
(2, 1.3, 45.8, 7.1, 70.2, 0.3, 'Leve elevación de urea, posible deshidratación', '2025-09-12'),
(3, 2.1, 60.4, 8.5, 45.8, 0.6, 'Disminución de la función renal moderada', '2025-09-15'),
(4, 0.7, 28.9, 4.8, 102.3, 0.0, 'Función renal óptima', '2025-09-18'),
(5, 1.8, 52.6, 9.0, 50.0, 0.5, 'Elevación significativa, posible daño renal inicial', '2025-09-22');
-- ---------------------------------------------------------------------------------------------------------------------
SELECT * FROM perfil_renal;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO probabilidades
(id_resultado, modelo_usado, algoritmo_version, probabilidad, clasificacion, metrica_f1, metrica_accuracy)
VALUES
-- 🔹 Paciente 1: Riesgo bajo general
(1, 'LogisticRegression', 'v1.0', 0.18, 'Riesgo Bajo', 0.85, 0.90),
(1, 'RandomForest', 'v1.0', 0.22, 'Riesgo Bajo', 0.88, 0.92),

-- 🔹 Paciente 2: Riesgo medio por colesterol y PSA
(2, 'LogisticRegression', 'v1.0', 0.56, 'Riesgo Medio', 0.82, 0.87),
(2, 'SVM', 'v1.0', 0.61, 'Riesgo Medio', 0.80, 0.85),

-- 🔹 Paciente 3: Riesgo alto (mutación genética detectada)
(3, 'RandomForest', 'v1.0', 0.83, 'Riesgo Alto', 0.89, 0.91),
(3, 'GradientBoosting', 'v1.1', 0.87, 'Riesgo Alto', 0.90, 0.93),

-- 🔹 Paciente 4: Riesgo medio-bajo (renal ligeramente alterado)
(4, 'LogisticRegression', 'v1.0', 0.42, 'Riesgo Medio-Bajo', 0.84, 0.88),
(4, 'NaiveBayes', 'v1.0', 0.38, 'Riesgo Bajo', 0.81, 0.86),

-- 🔹 Paciente 5: Riesgo muy alto (historial familiar + marcadores tumorales)
(5, 'RandomForest', 'v1.1', 0.91, 'Riesgo Alto', 0.92, 0.95),
(5, 'XGBoost', 'v1.0', 0.94, 'Riesgo Crítico', 0.94, 0.97);

-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM  probabilidades ;
-- ======================================================================================================================
-- ======================================================================================================================
INSERT INTO usuarios (nombre_usuario, CLAVE, rol, email)
VALUES
('admin_hydrasil', 'admin1234', 'admin', 'admin@hydrasil.com'),
('dr_martinez', 'clave_medico1', 'medico', 'drmartinez@hydrasil.com'),
('dr_abendaño', 'clave_medico2', 'medico', 'drabendaño@hydrasil.com'),
('ana_analista', 'analista1', 'analista', 'anaalista@hydrasil.com'),
('paco_analista', 'analista2', 'analista', 'pacoanalista@hydrasil.com');
-- ----------------------------------------------------------------------------------------------------------------------
SELECT * FROM usuarios ;
-- ======================================================================================================================
--  Procesos Almacenados
-- ======================================================================================================================
-- PACIENTES:
-- --------------------------------------------------------------------------------------------------------------------
-- REGISTRAR PACIENTE
CALL registrar_paciente('Laura', 'Suarez', 33, 'F', 'CC987654', 'Madre con cáncer de mama');
-- BUSCAR PACIENTE
CALL buscar_paciente;
-- ELIMINAR PACIENTE
CALL eliminar_paciente;
-- =======================================================================================================================
-- RESULTADOS Y EXAMENES
-- -----------------------------------------------------------------------------------------------------------------------
-- REGISTRAR ESULTADOS
CALL registrar_resultado;
-- REGISTRAR EXAMEN COMPLETO
CALL registrar_examen_completo;
-- =======================================================================================================================
--  Consultas
-- =======================================================================================================================
-- Pacientes con colesterol total mayor a 200 mg/dL
SELECT p.nombres_pacientes, pl.colesterol_total
FROM pacientes p
JOIN resultados r ON p.id_paciente = r.id_paciente
JOIN perfil_lipidico pl ON r.id_resultado = pl.id_resultado
WHERE pl.colesterol_total > 200;

-- Pacientes con presión sistólica menor a 90 (hipotensión)
SELECT p.nombres_pacientes, pa.sistolica, pa.diastolica
FROM pacientes p
JOIN resultados r ON p.id_paciente = r.id_paciente
JOIN presion_arterial pa ON r.id_resultado = pa.id_resultado
WHERE pa.sistolica < 90;
-- Promedio de colesterol por paciente
SELECT p.nombres_pacientes, AVG(pl.colesterol_total) AS promedio_colesterol
FROM pacientes p
JOIN resultados r ON p.id_paciente = r.id_paciente
JOIN perfil_lipidico pl ON r.id_resultado = pl.id_resultado
GROUP BY p.id_paciente;

-- Valor máximo de probabilidad de cáncer calculada
SELECT MAX(probabilidad) AS mayor_probabilidad
FROM probabilidades;
-- Exámenes realizados este mes
SELECT tipo_examen, fecha_examen
FROM resultados
WHERE MONTH(fecha_examen) = MONTH(CURDATE())
AND YEAR(fecha_examen) = YEAR(CURDATE());

-- Pacientes registrados en 2025
SELECT nombres_pacientes, fecha_registro
FROM pacientes
WHERE YEAR(fecha_registro) = 2025;
-- Historial médico completo
SELECT 
    p.nombres_pacientes,
    r.tipo_examen,
    pl.colesterol_total,
    pa.sistolica,
    pr.creatinina,
    ag.gen_estudiado,
    pb.probabilidad,
    pb.clasificacion
FROM pacientes p
LEFT JOIN resultados r ON p.id_paciente = r.id_paciente
LEFT JOIN perfil_lipidico pl ON r.id_resultado = pl.id_resultado
LEFT JOIN presion_arterial pa ON r.id_resultado = pa.id_resultado
LEFT JOIN perfil_renal pr ON p.id_paciente = pr.id_paciente
LEFT JOIN analisis_genetico ag ON p.id_paciente = ag.id_paciente
LEFT JOIN probabilidades pb ON r.id_resultado = pb.id_resultado;