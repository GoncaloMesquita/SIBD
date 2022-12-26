#!/usr/bin/python3
import psycopg2
import login
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Lab 09</title>')
print('</head>')
print('<body>')
connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    print('<p>Connected to Postgres with: {}.</p>'.format(login.credentials[:51]))
    cursor = connection.cursor()
    # Making query
    sql = 'SELECT * FROM account;'
    print('<p>{}</p>'.format(sql))
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    # Displaying results
    print('<p>{} records retrieved:</p>'.format(num))
    print('<table border="5">')
    print('<tr><td>account_number</td><td>branch_name</td><td>balance</td></tr>')
    for row in result:
        print('<tr>')
        for value in row:
        # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
        print('</tr>')
    print('</table>')
    #Closing connection
    cursor.close()
    print('<p>Connection closed.</p>')
    print('<p>Test completed successfully.</p>')
except Exception as e:
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()
print('</body>')
print('</html>')
