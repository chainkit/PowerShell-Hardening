---
external help file: Secure-ChainKit-help.xml
Module Name: Secure-ChainKit
online version:
schema: 2.0.0
---

# Register-CKFile

## SYNOPSIS
Register a file with the Chainkit service.

## SYNTAX

```
Register-CKFile [-Path] <String> [[-Storage] <String>] [[-HashAlgorithm] <String>] [[-Token] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet registers a file with the Chainkit service.
The Chainkit service will, after a successfull registration of the file, return an Id and the Hash for the file.

## EXAMPLES

### Example 1
```powershell
PS C:\> Register-CKFile -Path .\script.ps1
```

The file specified on the Path parameter is registered with the Chainkit service.

## PARAMETERS

### -HashAlgorithm
Speficy which hashing algorithm is used.
The default is HASH256

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path to the file we want to register.

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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
A token as returned by the Connect-CKService cmdlet.
When a successful Connect-CKService was done, the Secure-Chainkit module will remember that token.

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
