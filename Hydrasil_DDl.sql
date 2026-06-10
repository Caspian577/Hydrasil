-- ===================================================================
--   HYDRASILL - Esquema base de la base de datos 
--   Autor: Carlos Arturo Alfonso Garavito
-- ===================================================================


-- ===================================================================
-- DataSet inteactions
-- ===================================================================
CREATE DATABASE hydrasil;
USE hydrasil;
ALTER  DATABASE hydrasil
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
-- ====================================================================
-- Table pacientes interactions 
-- ====================================================================
CREATE TABLE pacientes (
id_paciente INT auto_increment PRIMARY KEY,
nombres_pacientes VARCHAR (800),
apellidos_pacientes VARCHAR (800),
edad INT,
sexo ENUM('M' , 'F')
);
ALTER TABLE pacientes 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
ADD identificacion VARCHAR (50) NOT NULL UNIQUE,
ADD fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
;
ALTER TABLE pacientes
ADD antecedentes_familiares TEXT;
-- ====================================================================
-- Tablaa: resultados 
-- (Mediciones o diagnositicos base)
-- ====================================================================
CREATE TABLE IF NOT EXISTS resultados (
id_resultado INT AUTO_INCREMENT PRIMARY KEY,
id_paciente INT ,
tipo_examen VARCHAR (100),
fecha_examen DATE,
observaciones TEXT,
FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente)
ON DELETE CASCADE ON UPDATE CASCADE 
);
ALTER TABLE resultados 
CONVERT TO CHARACTER SET utf8mb4 COLLATE  utf8mb4_general_ci;
ALTER TABLE resultados
DROP valor,
DROP unidad;
ALTER TABLE resultados
ADD estado_examen ENUM ('pendiente','completado','analizado') DEFAULT 'pendiente';
-- ====================================================================
-- Examenes
-- ====================================================================
CREATE TABLE perfil_lipidico (
id_lipidico INT AUTO_INCREMENT PRIMARY KEY,
id_resultado INT NOT NULL,
colesterol_total DECIMAL(6,2),
hdl DECIMAL(6,2),
ldl DECIMAL(6,2),
trigliceridos DECIMAL(6,2),
FOREIGN KEY (id_resultado) REFERENCES resultados(id_resultado)
ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE perfil_lipidico
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- ====================================================================
CREATE TABLE presion_arterial (
id_presion INT AUTO_INCREMENT PRIMARY KEY,
id_resultado INT NOT NULL,
sistolica INT,
diastolica INT,
pulso INT,
FOREIGN KEY (id_resultado) REFERENCES resultados(id_resultado)
ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE presion_arterial
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- ====================================================================
CREATE TABLE marcadores_tumorales (
id_marcador INT AUTO_INCREMENT PRIMARY KEY,
id_resultado INT NOT NULL,
psa DECIMAL(6,2),
ca125 DECIMAL(6,2),
cea DECIMAL(6,2),
afp DECIMAL(6,2),
FOREIGN KEY (id_resultado) REFERENCES resultados(id_resultado)
ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE marcadores_tumorales
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- ====================================================================
-- Tabla: Perfil renal
-- ====================================================================
CREATE TABLE perfil_renal (
id_renal INT AUTO_INCREMENT PRIMARY KEY,
id_paciente INT,
creatinina DECIMAL(5,2),
urea DECIMAL(5,2),
acido_urico DECIMAL(5,2),
tasa_filtracion_glomerular DECIMAL(5,2),
proteinas_en_orina DECIMAL(5,2),
observaciones VARCHAR(255),
fecha_examen DATE,
FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE perfil_renal
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- ====================================================================
-- Tabla: analisis_genetico
-- ====================================================================
CREATE TABLE analisis_genetico (
 id_genetico INT AUTO_INCREMENT PRIMARY KEY,
id_paciente INT,
gen_estudiado VARCHAR(50),
mutacion_detectada VARCHAR(100),
tipo_mutacion VARCHAR(50),
riesgo_asociado VARCHAR(100),
probabilidad_cancer DECIMAL(5,2),
observaciones VARCHAR(255),
fecha_examen DATE,
FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
ON DELETE CASCADE ON UPDATE CASCADE
);
-- ====================================================================
-- Tabla: probabilidades
-- (Datoos calculados en python, asociados a resultados)
-- ====================================================================
CREATE TABLE IF NOT EXISTS probabilidades (
id_probabilidad INT AUTO_INCREMENT PRIMARY KEY,
id_resultado INT,
modelo_usado VARCHAR (100),
probabilidad float  CHECK (probabilidad BETWEEN  0 AND 1),
clasificacion VARCHAR (50),
fecha_calculo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_resultado) REFERENCES resultados (id_resultado)
ON DELETE CASCADE ON UPDATE CASCADE 
);
ALTER TABLE probabilidades 
CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE probabilidades 
ADD algoritmo_version VARCHAR(20),
ADD metrica_f1 FLOAT,
ADD  metrica_accuracy FLOAT;
-- ====================================================================
-- Tabla :Usuarios (control del sistema )
-- ====================================================================
CREATE TABLE IF NOT EXISTS usuarios (
id_usuarios INT AUTO_INCREMENT PRIMARY KEY,
nombre_usuario VARCHAR (50) UNIQUE,
CLAVE VARCHAR (250),
rol ENUM ('admin','medico','analista') DEFAULT 'analista',
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE usuarios
ADD email VARCHAR (100),
ADD ultimo_acceso TIMESTAMP NULL;
-- ===================================================================
-- Reset AUTOincrement
-- ===================================================================
