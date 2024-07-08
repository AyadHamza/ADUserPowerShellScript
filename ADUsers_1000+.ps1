# Import the Active Directory module
Import-Module ActiveDirectory

# Define the password
$password = ConvertTo-SecureString "password1." -AsPlainText -Force

# Read content from names file 
$getNames = Get-Content -Path "C:\Users\a-ahamza\Desktop\AD_PS-master\names.txt"

# Loop to create 1000 users
foreach ($n in $getNames){
    # Generate random first and last names (you can replace this with actual data if you have it)
    $firstName = $n.Split(" ")[0].ToLower()
    $lastName = $n.Split(" ")[1].ToLower()
    $username = "$($firstName.Substring(0,1))$($lastName)".ToLower()
    write-host "Create user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    # Create the user account in Active Directory
    New-ADUser `
        -SamAccountName $username `
        -UserPrincipalName "$username@my.com" `
        -Name "$firstName $lastName" `
        -GivenName $firstName `
        -Surname $lastName `
        -AccountPassword $password `
        -Enabled $true `
        -Path "OU=USERSFORFUN,DC=mydomain,DC=com" `
        -ChangePasswordAtLogon $false 
    
    # Optional: Output the username to confirm creation
    Write-Output "Created user: $username"
}

# Note: Replace "OU=YourOU,DC=yourdomain,DC=com" with the actual OU path in your Active Directory.
