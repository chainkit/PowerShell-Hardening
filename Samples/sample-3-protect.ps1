# Get ChainKit credentials

$credentials = Get-Content -Path .\credentials.json | ConvertFrom-Json

# Make sure we have the latest copy of the module

Remove-Module -Name Secure-ChainKit -ErrorAction SilentlyContinue
Import-Module .\Secure-ChainKit-v2\Secure-ChainKit.psm1 -Force

# Connect to ChainKit

$pswdSec = $credentials.password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $credentials.user, $pswdSec
Connect-CKService -Credential $cred | Out-Null

# Protect file

$file = '.\sample-3.ps1'
$protectData = Protect-CKScript -Path $file
$protectData
