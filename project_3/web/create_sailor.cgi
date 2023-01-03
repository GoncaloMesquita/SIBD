#!/usr/bin/python3
import psycopg2, cgi
import login
form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
firstname = form.getvalue('firstname')
surname = form.getvalue('surname')
email = form.getvalue('email')
rank = form.getvalue('rank')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>SIBD Project</title>')
print('<div><h3>Menu</h3>')
print('<a href="sailors.cgi">Sailors</a> | <a href="reservations.cgi">Reservations</a> | <a href="trips.cgi">Trips</a>')
print('<div>')
print('</head>')
print('<body>')
print('<h2>Sailors</h2>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    connection.autocommit = False
    cursor = connection.cursor()
    
    verify_sailor = "SELECT * FROM sailor WHERE email = %(email)s"

    cursor.execute(verify_sailor, {'email': email})
    result = cursor.fetchall()

    if len(result) == 0:
        cursor.execute("START TRANSACTION;")
        cursor.execute("SET CONSTRAINTS ALL DEFERRED;")
        
        insert_sailor = "INSERT INTO sailor VALUES(%(firstname)s, %(surname)s, %(email)s)"
        cursor.execute(insert_sailor, {'firstname': firstname,'surname' : surname, 'email': email})

        insert_sailor = "INSERT INTO {} VALUES(%(email)s)".format(rank)
        cursor.execute(insert_sailor, {'email': email})

        cursor.execute("COMMIT;")
        connection.commit()
        print('Create New Sailor: SUCCESS')
    else:
        print('Sailor already exists')

    #End Connection
    cursor.close()
    connection.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()
print('</body>')
print('</html>')
