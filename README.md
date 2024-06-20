# Documentation for module EntraIDInboundProvisioningHelper

A module for backing up and restoring Entra ID Inbound Provisioning sync rules

| Metadata | Information |
| --- | --- |
| Version | 1.2.2 |
| Required modules | Microsoft.Graph.Authentication |
| Author | Marius Solbakken Mellum |
| Company name | Fortytwo |
| PowerShell version | 7.1 |

## Backup-InboundProvisioningMapping

### SYNOPSIS
Backs up the inbound provisioning mapping to a file.
This can be restored to the same service principal or another service principal by using the Restore cmdlet.

### SYNTAX

```
Backup-InboundProvisioningMapping [-ObjectId] <String> [[-File] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### DESCRIPTION
Backs up the inbound provisioning mapping to a file.
This can be restored to the same service principal or another service principal by using the Restore cmdlet.

### EXAMPLES

#### EXAMPLE 1
```
Backup-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6
```

### PARAMETERS

#### -ObjectId


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

#### -File


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

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Format-InboundProvisioningExpression

### SYNOPSIS

### SYNTAX

```
Format-InboundProvisioningExpression [-SyncRule] <String> [[-IndentationCharacters] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION
Formats an Inbound Provisioning Sync Rule expression for better readability

### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -SyncRule


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

#### -IndentationCharacters


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

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Get-InboundProvisioningDocumentation

### SYNOPSIS
{{ Fill in the Synopsis }}

### SYNTAX

```
Get-InboundProvisioningDocumentation [-ObjectId] <String> [[-Title] <String>] [-SuperDetailed]
 [-DoNotIncludeDirectories] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION


### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -DoNotIncludeDirectories


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

#### -ObjectId


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

#### -SuperDetailed


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

#### -Title


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

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

#### None
### OUTPUTS

#### System.Object
### NOTES

### RELATED LINKS
## Get-InboundProvisioningServicePrincipal

### SYNOPSIS
{{ Fill in the Synopsis }}

### SYNTAX

```
Get-InboundProvisioningServicePrincipal [-ObjectId] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### DESCRIPTION


### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -ObjectId


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

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

#### None
### OUTPUTS

#### System.Object
### NOTES

### RELATED LINKS
## Restart-InboundProvisioning

### SYNOPSIS

### SYNTAX

```
Restart-InboundProvisioning [-ObjectId] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION
Perform a deep restart of inbound provisioning job

### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -ObjectId


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

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Restore-InboundProvisioningMapping

### SYNOPSIS
Restores inbound provisioning mapping from a file created by the backup cmdlet.

### SYNTAX

```
Restore-InboundProvisioningMapping [-ObjectId] <String> [[-File] <String>]
 [-RestoreToDifferentServicePrincipal] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION
Restores inbound provisioning mapping from a file created by the backup cmdlet.

### EXAMPLES

#### EXAMPLE 1
```
Restore-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6
```

#### EXAMPLE 2
```
Restore-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6 -RestoreToDifferentServicePrincipal -File backup2.json
```

### PARAMETERS

#### -ObjectId
The object ID of the service principal with the Inbound Provisioning API

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

#### -File
The file to restore from

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Backup.json
Accept pipeline input: False
Accept wildcard characters: False
```

#### -RestoreToDifferentServicePrincipal
Restore to a different service principal

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Save-InboundProvisioningDocumentation

### SYNOPSIS
{{ Fill in the Synopsis }}

### SYNTAX

```
Save-InboundProvisioningDocumentation [-ObjectId] <String> [[-PathWithoutExtension] <String>]
 [[-Format] <String>] [-SuperDetailed] [-DoNotIncludeDirectories] [[-Title] <String>]
 [[-AdditionalCss] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION


### EXAMPLES

#### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

### PARAMETERS

#### -AdditionalCss


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -DoNotIncludeDirectories


```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -Format


```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: markdown, html

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ObjectId


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

#### -PathWithoutExtension


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

#### -SuperDetailed


```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -Title


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

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

#### None
### OUTPUTS

#### System.Object
### NOTES

### RELATED LINKS
