#!/usr/bin/python3
import psycopg2
import cgi
import login
form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
mode = form.getvalue('mode')
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>SIBD Project</title>')
print('<div><h3>Menu</h3>')
print('<a href="sailors.cgi">Sailors</a> | <a href="reservations.cgi">Reservations</a> | <a href="trips.cgi">Trips</a>')
print('<div>')
print('</head>')
print('<body>')
print('<h2>List</h2>')
print('<h3>Reservations</h3>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    connection.autocommit = False
    cursor = connection.cursor()
    
    # Making query
    sql = 'SELECT * FROM reservation;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    
    # Displaying results
    print('<table border="1" cellspacing="5">')
    print('<tr>')
    for desc in cursor.description:
        # printing the name of the columns
        print('<th>{}</th>'.format(desc[0]))
        
    print('</tr>')
    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
        print('<td><a href = "manage_authorization.cgi?start={}&end={}&country={}&cni={}">Manage Authorizations</a></td>'.format(row[0],row[1],row[2],row[3]))
        print('</tr>')
    print('</table>')
    # Closing connection
    cursor.close()
except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()
        
print('</body>')
print('</html>')