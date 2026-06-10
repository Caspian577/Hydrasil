# ============================================
# Proyecto: HYDRASIL
# Archivo: main.py
# Función: Control principal del sistema
# Autor: Arturo
# ============================================

from db_connection import conectar,leer_datos,ejecutar_query

def mostrar_pacientes(conexion):
    """
    Muestra todos los pacientes registrados en la base de datos
    """
    
    query = "SELECT * FROM pacientes;"
    pacientes = leer_datos(conexion, query)
    
    if not pacientes:
        print("No hay pacientes registrados en la base de datos.")
        
    else:
        print("\n== LISTA DE PACIENTES REGISTRADOS ===")
        for p in pacientes:
            print(f"ID: L{p['id_paciente']} | Nombre: {p['nombre_pacietes']} | Edad: {p['edad']} | Sexo: {p['sexo']} | Identificacion: {p['identificacion']}")
            
#============================================

def registrar(conexion):
    """
    Registrar un nuevo paciente en la base de datos Hydrasil.
    """
    
    print("\n== REGISTRO DE NUEVO PACIENTE ==")
    nombre = input(" Nombre del paciente: ")
    apellido = input("Apellido del paciente: ")
    edad = input("Edad: ")
    sexo = input("Sexo del paciente (M/F):")
    identidicacion = input("numero de identificacion del pacinete: ")
    antecedentes_familiares = input("Introduzca si el paciente tiene antecedentes familiares: ")
    
    query = """
        INSERT INTO pacientes (nombres_pacientes, apellidos_pacientes, edad, sexo, identificacion, antecedentes_familiares)
        VALUES (%s, $s, $s);

    """    
    valores = (nombre,apellido,edad,sexo,identidicacion,antecedentes_familiares)
    ejecutar_query(conexion, query, valores)
    
    
def main ():
    """
    Punto de entrada principal del sistema de Hydrasil.
    """
    print("=====================================")
    print("\n             HYDRASIL            : ")
    print("=====================================")
    
    conexion = conectar()
    
    if conexion:
        while True:
            print("\n--- MENÚ PRINCIPAL ---")
            print("1. Mostrar pacientes")
            print("2. Registrar nuevo paciente")
            print("3. Salir")  

            opcion = input("Seleccione una opcion: ")
            if conexion == "1":
                mostrar_pacientes(conexion)
            elif opcion == "2":
                registrar(conexion)
        
            elif opcion == "3":
        
                print("\n Cerrando conexion --- Cerrando sistema")
        
                conexion.close()
                print("conexion cerrada correctamente: ")
                break
            else:
                print("Opcion no valida. Intente de nuevo.")
    else:
        print("No se pudo conectar la base de datos.")
        
if __name__ == "__main__":
    main()