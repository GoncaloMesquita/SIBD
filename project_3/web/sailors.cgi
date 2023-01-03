#!/usr/bin/python3
import psycopg2
import login
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
    connection.autocommit = False
    
    # Listing options
    print('<a href="list.cgi?mode=sailor">List</a>')
    print('<a href="create_sailor.html">Create</a>')
    print('<a href="remove_sailor.html">Remove</a>')

except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()
        
print('</body>')
print('</html>')