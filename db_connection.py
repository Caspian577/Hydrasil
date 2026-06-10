import os
from dotenv import load_dotenv
import mysql.connector
from mysql.connector import Error

# Load environment variables from .env file
load_dotenv()


def connect_to_db():
    """Returns an active MySQL database connection using credentials from the .env file."""
    try:
        connection = mysql.connector.connect(
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASS"),
            database=os.getenv("DB_NAME"),
        )
        if connection.is_connected():
            print("== HYDRASIL CONNECTION SUCCESSFUL ==")
            return connection
    except Error as e:
        print("== CONNECTION ERROR ==:", e)
        return None


# ==============================================================================
def execute_query(connection, query, values=None):
    """Executes INSERT, UPDATE, or DELETE queries."""
    cursor = None
    try:
        cursor = connection.cursor()
        if values:
            cursor.execute(query, values)
        else:
            cursor.execute(query)
        connection.commit()
        print("Query executed successfully")
    except Error as e:
        print(f"Error executing query: {e}")
    finally:
        if cursor:
            cursor.close()


# ==============================================================================
def fetch_data(connection, query):
    """Executes a SELECT query and returns the results as a list of dictionaries."""
    cursor = None
    try:
        cursor = connection.cursor(dictionary=True)
        cursor.execute(query)
        results = cursor.fetchall()
        return results
    except Error as e:
        print(f"Error reading data: {e}")
        return []
    finally:
        if cursor:
            cursor.close()
