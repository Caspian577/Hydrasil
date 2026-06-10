from dotenv import load_dotenv
import os 
import mysql.connector
from mysql.connector import Error

load_dotenv()

def conectar ():
    """
    Retorna una conexion activa a la base de datos de MySQL usando credenciales del archivo
    """
    try:
        conexion = mysql.connector.connect(
        
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASS"),
            database=os.getenv("DB_NAME")        
        )
        if conexion.is_connected():
            print("== CONEXION A HYDRASILL EXITOSA ==")
            return conexion
    except Error as e:
        print ("== ERRPR DE CONEXION ==;",e)
        return None 
    
#==============================================================================
def ejecutar_query (conexion, query, valores=None):
    """
    Ejecutar consultas INSERT, UPDATE O DELETE    
    """
    try:
        cursor = conexion.cursor()
        if valores:
            cursor.execute(query, valores)
            
        else:
            cursor.execute(query)
        conexion.commit()
        print("Quey ejecutada correctamente")
    except Error as e :
        print("Error al ejecutar Query {e}")
    finally:
        cursor.close()
#==============================================================================
def leer_datos(conexion, query):
    """
    Ejecuta una consulta SELECT y devuelve los resultados como lista de diccionarios.
    """
    try:
        cursor = conexion.cursor(dictionary=True)
        cursor.execute(query)
        resultados = cursor.fetchall()
        return resultados
    except  Error as e:
        print("Erro al leer los datos {e}")
        return[]
    finally:
        cursor.close()
