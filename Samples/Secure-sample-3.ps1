#region CK
<# CK #>    Try {
<# CK #>        $tCK = @{
<# CK #>            Path = '.\Secure-sample-3.ps1'
<# CK #>            Hash = 'b76079420bed24a001ea71bcda81e9c35ee69556f8a8cd56abe8c0c4256d5d8e'
<# CK #>            EntityId = '5259921682639468397'
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

# Script to monitor VM life cycle
#
# Report on all VM creation, change and removal actions
#

#region vCenter
# Data is stored in JSON file
# Layout file
# {
#   "vCenter": "vcsa-FQDN"
# }

$data = Get-Content -Path .\vcenter.json | ConvertFrom-Json
Connect-VIServer -Server $data.vCenter | Out-Null
#endregion

$start = (Get-Date).AddMinutes(-5)
$rootFolder = Get-Folder -Name Datacenters

Get-VIEvent -Entity $rootFolder -Start $start -MaxSamples ([int]::MaxValue) |
Where-Object { $_.VM.Name -match "vm" -and ($_ -is [VMware.Vim.VmCreatedEvent] -or $_ -is [VMware.Vim.VmRemovedEvent]) } |
Sort-Object -Property CreatedTime |
Select-Object CreatedTime, UserName, @{ N = 'VM'; E = { $_.Vm.Name } }, FullFormattedMessage

Disconnect-VIServer -Server $data.vCenter -confirm:$false
