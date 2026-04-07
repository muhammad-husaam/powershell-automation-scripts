# ================================
# Bulk User Creation Script
# Author: Muhammad Husaam
# Date: 2026
# Description: Creates AD users from CSV file
# ================================

# Import Active Directory module
Import-Module ActiveDirectory

# Path to CSV file
$csvPath = "C:\Users\Administrator\Desktop\users.csv"

# Import users from CSV
$users = Import-Csv -Path $csvPath

# Loop through each user
foreach ($user in $users) {
    $firstName = $user.FirstName
    $lastName = $user.LastName
    $username = $user.Username
    $department = $user.Department
    $fullName = "$firstName $lastName"
    $password = ConvertTo-SecureString "Welcome@1234" -AsPlainText -Force

    # Check if user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue) {
        Write-Host "User $username already exists - skipping" -ForegroundColor Yellow
    } else {
        # Create the user
        New-ADUser `
            -Name $fullName `
            -GivenName $firstName `
            -Surname $lastName `
            -SamAccountName $username `
            -UserPrincipalName "$username@lab.local" `
            -Department $department `
            -AccountPassword $password `
            -Enabled $true `
            -Path "OU=IT Department,DC=lab,DC=local"

        Write-Host "Created user: $username ($fullName) - $department" -ForegroundColor Green
    }
}

Write-Host "`nBulk user creation complete!" -ForegroundColor Cyan
