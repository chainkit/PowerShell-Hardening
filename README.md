# PowerShell Hardening Demo

Ensure you have a Powershell Startup:

```powershell
PS C:\Users\SecureUser> New-Item -path $profile -type file -force
```

Include this line in your PowerShell Startup script, usually
`Microsoft.Powershell_profile.ps1`:

```powershell
$env:PDUSER = "SecureChainKitUser"
$env:PDPASS = "changeme"
. C:\Path-To\Secure-ChainKit.ps1
```

## Set the Credentials

In Environmental Variables, set the `PDUSER` and `PDPASS` variables.
For securing on the secure VMware based concord blockchain, set `PDSTORAGE` to
`concord`, currently the default.

## Harden a Script

```powershell
PS C:\Users\SecureUser> TamperProof-CK C:\Path-To\HelloWorld.ps1
```

## Execute Hardened Script

```powershell
PS C:\Users\SecureUser> C:\Path-To\Secure-HelloWorld.ps1
```

## Feedback

We hope you enjoyed using this. Please send all comments
and feedback to info@chainkit.com
