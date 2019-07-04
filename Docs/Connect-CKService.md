---
external help file: Secure-ChainKit-help.xml
Module Name: Secure-ChainKit
online version:
schema: 2.0.0
---

# Connect-CKService

## SYNOPSIS
Connect to the Chainkit service

## SYNTAX

```
Connect-CKService [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet establishes a connection to the Chainkit service.
When an authorized PSCredential is passed, the cmdlet will return a token for the service.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-CKService -Credential $cred
```

This example connects to the Chainkit service.
It used the credentials passed in $cred variable, which should be an object of type PSCredential

## PARAMETERS

### -Credential
This parameter accepts a PSCredential object.
The PSCredential object shall contain an authorized user to connect to the Chainkit service

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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
