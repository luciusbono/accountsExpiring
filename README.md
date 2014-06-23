accountsExpiring
================
A script that will search Active Directory for accounts that are expiring in a certain amount of days (default 14) and output those accounts to a CSV file. 

USAGE -- accountsExpiring [OPTIONAL: Days until expiraton (integer)] [OPTIONAL: Path]

REQUIREMENTS: Powershell 2.0 or above (including in Windows 7 and Windows 8/8.1). Active Directory Users and Computers, or Remote Server Administration Tools

RSAT for Windows 8.1: http://www.microsoft.com/en-us/download/details.aspx?id=39296

RSAT for Windows 8: http://www.microsoft.com/en-us/download/details.aspx?id=28972

RSAT for Windows 7: http://www.microsoft.com/en-us/download/details.aspx?id=7887

This script will output all of the user accounts within your domain that will expire in a certain amount of days (default 14) as a CSV file. The default path for this CSV file is on the Desktop folder of the account that ran the script, with the current date in the format: IsExpired[M-D-YYYY].csv

The script will output the name of the employee, the employee's manager, the e-mail of the manager, the account's expiration date, the state of the account (enabled or disabled), department, division, title of the employee, samaccountname, mail, telephone and employeeID.