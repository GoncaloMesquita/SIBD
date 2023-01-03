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
print('<h2>Trips</h2>')
print('<h3>Create New Trip</h3>')

# Form
print('<form action="create_trip.cgi" method="post">')

print('<p>Takeoff date: <input type="date" id="takeoff" name="takeoff" required>')
print('\tArrival date: <input type="date" id="arrival" name="arrival" requires></p>')

print('<p>Insurance: <input type="text" id="insurance" name="insurance" required></p>')

print('<p>From Location Latitude: <input type="text" id="from_lat" name="from_lat" required>')
print('\tFrom Location Longitude: <input type="text" id="from_long" name="from_long" required></p>')

print('<p>To Location Latitude: <input type="text" id="to_lat" name="to_lat" required>')
print('\tTo Location Longitude: <input type="text" id="to_long" name="to_long" required></p>')

print('<p>Skipper: <input type="text" id="skipper" name="skipper" required></p>')

print('<p>Reservation start date: <input type="date" id="r_start_date" name="r_start_date" required>')
print('\tReservation end date: <input type="date" id="r_end_date" name="r_end_date" requires></p>')

print('<p>Boat Code: <input type="text" name="cni" required>')
print('\tBoat Country: <input type="text" name="boat_country" required></p>')
print('<input type="submit" value="Confirm"/>')
print('</form>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    connection.autocommit = False
    cursor = connection.cursor()
    
    # Making query
    sql = 'SELECT * FROM location;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    
    # Displaying results
    print('<h3>Locations</h3>')
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
