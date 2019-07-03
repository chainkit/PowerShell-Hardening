# PowerShell Hardening Demo

Ensure you have a Powershell Startup:

```powershell
PS C:\Users\SecureUser> New-Item -path $profile -type file -force
```

Include this line in your PowerShell Startup script, usually

`Microsoft.Powershell_profile.ps1`:

```powershell
# Import ChainKit-Secure Module
Remove-Module -Name Secure-ChainKit -ErrorAction SilentlyContinue
Import-Module C:\Path-To\PowerShell-Hardening\Secure-ChainKit-v2\Secure-ChainKit.psm1 -Force

# Get Credentials from JSON
$credJson = Get-Content -Path .\credentials.json | ConvertFrom-Json
$pswdSec = $credJson.password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $credJson.user, $pswdSec

# (or) Get Credentials from Environment Variables CKUSER/CKPASS
$pswdSec = $env:CKPASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:CKUSER, $pswdSec

# (or) Get Credentials Interactively from User
$cred = Get-Credential

# Connect to ChainKit
Connect-CKService -Credential $cred | Out-Null
```

# Protect a Script

```powershell
PS C:\Users\SecureUser> Protect-CKScript -Path 'C:\Path-To\helloworld.ps1'
```

# Execute Hardened Script

```powershell
PS C:\Users\SecureUser> C:\Path-To\Secure-helloworld.ps1
```

# Feedback

We hope you enjoyed using this. Please send all comments
and feedback to info@chainkit.com
