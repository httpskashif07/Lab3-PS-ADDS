LAB3- PS-ADDS
This is my submission for Lab 3. 
In this LAB I used PowerShell to work with Active Directory on my Windows Server. I wrote the script as per the template provided by the Professor and using that script,
I have created bulk users with my domain: Kashif.powershell.com.

## How my script works

- It uses `Import-Csv` to read the Users.csv file.
- For every user in the file, it puts the user's details in a hashtable.
- Then it passes the hashtable to `New-ADUser`.
- `-PassThru` sends the new user to `Enable-ADAccount` so the account gets enabled.

I also changed my script to follow the template we were given in class, so it has the help section at the top and separate parts for parameters, functions, and execution code.

## How to run it

Run this on the server:

    .\AddNewUser.ps1

If the CSV file is in a different folder, you can give the path like this:

    .\AddNewUser.ps1 -CsvPath "C:\Lab3\Users.csv"
To check or confirm that the users are createdd we can run this below command: 
    `Get-ADUser -Filter 'UserPrincipalName -like "*@Kashif.powershell.com"' | Format-Table Name, UserPrincipalName, Enabled`

To see the names of the users created run the  command:
  ` Get-ADUser -Filter * | Select-Object Name ` 
  
   
## What I learned

How to use a CSV file to create many users at once
