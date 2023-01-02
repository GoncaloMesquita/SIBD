#!/usr/bin/python3
import psycopg2, cgi
import login
form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
r_start_date = form.getvalue('r_start_date')
r_end_date = form.getvalue('r_end_date')
takeoff = form.getvalue('takeoff')
cni = form.getvalue('cni')
boat_country = form.getvalue('boat_country')
arrival = form.getvalue('arrival')
insurance = form.getvalue('insurance')
from_lat = form.getvalue('from_lat')
from_long = form.getvalue('from_long')
to_lat = form.getvalue('to_lat')
to_long = form.getvalue('to_long')
skipper = form.getvalue('skipper')


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
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    
    verify_trip = "SELECT * FROM trip WHERE takeoff = %(takeoff)s AND reservation_start_date = %(r_start_date)s AND reservation_end_date = %(r_end_date)s  AND boat_country = %(boat_country)s AND cni = %(cni)s"
    cursor.execute(verify_trip, {'takeoff': takeoff, 'r_start_date': r_start_date
                                , 'r_end_date': r_end_date, 'boat_country': boat_country, 'cni': cni})
    result = cursor.fetchall()

    if len(result) == 0:
        insert_trip = "INSERT INTO trip VALUES(%(takeoff)s, %(arrival)s, %(insurance)s,\
                                                %(from_latitude)s, %(from_longitude)s, %(to_latitude)s, %(to_longitude)s,\
                                                %(skipper)s,%(r_start_date)s, %(r_end_date)s, %(boat_country)s, %(cni)s)"

        cursor.execute(insert_trip, {'takeoff': takeoff, 'arrival': arrival,'insurance':insurance,
                                    'from_latitude': from_lat, 'from_longitude': from_long,
                                    'to_latitude': to_lat, 'to_longitude': to_long, 'skipper': skipper,
                                    'r_start_date': r_start_date, 'r_end_date': r_end_date, 'boat_country': boat_country, 'cni': cni})
        connection.commit()
        print('Create New Trip: SUCCESS')
    else:
        print('Trip already exists')

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
