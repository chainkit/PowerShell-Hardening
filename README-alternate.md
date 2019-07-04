# PowerShell Hardening Demo

Copy the complete module folder **Secure-ChainKit** to one of the module folders defined in `$env:PSModulePath`

Import the `Secure-Chainkit` module

```powershell
PS C:\Users\SecureUser> Import-Module -Name Secure-ChainKit
```

Start by **autheticating** to the Chainkit service.

The `Connect-CKService` cmdlet requires a `PSCredential` to be passed.

Some ways to create such a PSCredential object.

* from a JSON file

```powershell
# Get Credentials from a JSON file
$credJson = Get-Content -Path .\credentials.json | ConvertFrom-Json
$pswdSec = $credJson.password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $credJson.user, $pswdSec
```

* from an Environment variable

```powershell
# Get Credentials from Environment Variables CKUSER/CKPASS
$pswdSec = $env:CKPASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:CKUSER, $pswdSec
```
* from prompting the user

```powershell
# Get Credentials Interactively from User
$cred = Get-Credential
```

Now you are ready to connect to the Chainkit service

```powershell
# Connect to ChainKit
Connect-CKService -Credential $cred | Out-Null
```

Once connected, you can protect a .ps1 script.

```powershell
# Protect a Script
PS C:\Users\SecureUser> Protect-CKScript -Path 'C:\Path-To\helloworld.ps1'
```

You can now execute this protected script.
When the script has been tampered with, the script will stop with a message.

```powershell
# Execute Hardened Script
PS C:\Users\SecureUser> C:\Path-To\Secure-helloworld.ps1
```

# Feedback

We hope you enjoyed using this. Please send all comments
and feedback to info@chainkit.com
