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
