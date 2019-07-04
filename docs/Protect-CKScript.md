---
external help file: Secure-ChainKit-help.xml
Module Name: Secure-ChainKit
online version:
schema: 2.0.0
---

# Protect-CKScript

## SYNOPSIS
Protect a script with the Chainkit service

## SYNTAX

```
Protect-CKScript [-Path] <String> [[-Storage] <String>] [[-HashAlgorithm] <String>] [[-Prefix] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet protects the script, specified via the Path parameter.
The protection is implemented by adding code at the beginning of the script.
This code makes a verification call to the Chainkit service, which determines if
the script has been tampered with or not.
The protected script is written to a new file.
The name of the new file, is composed of the Prefix value (default is 'Secure') and
the filename of the script.

## EXAMPLES

### Example 1
```powershell
PS C:\> Protect-CKScript -Path .\script.ps1
```

This creates a new file, named Secure-script.ps1, in the same folder as the original script.
The new script contains the code to call the Cahinkit service to the verify the hash code of the script

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
The path to the script we want to protect.

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

### -Prefix
Defines the prefix that will be used for the new file that is generated.
The default prefix is 'Secure-'

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
