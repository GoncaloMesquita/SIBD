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
print('<div>')
print('</head>')
print('<body>')
print('<h2>Reservation</h2>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    
    verify_reserve = "SELECT * FROM reservation WHERE start_date = %(start_date)s AND end_date = %(end_date)s AND country = %(country)s AND cni = %(cni)s"
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
        verify_sailor = "SELECT * FROM senior WHERE email = %(email)s"
        cursor.execute(verify_sailor, {'email': email})
        result = cursor.fetchall()
        if len(result) == 0:
            print("There's no senior sailor with that email")
            exit()
        
        # Verify if date interval is valid if not, create new interval
        if start_date > end_date:
            print("Invalid date interval")
            exit()

        verify_date = "SELECT * FROM date_interval WHERE start_date = %(start_date)s AND end_date = %(end_date)s"
        cursor.execute(verify_date, {'start_date': start_date, 'end_date': end_date})
        result = cursor.fetchall()
        if len(result) == 0:
            insert_date = "INSERT INTO date_interval VALUES(%(start_date)s, %(end_date)s)"
            cursor.execute(insert_date, {'start_date': start_date, 'end_date': end_date})
            connection.commit()
        

        # After all verifications, create reservation
        insert_reserve = "INSERT INTO reservation VALUES(%(start_date)s, %(end_date)s, %(country)s, %(cni)s, %(email)s)"
        cursor.execute(insert_reserve, {'start_date' : start_date, 'end_date': end_date, 'country': country, 'cni': cni, 'email': email})
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
