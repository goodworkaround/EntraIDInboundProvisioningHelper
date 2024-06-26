<#
.SYNOPSIS
Restores inbound provisioning mapping from a file created by the backup cmdlet.

.DESCRIPTION
Restores inbound provisioning mapping from a file created by the backup cmdlet.

.EXAMPLE
Restore-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6

.EXAMPLE
Restore-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6 -RestoreToDifferentServicePrincipal -File backup2.json
#>
function Restore-InboundProvisioningMapping {
    [CmdletBinding()]
    param (
        # The object ID of the service principal with the Inbound Provisioning API
        [Parameter(Mandatory = $true)]
        [string] $ObjectId,

        # The file to restore from
        [Parameter(Mandatory = $false)]
        [string] $File = "backup.json",

        # Restore to a different service principal
        [Parameter(Mandatory = $false)]
        [switch] $RestoreToDifferentServicePrincipal
    )

    process {
        Write-Verbose "Reading restore file $File"
        $Backup = Get-Content $File | ConvertFrom-Json -Depth 100
        
        $ServicePrincipal = Get-InboundProvisioningServicePrincipal -ObjectId $ObjectId

        $Job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $ServicePrincipal.Id
        $JobSchema = Get-MgServicePrincipalSynchronizationJobSchema -ServicePrincipalId $ServicePrincipal.Id -SynchronizationJobId $Job.Id

        if($Backup.Id -ne $JobSchema.Id) {
            if(!$RestoreToDifferentServicePrincipal.IsPresent) {
                Write-Error "Restoring to different service principal that the backup requires the -RestoreToDifferentServicePrincipal switch"
                return
            }
        } else {
            Write-Verbose "Restoration from $File is for the same job and was backed up"
        }
        
        $body = @{
            "synchronizationRules" = $Backup.SynchronizationRules
            "directories" = New-Object System.Collections.ArrayList
        }

        $ExistingDirectoriesByName = $JobSchema.Directories | Group-Object -AsHashTable -Property Name
        $Backup.Directories | ForEach-Object {
            if($ExistingDirectoriesByName.ContainsKey($_.Name)) {
                if($_.Id -ne $ExistingDirectoriesByName[$_.Name].Id -and !$RestoreToDifferentServicePrincipal.IsPresent) {
                    throw "Restoring to different service principal that the backup requires the -RestoreToDifferentServicePrincipal switch (Id of directories does not match)"
                }

                $_Directory = @{
                    id = $ExistingDirectoriesByName[$_.Name].id
                    name = $_.name
                    objects = $_.objects
                }
                $body.directories.Add($_Directory) | Out-Null
            } else {
                throw "Directory $($_.Name) does not exist in the current schema and cannot be restored"
            }
        }

        $url = "https://graph.microsoft.com/v1.0/servicePrincipals/{0}/synchronization/jobs/{1}/schema" -f $ServicePrincipal.Id, $Job.Id
        Invoke-MgGraphRequest -Method PUT -Uri $url -Body ($body | ConvertTo-Json -Depth 100)
    }
}