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
