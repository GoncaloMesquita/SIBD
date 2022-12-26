#!/usr/bin/python3
import cgi
form = cgi.FieldStorage()
account_number = form.getvalue('account_number')
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Lab 09</title>')
print('</head>')
print('<body>')
# The string has the {}, the variables inside format() will replace the {}
print('<h3>Change balance for account {}</h3>'.format(account_number))
# The form will send the info needed for the SQL query
print('<form action="update.cgi" method="post">')
print('<p><input type="hidden" name="account_number" value="{}"/></p>'.format(account_number))
print('<p>New balance: <input type="text" name="balance"/></p>')
print('<p><input type="submit" value="Submit"/></p>')
print('</form>')
print('</body>')
print('</html>')
