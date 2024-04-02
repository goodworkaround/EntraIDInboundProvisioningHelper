# EntraIDInboundProvisioningHelper
A PowerShell module for backing up and restoring Entra ID Inbound Provisioning sync rules

## Usage - backup and restore

```PowerShell
# Back up to backup.json
Backup-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6

# Restore
Restore-InboundProvisioningMapping-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6
```

## Usage - documentation

```PowerShell
# Document as markdown
Save-InboundProvisioningDocumentation -ObjectId "5c8bd3c5-e4dd-47ec-8103-1445c8d242fb" -PathWithoutExtension ~\downloads\doc -Format markdown

# Document as html and open in browser
Save-InboundProvisioningDocumentation -ObjectId "5c8bd3c5-e4dd-47ec-8103-1445c8d242fb" -PathWithoutExtension ~\downloads\doc -Format html -DoNotIncludeDirectories -SuperDetailed | ii
```