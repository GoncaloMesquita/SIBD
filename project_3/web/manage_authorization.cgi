#!/usr/bin/python3
import psycopg2, cgi
import login
form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
start_date = form.getvalue('start')
end_date = form.getvalue('end')
cni = form.getvalue('cni')
country = form.getvalue('country')

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
connection = None
# create input button to add sailor
print('<h3>Details</h3><p>Start Date: {} | End Date: {} | Boat Country: {} | CNI: {}</p>'.format(start_date,end_date,country,cni))
print('<h3>Add New Sailor</h3>')
print('<form action="add_authorization.cgi?start={}&end={}&country={}&cni={}" method="post">'.format(start_date,end_date,country,cni))
print('<p>Email: <input type="text" name="email" required></p>')
print('<p><input type="submit" value="Add"></p>')

print('</form>')
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    connection.autocommit = False
    cursor = connection.cursor()
    
    sql = "SELECT * FROM authorised WHERE start_date = %(start_date)s AND end_date = %(end_date)s AND boat_country = %(country)s AND cni = %(cni)s"
    cursor.execute(sql, {'start_date': start_date, 'end_date': end_date, 'country': country, 'cni': cni})
    result = cursor.fetchall()

    if len(result) == 0:
        print('There is no Authorised sailors for this Reservation')
    else:
        # Displaying results
        print('<table border="1" cellspacing="5">')
        print('<tr>')
        print('<th>Sailor emails</th>')
            
        path = "remove_authorization.cgi?start={}&end={}&country={}&cni={}".format(start_date,end_date,country,cni)
        print('</tr>')
        for row in result:
            print('<tr>')
            print('<td>{}</td>'.format(row[4]))
            print('<td><a href = "{}">Remove</a></td>'.format(path + '&email=' + row[4]))
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
