function Restore-InboundProvisioningMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ObjectId,

        [Parameter(Mandatory = $false)]
        [string] $File = "backup.json",

        [Parameter(Mandatory = $false)]
        [switch] $RestoreToDifferentServicePrincipal
    )

    process {
        Write-Verbose "Reading restore file $File"
        $Backup = Get-Content $OutputFile | ConvertFrom-Json -Depth 100
        
        Confirm-InboundProvisioningConnection

        $ServicePrincipal = Get-MgServicePrincipal -ServicePrincipalId $ObjectId

        if($ServicePrincipal.ApplicationTemplateId -eq "ec7c5431-5d84-453f-80d3-e3385e284eef") {
            Write-Verbose "Service principal is for synching to Active Directory"
            
            # TODO: Find correct template id for Entra ID as this is created by copilot
        } elseif($ServicePrincipal.ApplicationTemplateId -eq "c3c0e67f-580b-4e9e-9e3f-7f3e1b6a6f9c") {
            Write-Verbose "Service principal is for synching to Entra ID"
        } else {
            throw "Service principal is not for inbound provisioning"
        }

        $Job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $ObjectId
        $JobSchema = Get-MgServicePrincipalSynchronizationJobSchema -ServicePrincipalId $ObjectId -SynchronizationJobId $Job.Id

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

        $url = "https://graph.microsoft.com/v1.0/servicePrincipals/{0}/synchronization/jobs/{1}/schema" -f $ObjectId, $Job.Id
        Invoke-MgGraphRequest -Method PUT -Uri $url -Body ($body | ConvertTo-Json -Depth 100)
    }
}