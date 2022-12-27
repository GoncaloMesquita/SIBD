#!/usr/bin/python3
import psycopg2, cgi
import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>SIBD Project</title>')
print('<div><h3>Menu</h3>')
print('<a href="sailors.cgi">Sailors</a> | <a href="reservations.cgi">Reservations</a> | <a href="trips.cgi">Trips</a>')
print('<div>')
print('</head>')
print('<body>')
print('<h2>Reservation</h2>')
print('<h3>Remove Reservation</h3>')

# Form
print('<form action="remove_reservation.cgi" method="post">')

print('<p>Start date: <input type="date" id="start_date" name="start_date" required><br></p>')
print('<p>End date: <input type="date" id="end_date" name="end_date" requires></p>')
print('<p>Country: <input type="text" name="country" required></p>')
print('<p>Boat Code: <input type="text" name="cni" required></p>')

print('<p><input type="submit" value="Confirm"/></p>')
print('</form>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
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
        print('</tr>')
    print('</table>')
    
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
