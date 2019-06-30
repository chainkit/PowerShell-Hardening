$script:EndPoint = "https://api.pencildata.com"

Function Get-StringHash
{
    [cmdletbinding()]
    param(
        [string]$String,
        [string]$HashAlgorithm
    )

    $StringBuilder = New-Object System.Text.StringBuilder
    [System.Security.Cryptography.HashAlgorithm]::Create($HashAlgorithm).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String)) | % {
        [Void]$StringBuilder.Append($_.ToString("x2"))
    }
    $StringBuilder.ToString()
}

function Invoke-RestAPI
{
    [cmdletbinding()]
    param(
        [hashtable]$Arguments
    )

    try
    {
        Invoke-WebRequest @Arguments
    }
    catch [System.Net.WebException]
    {
        $_.ErrorDetails.Message | Out-Default
        throw "Web request failed"
    }
    catch
    {
        $_.ErrorDetails.Message | Out-Default
        throw "General exception"
    }
}

Function Connect-CKService
{
    [cmdletbinding()]
    param(
        [PSCredential]$Credential
    )

    $credPlain = $Credential.GetNetworkCredential()
    $user = $credPlain.UserName
    $pswd = $credPlain.password

    $sWeb = @{
        Uri = "$($script:EndPoint)/token"
        Method = 'POST'
        Body = @{userId = $user; password = $pswd } | ConvertTo-Json
        Headers = @{'Content-Type' = 'application/json' }
    }
    $response = Invoke-RestAPI -Arguments $sWeb
    $script:ChainKitToken = ($response | ConvertFrom-Json).data.accessToken

    return $script:ChainKitToken
}

Function Disconnect-CKService
{
    [cmdletbinding()]
    param()

    $script:ChainKitToken = $null
}

Function Register-CKFile
{
    [cmdletbinding()]
    param(
        [string]$Path,
        [string]$Storage = 'concord',
        [string]$HashAlgorithm = "SHA256",
        [string]$Token = $script:Token
    )

    if ($null -eq $script:ChainKitToken)
    {
        Write-Error "You are currently not connected to the ChainKit service."
        return
    }

    $Content = Get-Content -Path $Path
    $contentsHash = Get-StringHash $Content $HashAlgorithm

    $sWeb = @{
        Uri = "$($script:EndPoint)/register"
        Method = 'POST'
        Body = @{
            hash = $contentsHash
            description = "Hardened Script: {0}" -f $Path
            storage = $Storage
        } | ConvertTo-Json
        Headers = @{
            'Content-Type' = 'application/json'
            Authorization = "Bearer $('{0}' -f $script:ChainKitToken)"
        }
    }
    $response = Invoke-RestAPI -Arguments $sWeb
    $entityId = $response | ConvertFrom-Json

    return @{'entityId' = $entityId; 'hash' = $contentsHash }
}

Function Test-CKFile()
{
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$Path,
        [string]$Hash,
        [string]$EntityId,
        [string]$Storage = "concord",
        [string]$HashAlgorithm = "SHA256",
        [int]$SkipLine = 0
    )

    if ($null -eq $script:ChainKitToken)
    {
        Write-Error "You are currently not connected to the ChainKit service."
        return
    }

    $content = Get-Content -Path $Path |
    Where-Object { $_.ReadCount -ne $SkipLine -and ($_.ReadCount -eq 1 -and $_ -notmatch 'Test-CKFile') }
    $contentHash = Get-StringHash -String $content -HashAlgorithm $HashAlgorithm

    if ( $contentHash -ne $hash )
    {
        Throw "Script $Path does not have Hash of $Hash"
    }

    $sWeb = @{
        Uri = "$($script:endPoint)/verify/$($EntityId)?storage=$($Storage)&hash=$($contentHash)"
        Method = 'GET'
        Headers = @{
            'Content-Type' = 'application/json'
            Authorization = "Bearer $('{0}' -f $script:ChainKitToken)"
        }
    }
    $response = Invoke-RestAPI -Arguments $sWeb
    $status = $response | ConvertFrom-Json
    $status
    #    if ( ! $status )
    #    {
    #        Throw "Script $($Path) does not exist on Blockchain."
    #    }
}

Function Protect-CKScript ()
{
    [cmdletbinding()]
    param(
        [STRING]$Path,
        [string]$Storage = 'concord',
        [string]$HashAlgorithm = "SHA256"
    )

    if ($null -eq $script:ChainKitToken)
    {
        Write-Error "You are currently not connected to the ChainKit service."
        return
    }

    $returnValues = @{ }

    $dir = Split-Path -Path $Path
    $file = Split-Path -Path $Path -leaf
    $newFile = "$dir\Secure-$file"

    $returnValue = Register-CKFile -Path $Path -Storage $Storage -HashAlgorithm $HashAlgorithm

    $fields = "Test-CKFile -Path $($Path)",
    "-Hash $($returnValue.hash)",
    "-EntityId $($returnValue.entityId)",
    "-Storage $Storage",
    "-HashAlgorithm $HashAlgorithm"
    $line = $fields -join ' '
    ($line, (Get-Content -Path $Path)) | Out-File -FilePath $newFile

    $returnValues.Add( $newFile, $returnValue )

    return $returnValues
}
