#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
start_date = form.getvalue('start_date')
end_date = form.getvalue('end_date')
cni = form.getvalue('cni')
country = form.getvalue('country')
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
print('<h2>Reservation</h2>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    connection.autocommit = False
    cursor = connection.cursor()
    
    
    verify_reserve = "SELECT * FROM reservation WHERE start_date = %(start_date)s AND end_date = %(end_date)s AND country = %(country)s AND cni = %(cni)s"
    cursor.execute(verify_reserve, {'start_date': start_date, 'end_date': end_date, 'country': country, 'cni': cni})
    result = cursor.fetchall()

    if len(result) == 0:
        print("Reservation doesn't exist")
    else:
        delete_reserve = "DELETE FROM reservation WHERE start_date = %(start_date)s AND end_date = %(end_date)s AND country = %(country)s AND cni = %(cni)s"
        cursor.execute(delete_reserve, {'start_date': start_date, 'end_date': end_date, 'country': country, 'cni': cni})
        connection.commit()
        print('Reservation deleted: SUCCESS')

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
