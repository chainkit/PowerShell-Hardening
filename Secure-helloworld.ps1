#region CK
<# CK #>    Try {
<# CK #>        $tCK = @{
<# CK #>            Path = '.\Secure-helloworld.ps1'
<# CK #>            Hash = '86e04ad5ca7da6ec3bc58bca56cc549c6831d417c86b943c0f54db3d55e75a74'
<# CK #>            EntityId = '5385124042778813687'
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

Write-Output 'Hello, World'
