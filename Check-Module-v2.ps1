$credentials = Get-Content -Path .\credentials.json | ConvertFrom-Json

Remove-Module -Name Secure-ChainKit -ErrorAction SilentlyContinue
Import-Module .\Secure-ChainKit-v2\Secure-ChainKit.psm1 -Force -Verbose

$pswdSec = $credentials.password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $credentials.user, $pswdSec

$file = '.\sample-1.ps1'

Connect-CKService -Credential $cred
$regData = Register-CKFile -Path $file
$protectData = Protect-CKScript -Path $file
if (Test-CKFile -Path $file -Hash $protectData.Values[0].hash -EntityId $protectData.Values[0].entityId)
{
    & $protectData.Keys[0]
}
