---
external help file: Secure-ChainKit-help.xml
Module Name: Secure-ChainKit
online version:
schema: 2.0.0
---

# Test-CKFile

## SYNOPSIS
Verify a file with the Chainkit service

## SYNTAX

```
Test-CKFile [-Path] <String> [-Hash] <String> [-EntityId] <String> [[-Storage] <String>]
 [[-HashAlgorithm] <String>] [-Abort] [<CommonParameters>]
```

## DESCRIPTION
The cmdlet will verify a file with the Chainkit service.
The cmdlet requires the Id of the file and the hash value for the file.
Both of these are returned when the file is registered with the Chainkit service.

## EXAMPLES

### Example 1
```powershell
PS C:\> Test-CKFile -Path .\script.ps -Hash 'b76079420bed24a001ea71bcda81e9c35ee69556f8a8cd56abe8c0c4256d5d8e' -EntityId '6555513238948619626'
```

Verifies a file with the Chainkit service.
The file needs to have been registered with the Chainkit service before, see the Register-CKFile cmdlet.

## PARAMETERS

### -Abort
An optional switch that

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EntityId
The Id recieved from the Chainkit service when the file was registered

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hash
The Hash value recieved from the Chainkit service when the file was registered

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HashAlgorithm
Speficy which hashing algorithm is used.
The default is HASH256

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path to the file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Storage
Specifies the type of storage used.
The default value is 'vmware'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
