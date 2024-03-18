# EntraIDInboundProvisioningHelper
A PowerShell module for backing up and restoring Entra ID Inbound Provisioning sync rules

## Usage

```PowerShell
# Back up to backup.json
Backup-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6

# Restore
Restore-InboundProvisioningMapping-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6
```