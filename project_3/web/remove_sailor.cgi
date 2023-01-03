#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()
email = form.getvalue('email')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>SIBD Project</title>')
print('<div><h3>Menu</h3>')
print('<a href="sailors.cgi">Sailors</a> | <a href="reservations.cgi">Reservations</a> | <a href="trips.cgi">Trips</a>')
print('</div>')
print('</head>')
print('<body>')
print('<h2>Sailors</h2>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    # connection.autocommit = False
    cursor = connection.cursor()
    
    verify_sailor = "SELECT * FROM sailor WHERE email = %(email)s"

    cursor.execute(verify_sailor, {'email': email})
    result = cursor.fetchall()

    if len(result) == 0:
        print('Sailor does not exist')
    else:

        cursor.execute("START TRANSACTION")
        cursor.execute("SET CONSTRAINTS ALL DEFERRED")
        delete_senior = "DELETE FROM senior WHERE email = %(email)s"
        delete_junior = "DELETE FROM junior WHERE email = %(email)s"
        delete_sailor = "DELETE FROM sailor WHERE email = %(email)s"
        cursor.execute(delete_sailor, {'email': email})
        connection.commit()
        print('Delete Sailor: SUCESS')

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
