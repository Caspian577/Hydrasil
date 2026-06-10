from db_connection import conectar

try:
    conexion = conectar ()
    
    
    if conexion and conexion.is_connected():
        print("La conexion con la base de datos fue exitosa:")
        
        cursor = conexion.cursor()
        cursor.execute("SHOW TABLES")
        tablas = cursor.fetchall()
        
        if tablas:
            print("Tablas existentes:")
            for tabla in tablas:
                print ("-", tabla[0])
                
        else:
            print("No hay tablas en esta base de datos todavia.")
            
            
        cursor.close()
        conexion.close()
        print("conexion cerrada correctamente.")
    else:
        print("No se pudo conectar.Revise las credenciales o MySQL.")
        
except Exception as e:
    print("Error en la prueba de conexion:", e)