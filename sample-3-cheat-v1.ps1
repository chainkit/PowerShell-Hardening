$fileName = '.\sample-3.ps1'

(Get-Content -Path $fileName |
    ForEach-Object -Process {
        $_.Replace('"vm"', '"^vm"')
    }) | Out-File -FilePath $fileName
