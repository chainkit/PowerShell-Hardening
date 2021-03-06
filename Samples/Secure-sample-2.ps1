#region CK
<# CK #>    Try {
<# CK #>        $tCK = @{
<# CK #>            Path = '.\Secure-sample-2.ps1'
<# CK #>            Hash = '95417d2378be6eca7ea7ec924ab3def4a64b2bfee4133fe66adee2a1c746c9f1'
<# CK #>            EntityId = '6335204226926482807'
<# CK #>            Storage = 'vmware'
<# CK #>            HashAlgorithm = 'SHA256'
<# CK #>            Abort = $true
<# CK #>        }
<# CK #>        Test-CKFile @tCK
<# CK #>    }
<# CK #>    Catch {
<# CK #>        Throw "Unable to verify script"
<# CK #>    }
#endregion CK

# Simple vSphere object retrieval

#
# Data is stored in JSON file
# Layout file
# {
#   "vCenter": "vcsa-FQDN"
# }
#

$data = Get-Content -Path .\vcenter.json | ConvertFrom-Json

Connect-VIServer -Server $data.vCenter | Out-Null

$mask = "esx[12].local.lab"
Get-VMHost -Name $mask | Select-Object Name

Disconnect-VIServer -Server $data.vCenter -confirm:$false
