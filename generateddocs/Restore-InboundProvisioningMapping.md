# Restore-InboundProvisioningMapping

## SYNOPSIS
Restores inbound provisioning mapping from a file created by the backup cmdlet.

## SYNTAX

```
Restore-InboundProvisioningMapping [-ObjectId] <String> [[-File] <String>]
 [-RestoreToDifferentServicePrincipal] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Restores inbound provisioning mapping from a file created by the backup cmdlet.

## EXAMPLES

### EXAMPLE 1
```
Restore-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6
```

### EXAMPLE 2
```
Restore-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6 -RestoreToDifferentServicePrincipal -File backup2.json
```

## PARAMETERS

### -ObjectId
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

### -File
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

### -RestoreToDifferentServicePrincipal
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

### -ProgressAction
{{ Fill ProgressAction Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
