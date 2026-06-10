# ==============================================================================
# Project: HYDRASIL
# File: test_connection.py
# Function: Database connectivity and schema visibility test
# Author: Arturo
# ==============================================================================

from db_connection import connect_to_db
import mysql.connector


def test_database_connection():
    """Tests the MySQL connection and lists all existing tables in the schema."""
    try:
        # Use the updated connection function name
        connection = connect_to_db()

        if connection and connection.is_connected():
            print("Database connection verification: SUCCESSFUL")

            cursor = connection.cursor()
            cursor.execute("SHOW TABLES;")
            tables = cursor.fetchall()

            if tables:
                print("\nExisting tables in Hydrasil database:")
                for table in tables:
                    print(f" - {table[0]}")
            else:
                print("\nNo tables found in this database instance yet.")

            cursor.close()
            connection.close()
            print("\nDatabase connection successfully closed.")
        else:
            print(
                "Connection failed. Please check your .env credentials or MySQL service status."
            )

    except Exception as e:
        print(f"Error during database connection test: {e}")


if __name__ == "__main__":
    test_database_connection()
