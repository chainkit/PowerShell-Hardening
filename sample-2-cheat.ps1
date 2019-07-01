$fileName = '.\Secure-sample-2.ps1'

(Get-Content -Path $fileName |
    ForEach-Object -Process {
        $_.Replace('esx[12]', 'esx[13]')
    }) | Out-File -FilePath $fileName
