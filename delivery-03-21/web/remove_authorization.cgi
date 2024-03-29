#!/usr/bin/python3
import psycopg2, cgi
import login
form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
start_date = form.getvalue('start')
end_date = form.getvalue('end')
country = form.getvalue('country')
cni = form.getvalue('cni')
sailor = form.getvalue('email')
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>SIBD Project</title>')
print('<div><h3>Menu</h3>')
print('<a href="sailors.cgi">Sailors</a> | <a href="reservations.cgi">Reservations</a> | <a href="trips.cgi">Trips</a>')
print('</div>')
print('</head>')
print('<body>')
print('<h2>Reservation</h2>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    # connection.autocommit = False
    cursor = connection.cursor()
    
    sql = "SELECT * FROM authorised WHERE start_date = %(start_date)s AND end_date = %(end_date)s AND boat_country = %(country)s AND cni = %(cni)s AND sailor = %(sailor)s"
    cursor.execute(sql, {'start_date': start_date, 'end_date': end_date, 'country': country, 'cni': cni, 'sailor': sailor})
    result = cursor.fetchall()
    if len(result) != 0:
        delete = "DELETE FROM authorised WHERE start_date = %(start_date)s AND end_date = %(end_date)s AND boat_country = %(boat_country)s AND cni = %(cni)s AND sailor = %(sailor)s"
        cursor.execute(delete, {'start_date': start_date, 'end_date': end_date, 'boat_country': country, 'cni': cni, 'sailor': sailor})
        connection.commit()
        print('Sailor Deleted from Reservation')
    else:
        print('Sailor is not Authorized for this Reservation')
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
