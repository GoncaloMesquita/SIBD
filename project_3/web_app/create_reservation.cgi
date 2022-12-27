#!/usr/bin/python3
import psycopg2, cgi
import login
form = cgi.FieldStorage()
#getvalue uses the names from the form in previous page
start_date = form.getvalue('calendar_start')
end_date = form.getvalue('calendar_end')
cni = form.getvalue('cni')
country = form.getvalue('country')
email = form.getvalue('email')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>SIBD Project</title>')
print('<div><h3>Menu</h3>')
print('<a href="sailors.cgi">Sailors</a> | <a href="reservations.cgi">Reservations</a>')
print('<div>')
print('</head>')
print('<body>')
print('<h2>Reservation</h2>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    
    verify_reserve = "SELECT * FROM reservation WHERE start_date = %(start_date)s, end_date = %(end_date)s, country = %(country)s, cni = %(cni)s"
    cursor.execute(verify_reserve, {'start_date': start_date, 'end_date': end_date, 'country': country, 'cni': cni})
    result = cursor.fetchall()

    if len(result) == 0:
        # Verify if country exists
        verify_country = "SELECT * FROM country WHERE name = %(country)s"
        cursor.execute(verify_country, {'country': country})
        result = cursor.fetchall()
        if len(result) == 0:
            print("Country doesn't exist")
            exit()
        #verify if boat exists
        verify_boat = "SELECT * FROM boat WHERE cni = %(cni)s"
        cursor.execute(verify_boat, {'cni': cni})
        result = cursor.fetchall()
        if len(result) == 0:
            print("Boat doesn't exist")
            exit()
        #verify if sailor exists
        verify_sailor = "SELECT * FROM sailor WHERE email = %(email)s"
        cursor.execute(verify_sailor, {'email': email})
        result = cursor.fetchall()
        if len(result) == 0:
            print("Sailor doesn't exist")
            exit()
        # After all verifications, create reservation
        insert_sailor = "INSERT INTO reservation VALUES(%(start_date)s, %(end_date)s, %(country)s, %(cni)s, %(email)s)"
        cursor.execute(insert_sailor, {'start_date' : start_date, 'end_date': end_date, 'country': country, 'cni': cni, 'email': email})
        connection.commit()
        print('Create New Reservation: SUCCESS')
    else:
        print('Reservation already exists')

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
