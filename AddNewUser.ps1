<#
.SYNOPSIS
    Creates Active Directory users from a CSV file.

.DESCRIPTION
    This script reads Users.csv and creates a new user in Active Directory
    for each row. A hashtable is used to hold the user properties, which are
    then passed to New-ADUser (splatting). Each new account is enabled after
    it is created.

    The CSV file must have these columns:
    firstName, lastName, userName, userPrincipalName

.PARAMETER CsvPath
    The full path to the Users.csv file.

.EXAMPLE
    Example usage:
    PS> .\AddNewUser.ps1

.EXAMPLE
    Using a CSV file saved in a different folder:
    PS> .\AddNewUser.ps1 -CsvPath "C:\Lab3\Users.csv"

.NOTES
    Author: Kashif
    Created: 2026-10-04
    Version: 1.0
    Last Modified: 2026-10-04
    Domain: Kashif.powershell.com
    Change Log:
        1.0 - Initial release

.LINK
    https://learn.microsoft.com/powershell/module/activedirectory/new-aduser
#>

#Parameters
param(
    [string]$CsvPath = "C:\Users\Administrator\Documents\LAB3-KASHIF\Users.csv"
)

#Functions
function Add-NewUser {
    param(
        $User
    )

    # Hashtable that holds the properties for the new user
    $NewUserParameters = @{
        'GivenName'         = $User.firstName
        'Surname'           = $User.lastName
        'Name'              = $User.userName
        'SamAccountName'    = $User.userName
        'UserPrincipalName' = $User.userPrincipalName
        'AccountPassword'   = (ConvertTo-SecureString "p@33w0rd" -AsPlainText -Force)
    }

    # Create the user, then enable the account
    New-ADUser @NewUserParameters -PassThru | Enable-ADAccount

    Write-Host "User created: $($User.userPrincipalName)"
}

#Execution Code
Import-Csv $CsvPath | ForEach-Object {
    Add-NewUser -User $_
}

Write-Host "All users from the CSV file have been processed."
