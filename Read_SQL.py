import mysql.connector
#Connection to the server
my_db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="maggi@522",
    database="classicmodels"
)
# 2. Create a cursor and execute query
cursor = my_db.cursor()
cursor.execute("SELECT * FROM customers")


# 3. Fetch all rows
rows = cursor.fetchall()
print(type(rows))

# 4. Print or process rows
with open("customers_output.txt", "w") as f:
 for row in rows:
    f.write(str(row) + "\n")


# 5. Close cursor and database connections
cursor.close()
my_db.close()

