# ==============================================================================
# Project: HYDRASIL
# File: main.py
# Function: Main system control loop and CLI interface
# Author: Arturo
# ==============================================================================

from db_connection import connect_to_db, fetch_data, execute_query


def display_patients(connection):
    """Fetches and displays all registered patients from the database."""
    query = "SELECT * FROM patients;"
    patients = fetch_data(connection, query)

    if not patients:
        print("\nNo registered patients found in the database.")
    else:
        print("\n================ REGISTERED PATIENTS LIST ================")
        for patient in patients:
            print(
                f"ID: {patient['patient_id']} | "
                f"Name: {patient['first_names']} {patient['last_names']} | "
                f"Age: {patient['age']} | "
                f"Gender: {patient['gender']} | "
                f"Identification: {patient['identification']}"
            )


# ==============================================================================
def register_patient(connection):
    """Prompts user for input and registers a new patient in the database."""
    print("\n== REGISTER NEW PATIENT ==")
    first_name = input(" First Name: ")
    last_name = input(" Last Name: ")
    age = input(" Age: ")
    gender = input(" Gender (M/F): ").upper().strip()
    identification = input(" Identification Number: ")
    family_history = input(" Family Medical History / Antecedents: ")

    query = """
        INSERT INTO patients (first_names, last_names, age, gender, identification, family_history)
        VALUES (%s, %s, %s, %s, %s, %s);
    """
    values = (first_name, last_name, age, gender, identification, family_history)
    execute_query(connection, query, values)


# ==============================================================================
def main():
    """Main entry point for the Hydrasil system command-line interface."""
    print("==================================================")
    print("                    HYDRASIL                      ")
    print("==================================================")

    connection = connect_to_db()

    if connection:
        try:
            while True:
                print("\n--- MAIN MENU ---")
                print("1. Display patients")
                print("2. Register new patient")
                print("3. Exit")

                option = input("Select an option: ").strip()

                if option == "1":
                    display_patients(connection)
                elif option == "2":
                    register_patient(connection)
                elif option == "3":
                    print("\nClosing connection... Shutting down system.")
                    connection.close()
                    print("Database connection successfully closed.")
                    break
                else:
                    print("Invalid option. Please try again.")
        except KeyboardInterrupt:
            print("\n\nSystem interrupted. Closing database connection...")
            connection.close()
            print("Database connection successfully closed. Goodbye.")
    else:
        print("Critical Error: Could not establish a database connection.")


if __name__ == "__main__":
    main()
