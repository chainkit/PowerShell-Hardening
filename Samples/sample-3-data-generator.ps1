#region vCenter
# Data is stored in JSON file
# Layout file
# {
#   "vCenter": "vcsa-FQDN"
# }

$data = Get-Content -Path .\vcenter.json | ConvertFrom-Json
Connect-VIServer -Server $data.vCenter | Out-Null
#endregion

$clusterName = 'cluster'
$vmNames = 'vm1', 'vm2', 'vm3', 'badvm', 'vm4'

$cluster = Get-Cluster -Name $clusterName

# Create VMs
$vms = $vmNames |
ForEach-Object -Process {
    $cpu = Get-Random -Minimum 1 -Maximum 4
    $mem = Get-Random -Minimum 1 -Maximum 8
    $space = Get-Random -Minimum 1 -Maximum 10

    Write-Host "Creating VM $_"
    New-VM -Name $_ -DiskGB $space -NumCpu $cpu -MemoryGB $mem -ResourcePool $cluster -DiskStorageFormat Thin
}

# Remove VMs
Write-Host "Removing VMs"
$vms | Remove-VM -DeletePermanently -Confirm:$false

#region vCenter
Disconnect-VIServer -Server $global:DefaultVIServer -Confirm:$false
#endregion
