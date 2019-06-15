<#
Dot-Include this file to give you tamper-proof
PowerShell functionality for Windows.

. C:\Path-To\Secure-ChainKit.ps1

Usage:

Register-CK File
TamperProof-CK ScriptFile
Verify-CK File Hash EntityId

#>
Function Get-StringHash([String] $String, $HashAlgorithm = "SHA256")
{
    $StringBuilder = New-Object System.Text.StringBuilder
    [System.Security.Cryptography.HashAlgorithm]::Create($HashAlgorithm).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String))|%{ 
        [Void]$StringBuilder.Append($_.ToString("x2"))
    }
    $StringBuilder.ToString()
}

Function Auth-CK($User, $Password)
{
    $endPoint = "https://api.pencildata.com"

    if($User -eq $null) { Throw "Please set PDUSER variable." }
    if($Password -eq $null) { Throw "Please set PDPASS variable." }

    $authParams = @{userId=$User;password=$Password} | ConvertTo-Json
    $authHeaders = @{'Content-Type'='application/json'}

    $response = Invoke-WebRequest -Uri $endPoint"/token" -Method POST -Body $authParams -Headers $authHeaders
    $responseParsed = $response | ConvertFrom-Json
    $authToken = $responseParsed.data.accessToken

    return $authToken
}

Function Register-CK($ScriptFile, $Storage = $null, $HashAlgorithm = "SHA256", $Token = $null)
{
    if($Token -eq $null) { $env:PDTOKEN }
    if($Token -eq $null) { $Token = Auth-CK $env:PDUSER $env:PDPASS }
    if($Storage -eq $null) { $Storage = $env:PDSTORAGE }
    if($Storage -eq $null) { $Storage = "concord" }

    $Content = Get-Content $ScriptFile
    $contentsHash = Get-StringHash $Content $HashAlgorithm

    $endPoint = "https://api.pencildata.com"
    $description = "Hardened Script: {0}" -f $ScriptFile
    $registerParams = @{hash=$contentsHash;description=$description;storage=$Storage} | ConvertTo-Json
    $bearerToken = "Bearer `"{0}`"" -f $Token
    $registerHeaders = @{'Content-Type'='application/json';'Authorization'=$bearerToken}

    $response = Invoke-WebRequest -Uri $endPoint"/register" -Method POST -Body $registerParams -Headers $registerHeaders
    $entityId = $response | ConvertFrom-Json

    return @{'entityId'=$entityId;'hash'=$contentsHash}
}

Function Verify-CK($ScriptFile, $Hash, $EntityId, $Storage = $null, $HashAlgorithm = "SHA256", $Token = $null, $SkipLine = 0)
{
    if($Token -eq $null) { $env:PDTOKEN }
    if($Token -eq $null) { $Token = Auth-CK $env:PDUSER $env:PDPASS }
    if($Storage -eq $null) { $Storage = $env:PDSTORAGE }
    if($Storage -eq $null) { $Storage = "concord" }

    if($SkipLine -ne 0) {
        $Content = Get-Content $ScriptFile | Where { $_.readcount -ne $SkipLine }
    } else {
        $ContainsSelfLine = Get-Content $ScriptFile -First 1
        if ($ContainsSelfLine -match "Verify-CK") {
          $Content = Get-Content $ScriptFile | Select-Object -skip 1
        } else {
          $Content = Get-Content $ScriptFile
        }
    }
    $contentsHash = Get-StringHash $Content $HashAlgorithm

    if( $contentsHash -ne $Hash ) {
        Throw "Script {0} does not have Hash of {1}" -f ($ScriptFile, $Hash)
    }

    $endPoint = "https://api.pencildata.com"
    $bearerToken = "Bearer `"{0}`"" -f $Token
    $verifyHeaders = @{'Content-Type'='application/json';'Authorization'=$bearerToken}
    $response = Invoke-WebRequest -Uri $endPoint"/verify/"$EntityId"?storage="$Storage"&hash="$contentsHash -Method GET -Headers $verifyHeaders
    $status = $response | ConvertFrom-Json

    if( ! $status ) {
        Throw "Script {0} does not exist on Blockchain." -f ($ScriptFile)
    }
}

Function TamperProof-CK ($ScriptFile, $Storage = $null, $HashAlgorithm = "SHA256", $Token = $null)
{
    if($Token -eq $null) { $env:PDTOKEN }
    if($Token -eq $null) { $Token = Auth-CK $env:PDUSER $env:PDPASS }
    if($Storage -eq $null) { $Storage = $env:PDSTORAGE }
    if($Storage -eq $null) { $Storage = "concord" }

    $returnValues = @{}

    $scriptOutputDir = Split-Path $ScriptFile
    $scriptOutputFile = Split-Path $ScriptFile -leaf
    $scriptOutputFile = "$scriptOutputDir\Secure-$scriptOutputFile"

    $returnValue = Register-CK $ScriptFile $Storage $HashAlgorithm $Token
    $scriptLet = "Verify-CK `$MyInvocation.MyCommand.Path `"{0}`" `"{1}`" `"{2}`" `"{3}`"" -f ($returnValue.hash, $returnValue.entityId, $Storage, $HashAlgorithm)
    $scriptLet | Out-File -FilePath $scriptOutputFile
    Get-Content $ScriptFile | Out-File -FilePath $scriptOutputFile -Append

    $returnValues.Add( $scriptOutputFile, $returnValue )

    return $returnValues
}

#Enclose Verify-CK
Verify-CK $MyInvocation.MyCommand.Path "28d5e2f6a9040ae413e63da6672a932a06450e2062e7e4f2a525e6b6f0556561" "5179474438289669711" "concord" "SHA256" $null 120
Write-Output "Loaded Secure-ChainKit."
#End-Enclose Verify-CK

foreach ( $scriptFile in  $args ) {
    TamperProof-CK $scriptFile
}
